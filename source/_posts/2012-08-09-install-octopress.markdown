---
layout: post
title: "install-octopress"
date: 2012-08-09 17:22:14 +0800
comments: true
categories: octopress
---

Octopress是使用Ruby语言编写的一套建立在jekyll上的博客系统，它有一些很独特的特点：

使用静态页面，不使用数据库； 可以轻松使用makedown标记语言编写文章； 可以与git紧密集成，方便进行博客的版本管理； 可以于Github Pages集成，不需要单独的web hosting，只要你有github帐号即可。 Octopress 安装

在octopress上面有具体的文档，E文好的可以直接

我把我的安装过程整理的下，需要的环境：

*   git
*   Ruby 1.9.2
*   安装Git

首页git是必备的，具体看到github官网上查看帮助文档 ，这个就比较简单了。

### 安装Ruby

Ruby可以利用RVM或者rbenv来安装，很轻松帮你搞定首页Ruby环境，我是用RVM来安装的。

1.  安装 RVM(Ruby Version Manager)

		$ bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)

2.  安装Ruby1.9.2

		rvm install 1.9.2 && rvm use 1.9.2

### 安装Octopress

1.  安装Octopress

		git clone git://github.com/imathis/octopress.git myblog
		cd myblog    //这边会有提示信息，yes就行
		ruby --version  //Ruby的版本需要在1.9.2版本

2.  安装插件等等

		gem install bundler //安装相关附属插件等
		bundle install

3.  安装Octopress 主题

		rake install

4.  修改配置

		修改配置文件_config.yml，修改url、title、subtitle、author等等，
		把评论disqus加上，google+、twitter、Facebook等等，统统都加上。 
		在source下建CNAME文件，

5.  创建github pero

		在github上创建一个repository

6.  本地配置github分支

		rake setup_github_pages 当命令提示你输入github URL时，输入刚才建立的git地址

7.  写文章

		rake new_post["my first blog"] 
		在”myblog/source/_post”下生成一个**.makedown文件，编辑文章即可。

8.  生成，预览

		rake generate
		rake preview
		在本地 http://127.0.0.1:4000 就可在本地调试页面

以后发博客只需要在本地用命令就OK了

