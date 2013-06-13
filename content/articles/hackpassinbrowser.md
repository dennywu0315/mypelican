Title:Hack saved passwords in browsers 
Date: 2013-5-10 20:35 
Category: tech 
Author: DennyW 
Tags:html,chrome

>出于方便的目的，经常会使用浏览器保存一些常用的自动填表的数据。 不过可能过了几个月以后自己也不记得保存的密码是啥， 于是还要费时费力的找回或者重新注册。 今天看到一个简单的方法可以省去一些麻烦。

以Chrome为例。
光标定位在密码栏中，右键选择`Inspect element`打开控制台。

![sample][1]

找到`type`项，双击值`password`，然后修改。

![sample2][2]

修改为`text`，回车， 明文密码就出现了。

![sample3][3]


  [1]: http://ntu.me/di/8SIA/Capture.jpg
  [2]: http://ntu.me/di/ZOTB/Capture2.jpg
  [3]: http://ntu.me/di/O2YG/Capture3.jpg


当然， 如果是Chrome的话，其实设置项目中就能看到保存好的所有密码，并且可以显示为明文，总觉得不太安全。
