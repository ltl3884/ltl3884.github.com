---
layout: post
title: "avoid-bundle-exec"
date: 2013-03-22 10:42:29 +0800
comments: true
categories: rails
---

1.为什么会出现bundle exec的情况？

bundle exec这个前缀，是为了保持本地所云行的gem与gemfile里面指定的gem是一致的，否则，会因为版本问题，出现各种小的bug，有时候让开发者无所适从。 为了，消除bundle exec这个前缀的同时，而让本地完全按照gemfile里面所指定的版本执行，所以有了这篇文章。

2.解决方案：RVM与bundler集成

这也是首选方案，如果在Windows环境下开发的话，这个方法并不适合，强烈建议抛弃windows，否则后患无穷。说正题， 为了能够让RVM正确地自动执行本地环境，需要进行如下步骤 运行

    $ rvm get head && rvm reload
    $ chmod +x $rvm_path/hooks/after_cd_bundler
    $ cd ~/rails_projects/sample_app
    $ bundle install --without production --binstubs=./bundler_stubs

这些命令能够神奇地让RVM和Bundler结合在一起，这样就可以确保，像rake和raspec这样的命令，自动并且正确地执行本地环境。

最后, 因为bundler_sutbs是与本地配置有关的文件, 所以最好将其加到.gitignore中