---
layout: post
title: "在OSX上修改用homebrew安装的mysql的bind-ip"
date: 2016-09-20 15:20:55 +0800
comments: true
categories: mysql
---

使用homebrew安装的mysql默认bind-ip是127.0.0.1
homebrew安装的mysql是launchctl管理的
首先找到mysql.plist这个文件
```
	locate mysql.plist
```
我的mysql.plist在/usr/local/Cellar/mysql/5.6.22/homebrew.mxcl.mysql.plist
编辑mysql.plist修改bind-address=0.0.0.0
```
	launchctl unload /usr/local/Cellar/mysql/5.6.22/homebrew.mxcl.mysql.plist
	launchctl load /usr/local/Cellar/mysql/5.6.22/homebrew.mxcl.mysql.plist
```
之后运行
```
	launchctl list|grep mysql
```
查看launchctl中mysql的pid
```
	56047	1	homebrew.mxcl.mysql
```
56047就是pid  如果56047为-的话运行
```
	launchctl start homebrew.mxcl.mysql
```