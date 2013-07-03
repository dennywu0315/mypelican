
看书看到rsync相关的内容，于是自己做了个小实验，巩固一下知识点。

- 简介

rsync是类unix系统下的数据镜像备份工具，从软件的命名上就可以看出来了——remote sync。

- 特性

它的特性如下：
可以镜像保存整个目录树和文件系统。
可以很容易做到保持原来文件的权限、时间、软硬链接等等。
无须特殊权限即可安装。
快速：第一次同步时 rsync 会复制全部内容，但在下一次只传输修改过的文件。rsync 在传输数据的过程中可以实行压缩及解压缩操作，因此可以使用更少的带宽。
安全：可以使用scp、ssh等方式来传输文件，当然也可以通过直接的socket连接。
支持匿名传输，以方便进行网站镜象。

- 实战

作为镜像备份，至少需要一台服务端与一台客户端。 两台机器上都需要安装rsync，通常很多Linux发行版是默认包括这个软件的。

源码包安装：
    
     #tar xvf rsync-XXX.tar.gz
     #cd rsync-XXX
     #./configure --prefix=/usr ; make ; make install

在开展备份之前，首先要在服务器端做好配置。 对应的文件为rsyncd.conf（主配置文件）/rsyncd.secrets（密码文件）/rsyncd.motd（服务器信息）。我把它们放在/etc/rsyncd/文件夹下统一管理。

这些文件默认不存在，需要手动创建

     #touch /etc/rsyncd.conf
     #touch /etc/rsyncd.secrets
     #chmod 600 /etc/rsyncd.secrets  #需要调整权限，否则同步将失败
     #touch /etc/rsyncd.motd

首先配置rsyncd.conf， 我想要备份的是/root/dywu/shtool 文件夹，但是不包括WF子文件夹。


    pid file = /var/run/rsyncd.pid                  #此文件将会记录rsync进程的pid号
    port = 873                                            #默认端口873
    address = 172.29.175.193
    #uid = nobody
    #gid = nobody  
    uid = root
    gid = rootuse chroot = yes
    read only = yes
    
    #limit access to private LANs
    hosts allow=172.29.174.131                    #这里设定允许/拒绝同步的客户端ip或者网段
    hosts deny=*                                             
    
    max connections = 5
    motd file = /etc/rsyncd/rsyncd.motd          #服务端信息
    
    #This will give you a separate log file
    #log file = /var/log/rsync.log
    
    #This will log every file transferred - up to 85,000+ per user, per sync
    #transfer logging = yes
    
    log format = %t %a %m %f %b
    syslog facility = local3
    timeout = 300
    
    [rhelshtool]                                             #模块定义
    path = /root/dywu/shtool
    list=yes
    ignore errors
    auth users = root                                     #认证用户
    secrets file = /etc/rsyncd/rsyncd.secrets
    comment = This is shell tool data
    exclude = WF/                                         #排除的文件夹

配置完之后，启动服务。
     
     #/usr/bin/rsync --daemon  --config=/etc/rsyncd/rsyncd.conf
     
查看启动成功与否

     # lsof -i:873
     COMMAND  PID USER   FD   TYPE   DEVICE SIZE NODE NAME
     rsync   4590 root    3u  IPv6 36209018       TCP *:rsync (LISTEN)
     rsync   4590 root    5u  IPv4 36209019       TCP *:rsync (LISTEN)
     
来到客户端机器，通过rsync命令同步服务器端文件夹。
简单语法通过man命令来查询：

	SYNOPSIS
       rsync [OPTION]... SRC [SRC]... [USER@]HOST:DEST

       rsync [OPTION]... [USER@]HOST:SRC DEST

       rsync [OPTION]... SRC [SRC]... DEST

       rsync [OPTION]... [USER@]HOST::SRC [DEST]

       rsync [OPTION]... SRC [SRC]... [USER@]HOST::DEST

       rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]

       rsync [OPTION]... SRC [SRC]... rsync://[USER@]HOST[:PORT]/DEST

来看rsync的一些基本概念：

rsync有六种不同的工作模式：

 

    1. 拷贝本地文件；当SRC和DES路径信息都不包含有单个冒号":"分隔符时就启动这种工作模式。
    2. 使用一个远程shell程序（如rsh、ssh）来实现将本地机器的内容拷贝到远程机器。当DST路径地址包含单个冒号":"分隔符时启动该模式。
    3. 使用一个远程shell程序（如rsh、ssh）来实现将远程机器的内容拷贝到本地机器。当SRC地址路径包含单个冒号":"分隔符时启动该模式。
    4. 从远程rsync服务器中拷贝文件到本地机。当SRC路径信息包含"::"分隔符时启动该模式。
    5. 从本地机器拷贝文件到远程rsync服务器中。当DST路径信息包含"::"分隔符时启动该模式。
    6. 列远程机的文件列表。这类似于rsync传输，不过只要在命令中省略掉本地机信息即可。   -a 以archive模式操作、复制目录、符号连接 相当于-rlptgoD

rsync中的参数


    -r 是递归
    -l 是链接文件，意思是拷贝链接文件；-p 表示保持文件原有权限；-t 保持文件原有时间；-g 保持文件原有用户组；-o 保持文件原有属主；-D 相当于块设备文件；
    -z 传输时压缩；
    -P 传输进度；
    -v 传输时的进度等信息，和-P有点关系，自己试试。可以看文档；
    -e ssh的参数建立起加密的连接。
    -u只进行更新，防止本地新文件被重写，注意两者机器的时钟的同时
    --progress是指显示出详细的进度情况
    --delete是指如果服务器端删除了这一文件，那么客户端也相应把文件删除，保持真正的一致
    --password-file=/password/path/file来指定密码文件，这样就可以在脚本中使用而无需交互式地输入验证密码了，这里需要注意的是这份密码文件权限属性要设得只有属主可读。

首先列出rsync服务器端提供的同步内容：

    # rsync  root@172.29.175.193::  #通常需要加上 --list-only 参数，视版本而定
    
    ++++++++++++++++++++++++++++++++++++++++++++++
      Welcome to use the dywu test rsync services!
               2013--??
      ++++++++++++++++++++++++++++++++++++++++++++++
    
    rhelshtool      This is shell tool data
    
出现了服务器端设定好的文件夹资源，说明配置成功，接下来开始同步
    
    # rsync -avzP root@172.29.175.193::rhelshtool rhelshtool  
    ++++++++++++++++++++++++++++++++++++++++++++++
      Welcome to use the dywu test rsync services!
               2013--??
      ++++++++++++++++++++++++++++++++++++++++++++++
    
    
    Password: 
    
    #此处输入rsync.secrets中设定好的密码。
    
    
    receiving file list ...
    233 files to consider
    created directory rhelshtool
    ./
    .git/
    .git/branches/
    .git/hooks/
    .git/info/
    .git/logs/
    .git/logs/refs/
    .git/logs/refs/heads/
    .git/logs/refs/remotes/
    
    …                #略去文件列表
    pipe/output
             446 100%   12.81kB/s    0:00:00  (134, 98.3% of 233)
    pipe/passwd
             535 100%   15.37kB/s    0:00:00  (135, 98.7% of 233)
    taglist/taglist.sh
             594 100%   17.06kB/s    0:00:00  (136, 99.6% of 233)
    taglist/xml
            8988 100%  250.78kB/s    0:00:00  (137, 100.0% of 233)
    
    sent 2856 bytes  received 96876 bytes  66488.00 bytes/sec
    
    total size is 209638  speedup is 2.10

至此，同步成功。

命令中若带有 --delete 参数，则表示客户端上的数据要与服务器端完全一致，如果目录中有服务器上不存在的文件，则删除。最终目的是让目录上的数据完全与服务器上保持一致；用的时候要 小心点，最好不要把已经有重要数所据的目录，当做本地更新目录，否则会把你的数据全部删除。

生产环境下经常会将rsync配置为cron job，此时需要加上 --password-file 参数。

当我们以root用户登录rsync服务器同步数据时，密码将读取rsyncd.secrets这个文件。这个文件内容只是root用户的密码。我们要如下做；

  

    # touch rsyncd.secrets
    # chmod 600 rsyncd.secrets          #注意权限设置
    # echo "dywu"> rsyncd.secrets
        
    # rsync -avzP  --delete  --password-file=rsyncd.secrets  root@172.29.175.193::rhelshtool rhelshtool  

这样的话就省略了交互输入密码的阶段，简单的配置crontab之后，就可以实现定期备份的功能了。

另外，自己写了个简单的脚本用来管理rsync进程。 如下：


