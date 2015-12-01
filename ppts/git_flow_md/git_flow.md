title: git_flow
speaker: ltl3884
url: https://github.com/ksky521/nodePPT
transition: cards
files: /js/demo.js,/css/demo.css

[slide]

# git_flow
## 演讲者：ltl3884

[slide]

# A successful Git branching model

###荷兰人 Vincent Driessen / nvie

[slide]

* <p style='color:blue'>master:</p> 永远在 production-ready 状态 {:&.rollIn}
* <p style='color:yellow'>develop:</p> 最新的下次发布或者开发状态 (ci nightly build)
* <p style='color:pink'>Feature branches:</p>开发新功能都从develop 分支出来，完成后merge 回develop
* <p style='color:green'>Release branches:</p> 准备要release 的版本，只修bugs。从develop 分支出来，完成后merge 回master 和develop
* <p style='color:red'>Hotfix branches:</p> 等不及release 版本就必须马上修master。会从master 分支出来，完成后merge 回master 和develop


[slide]

![g1](/img/git-model.png)

[slide]

# git flow安装
----

* osx
	```java
	brew install git-flow
	```
* linux
	```java
	apt-get install git-flow
	```
* windows(cygwin)
	```java
	wget -q -O - --no-check-certificate \
'https://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh' | bash
	```

[slide]	

 # 初始化
 ----

 `git flow init`
 ## 关于分支的命名约定的问题,建议使用默认值。

[slide]
 
 # feature
 ----

 * `git flow feature start <name>`
	 ```java
	 新开始一个feature分支
	 ```
 * `git flow feature publish <name>`
   ```java
   将一个本地的feature分支push到远程的仓库中,该命令可用于与团队其他成员合作开发或者备份自己的代码
   ``` 
 * `git flow feature finish <name>`
    ```java
    完成feature,该命令会自动合并该分支到develop分支,并且删除本地分支
    ``` 

[slide]
 
 # release
 ----

 * `git flow release start  <name>`
	 ```java
	 新开始一个release分支
	 ```
 * `git flow release publish <name>`
   ```java
   将一个本地的release分支push到远程的仓库中,该命令可用于与团队其他成员合作开发或者备份自己的代码
   ``` 
 * `git flow release finish <tagname>`
    ```java
    完成release,该命令会自动合并该分支到master分支和develop分支,并且删除本地分支
    ```
[slide]

 # hotfix
 ----

 * `git flow hotfix start  <name>`
   ```java
   新开始一个hotfix分支
   ``` 
 * `git flow hotfix finish <name>` 
   ```java
   完成hotfix,该命令会自动合并该分支到master分支和develop分支,并且删除本地分支
	 ```

[slide]

 #分析git flow命令
 ----
 * `git flow feature start test`
   ```java
   git checkout -b feature/test develop
   ```
 * `git flow feature finish test`
   ```java
   git checkout develop
   git merge feature/test
   git branch -d feature/test
   ```   

[slide]

 #Q/A

[slide]

#Q:如何将修改和删除的文件添加到暂存区?

[slide style='background-color:green']

#使用-u参数 git add -u

[slide]

#Q:如何将文件的部分修改添加到暂存区?

[slide style='background-color:green']

#使用-p参数 {:&.text-left}
#git add --patch/-p <span style='color:yellow'>(path/file)</span>

[slide]

#Q:如何将其他分支中的一个提交合并到我的分支

[slide style='background-color:green']

#git cherry-pick <span style='color:yellow'>commit-id</span>

[slide]

#Q:如何删除远程分支

[slide style='background-color:green']

#git push origin :<span style='color:yellow'>branch-name</span>

[slide]

#Q:如何修改最后一次提交的信息

[slide style='background-color:green']

#git commit --amend

[slide]

#Q:如何切换到最后所在分支

[slide style='background-color:green']

#git checkout - (eg: cd -)

[slide]

#Q:如何显示哪些分支被合并了（或是哪些没有被合并）

[slide style='background-color:green']

#git branch --merged {:&.text-left}
#git branch --no-merged
## git branch --merged | xargs git branch -d

[slide]

#Q:如何从另一个分支获取文件内容而不用切换分支

[slide style='background-color:green']

#git checkout <span style='color:yellow'>branch</span> -- <span style='color:yellow'>path/file</span>

 * git stash改动
 * 切换到那个分支
 * 获取文件的改动
 * 切回工作分支
 * git stash pop
 * 进行编辑

 [slide]

 #谢谢大家

<style>
.text-left{
    text-align:left;
}
</style>








