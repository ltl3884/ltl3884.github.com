---
layout: post
title: "Ruby中的||=操作符"
date: 2013-07-22 10:56:34 +0800
comments: true
categories: ruby
---

```ruby
def current_user 
  @current_user ||= session[:user_id] && User.find(session[:user_id]) 
end
```


短短一行代码，却含有很多逻辑，以前老是搞混，这里总结一下。

这句代码相当于

```ruby
    def current_user
        if @current_user
           return @current_user
        else
           if session[:user_id]
              @current_user = User.find(session[:user_id])
           else
              @current_user = nil
           end
           return @current_user
        end
    end
```

展开后的代码看起来很恶心，代码意思为：如果@current_user不为空直接返回@current_user。 如果@current_user为空，则根据session中的user_id判断是否登录，如果已经登录则查找出用户信息并返回。如果没有登录则返回空。

这里总结下各符号用法： and 与 && 为和，区别是and优先级比&&低。 or 与 || 为或，not与!为非，区别均是前者优先级低于后者 &&=, !=, ||=这个比较灵活，以前习惯用Java，可以认为它相当于Java里的+=,-=。 a &&= b即为a = a && b。可见Ruby比Java灵活很多。

Ruby的&&, ||与其它语言有些不同。 &&运算法则为：左边为false或nil时，直接分别返回false或nil，右边将不会运算。 左边不为false或nil时，返回右边的对象。 ||运算法则为：左边为false或nil时，返回右边的对象。 左边不为false或nil时，直接返回左边的对象，右边的不会运算。 我整理了几个例子:

```ruby
    puts false && "abc"      # => false
    puts nil   && "abc"      # => nil

    puts true  && "abc"      # => "abc"
    puts "123" && "abc"      # => "abc"

    puts false || "abc"      # => "abc"
    puts nil   || "abc"      # => "abc"

    puts true  || "abc"      # => true
    puts "123" || "abc"      # => "123"
```

如果你想深入请看下面，不深入就算了 其实||=这个运算符里面比较复杂，或者说有点乱。 x ||= y 相当于 x || x=y 而不是 x = x||y 区别在于如果x存在且不为空时不会执行任何操作，直接返回。 还相当于

```ruby
    if defined? x
        x || x=y
    else
        x = y
    end
```