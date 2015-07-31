title: git
speaker: ltl3884
url: http://ltl3884.me
transition: zoomin
files: /js/zoom.js
theme: moon

[slide]

# git
## 演讲者：ltl3884

[slide]

##Agenda
----

* git使用
* git设置

[slide]

## git和svn的比较
----

* GIT是分布式的，SVN不是 {:&.rollIn}
 ```
 分布式版本控制Bitkeeper, Mercurial
 ```
* Git直接记录快照，而非差异比较
* GIT分支和SVN的分支不同
  ```
  分支在SVN中一点不特别，就是版本库中的另外的一个目录。如果你想知道是否合并了一个分支，
  你需要手工运行像这样的命令svn propget svn:mergeinfo，来确认代码是否被合并
  ```

[slide]

![g1](/img/g1.png)
![g2](/img/g2.png)

[slide]

#创建新仓库
----

创建新文件夹，打开，然后执行

`git init`

以创建新的 git 仓库。

[slide]

#检出仓库
----

执行如下命令以创建一个本地仓库的克隆版本：

`git clone /path/to/repository`

如果是远端服务器上的仓库，你的命令会是这个样子：

`git clone username@host:/path/to/repository`

[slide]

#工作流
----

你的本地仓库由 git 维护的三棵“树”组成。

第一个是你的`工作目录`，它持有实际文件；

第二个是 `缓存区（Index）`，它像个缓存区域，临时保存你的改动；

最后是 `HEAD`，指向你最近一次提交后的结果。

![g3](/img/g3.png)

[slide]

#添加与提交
----

你可以计划改动（把它们添加到缓存区），使用如下命令：

`git add <filename>`

`git add .`

这是 git 基本工作流程的第一步；使用如下命令以实际提交改动：

`git commit -m "代码提交信息"`

现在，你的改动已经提交到了 HEAD，但是还没到你的远端仓库。

[slide]

#推送改动
----

你的改动现在已经在本地仓库的 HEAD 中了。

执行如下命令以将这些改动提交到远端仓库：

`git push origin master`

可以把 master 换成你想要推送的任何分支。

[slide]

#分支
----

分支是用来将特性开发绝缘开来的。

在你创建仓库的时候，master 是“默认的”。

在其他分支上进行开发，完成后再将它们合并到主分支上。

创建一个叫做“feature_x”的分支，并切换过去：

`git checkout -b feature_x`/`git br feature_x`

`git commit -m 'xx'`

...

...

切换回主分支：
`git checkout master`

合并feature_x:
`git merge feature_x`

再把新建的分支删掉：
`git branch -d feature_x`

除非你将分支推送到远端仓库，不然该分支就是 不为他人所见的：

`git push origin feature_x`

[slide]

#更新与合并
----

要更新你的本地仓库至最新改动，执行：

`git pull origin <branch>`

以在你的工作目录中 获取（fetch） 并 合并（merge） 远端的改动。

要合并其他分支到你的当前分支（例如 master），执行：

`git merge <branch>`

两种情况下，git 都会尝试去自动合并改动。不幸的是，自动合并并非次次都能成功，并可能导致 冲突（conflicts）。 这时候就需要你修改这些文件来人肉合并这些 冲突（conflicts） 了。改完之后，你需要执行如下命令以将它们标记为合并成功：

`git add <filename>`

[slide]

#撤销改动
----

git有2种撤销`git revert`和`git reset`

`git revert`:回退某次提交，并产生一次新提交，

```
commit3:  add test3.rb  
commit2:  add test2.rb  
commit1:  add test1.rb 
```

执行`git revert HEAD^`之后

```
commit4:  Reverts “test2.rb”  
commit3:  add test3.rb  
commit2:  add test2.rb  
commit1:  add test1.rb 
```

[slide]

`git reset`:回退某次提交，同时回退修改log，

但是修改内容回退到本地暂存区，

```
commit3:  add test3.rb  
commit2:  add test2.rb  
commit1:  add test1.rb 
```

 执行`git reset HEAD^`之后

```
commit2:  add test2.rb  
commit1:  add test1.rb 
```

test3.rb 在暂存区

执行`git reset --hard HEAD^`之后

```
commit2:  add test2.rb  
commit1:  add test1.rb 
```

test3.rb不在暂存区 


[slide]
##替换本地改动
----

`git checkout -- <filename>`

此命令会使用 HEAD 中的最新内容替换掉你的工作目录中的文件。

已添加到缓存区的改动，以及新文件，都不受影响。

[slide]
#stash

当你在feature_x分支上开发一个x功能,突然在master分支上有一个bug需要fix.

`git stash`

`git checkout master`

修改bug,并提交

`git checkout feature_x`

`git stash pop`

[slide]

#gitconfig设置
----

打开~/.gitconfig 

```
[user]
        name = ltl3884
        email = ltl3884@gmail.com
[color]
        ui = true
[alias]
        st = status
        co = checkout
        br = branch
```

[slide]

#gitignore设置
----

在项目根目录下添加.gitignore
```
1. 以斜杠“/”开头表示目录；
2. 以星*”通配多个字符；
3. 以问号“?”通配单个字符
4. 以方括号“[]”包含单个字符的匹配列表；
5. 以叹号“!”表示不忽略(跟踪)匹配到的文件或目录；
```
此外，git 对于 .ignore 配置文件是按行从上到下进行规则匹配的，意味着如果前面的规则匹配的范围更大，则后面的规则将不会生效；

[slide]
#gitignore例子

* 规则：fd1/*
```
忽略目录 fd1 下的全部内容；注意，不管是根目录下的 /fd1/ 目录，
还是某个子目录 /child/fd1/ 目录，都会被忽略；
```
* 规则：/fd1/*
```
说明：忽略根目录下的 /fd1/ 目录的全部内容；
```
* 规则：/*

	!.gitignore

	!/fw/bin/

	!/fw/sf/
```
说明：忽略全部内容，但是不忽略 .gitignore 文件、根目录下的 /fw/bin/ 和 /fw/sf/ 目录；
```

[slide]
#git命令行设置
----

打开~/.bashrc


增加颜色配置
```
export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'
```

[slide]

修改PS1
```
export PS1="\[${COLOR_GREEN}\]\u@\h\[${COLOR_BLUE}\]\w\\[${COLOR_NC}\]\[\033[01;31m\]\$(parse_git_branch)\[${COLOR_BLUE}\]$\[${COLOR_NC}\]"
```

增加parse_git_branch方法
```shell
	parse_git_branch() {
	  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
	}
```

![g4](/img/g4.png)

[slide]

#git自动完成

打开~/.bashrc

增加一行  source ~/[.git-completion.bash](http://ltl3884.me/downloads/git-completion.bash)

[slide]

#**谢谢大家**