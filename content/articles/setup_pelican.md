Title:Pelican + Git Page的Blog架设 
Date: 2013-4-10 12:40
Category: tech
Tags: Git,Python
Author: DennyW

之前尝试了购买主机空间加上WordPress的组合，弄好了以后基本很少上了。部署完以后全图形化界面的操作总感觉少了点「Geek」的感觉。
后来看到某篇文章，说的是利用Github提供的pages服务（免费而且无限制），正好原来的空间也差不多到期了，于是就趁着空闲时间尝试搭建了一下，的确非常方便。

**自己的系统： `Mac OSX 10.8.3`**

搭建的过程和Linux环境下基本相同。

**首先安装`PIP`**

    $ curl -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py
    $ python get-pip.py

**安装pelican以及markdown**

    $ pip install pelican
    $ pip install Markdown

**建立blog目录**

    $ mkdir myblog
    $ cd myblog

**开始创建**

    $ pelican-quickstart

基本按照提示设置就可以，稍后可以在pelicanconf.py文件中手动修改。

**Github上的准备**

在Github上创建一个新项目，把这个项目clone到myblog文件夹下。然后按照Github的规定建立一个没有父节点的分支gh-pages。

    $ git checkout --orphan gh-pages

**完工**

然后就可以利用pelican写博客了。以markdown举例：

进入content目录，创建一个md文件，写入内容

    Title: My super title
    Date: 2010-12-03 10:20
    Category: Python
    Tags: pelican, publishing
    Slug: my-super-post
    Author: Alexis Metaireau
    Summary: Short version for index and feeds

    This is the content of my super blog post.

保存退出，用如下命令发布。

    $ pelican -s pelicanconf.py content -o myblog

pelican会将content中的元文件编译为html的静态页面，进入myblog子目录，提交到Github。

    $ git add .
    $ git commit -m "first blog"
    $ git push -u origin gh-pages

访问访问`http://username.github.com/myblog/`就可以看到Blog。

pelican还支持很多的主题以及插件的应用， 参考文档便可以简单配置。
相比于WP，pelican发布blog稍显繁琐，同时有多个工作环境的情况下也需要一直同步内容。不过整体思路还是非常值得肯定的。适合所有喜爱尝试，不怕麻烦的人们。

