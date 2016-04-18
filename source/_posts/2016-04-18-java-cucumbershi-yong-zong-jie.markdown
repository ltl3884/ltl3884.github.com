---
layout: post
title: "java cucumber使用总结"
date: 2016-04-18 10:47:24 +0800
comments: true
categories: java
---

最近这几个月一直在做java, java在cucumber方面可能不如ROR方便, 也缺少一些有用的工具支持,比如:database_cleaner, factory_girl等, 下面分享一下java在cucumber的一些使用经验


+  以maven项目为例,首先在pom.xml中加入

```xml
		<dependency>
			<groupId>info.cukes</groupId>
			<artifactId>cucumber-java</artifactId>
			<version>1.2.0</version>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>info.cukes</groupId>
			<artifactId>cucumber-junit</artifactId>
			<version>1.2.0</version>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>info.cukes</groupId>
			<artifactId>cucumber-spring</artifactId>
			<version>1.2.0</version>
			<scope>test</scope>
		</dependency>
```

+  创建cucumber的入口文件,在src/test/java文件夹下创建 com.cbss.cucumber.steps.CbssIT

```java
	@RunWith(Cucumber.class)
	@CucumberOptions(plugin = { "pretty", "html:target/cucumber" }, features = { "src/test/resources/features/" })
	public class CbssIT {

	    private static EmbeddedTomcat tomcat = new EmbeddedTomcat();

	    @BeforeClass
	    public static void setup() {
	        if (!tomcat.isRunning()) {
	            tomcat.start();
	            tomcat.deploy("cbss_server");
	            LogFactory.getInstance().getServerLogger().debug("tomcat-start ...");
	        }
	    }

	    @AfterClass
	    public static void teardown() {
	        if (tomcat.isRunning()) {
	            tomcat.stop();
	            LogFactory.getInstance().getServerLogger().debug("tomcat-stop ...");
	        }
	    }

	}
```
EmbeddedTomcat是内嵌的tomcat在cucumber开始前部署项目,下面说一下EmbeddedTomcat的具体实现,在pom.xml中引入包

```xml
    <dependency>
			<groupId>org.apache.tomcat</groupId>
			<artifactId>tomcat-catalina</artifactId>
			<version>8.0.21</version>
		</dependency>
		<dependency>
			<groupId>org.apache.tomcat</groupId>
			<artifactId>tomcat-util</artifactId>
			<version>8.0.21</version>
		</dependency>
		<dependency>
			<groupId>org.apache.tomcat.embed</groupId>
			<artifactId>tomcat-embed-core</artifactId>
			<version>8.0.21</version>
		</dependency>
		<dependency>
			<groupId>org.apache.tomcat.embed</groupId>
			<artifactId>tomcat-embed-jasper</artifactId>
			<version>7.0.8</version>
		</dependency>
```

```java
public class EmbeddedTomcat {
  private Tomcat tomcat;

  public void start() {
    try {
      tomcat = new Tomcat();
      // If I don't want to copy files around then the base directory must be '.'
      String baseDir = ".";
      tomcat.setPort(8080);
      tomcat.setBaseDir(baseDir);
      tomcat.getHost().setAppBase(baseDir);
      tomcat.getHost().setDeployOnStartup(true);
      tomcat.getHost().setAutoDeploy(true);
      tomcat.start();
    } catch (LifecycleException e) {
      throw new RuntimeException(e);
    }
  }

  public void stop() {
    try {
      tomcat.stop();
      tomcat.destroy();
      // Tomcat creates a work folder where the temporary files are stored
      FileUtils.deleteDirectory(new File("work"));
      FileUtils.deleteDirectory(new File("tomcat.8080"));
    } catch (LifecycleException e) {
      throw new RuntimeException(e);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  public void deploy(String appName) {
    tomcat.addWebapp(tomcat.getHost(), "/" + appName, "src/main/webapp");
  }

  public String getApplicationUrl(String appName) {
    return String.format("http://%s:%d/%s", tomcat.getHost().getName(),
        tomcat.getConnector().getLocalPort(), appName);
  }

  public boolean isRunning() {
      return tomcat != null;
  }
}
```

+  在src/test/resources/features/ 下创建一个test.feature文件

```
	# language: zh-CN

	功能: 附属码下发业务逻辑测试

		背景:
			假如已经存基本的信息
			
		场景: 用户没有填写手机号码,不应该注册成功
		    假如存在一个用户
		    而且该用户没有填写电话号码
		    当用户注册
		    那么不应该注册成功
```

+  在eclipse中使用junit运行CbssIT或者在命令行中运行 mvn test -Dtest=com.cbss.cucumber.steps.CbssIT后,会显示未完成的steps,创建一个java文件实现这些steps

```java
  @ContextConfiguration("/cucumber.xml")
  public class XxxSteps
		@假如("^存在一个用户$")
    public void 存在一个用户 throws Throwable {
        ...
    }
  end
```

cucumber.xml为

```xml
	<?xml version="1.0" encoding="UTF-8"?>
	<beans xmlns="http://www.springframework.org/schema/beans"
	       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	       xmlns:context="http://www.springframework.org/schema/context"
	       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd 
	       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd"> 
	 
	 
	    <import resource="classpath:test-applicationContext.xml"/> 
	    
	</beans>
```

在test-applicationContext.xml中可以配置测试的数据库和redis等等
自此cucumber的环境已经基本搭建完成了,下面说一下 database_cleaner, factory_girl 等工具的实现

+  database_cleaner: 创建DataBaseCleaner类

```java
	public class DataBaseCleaner {

	    @Autowired
	    DataSource dataSourceMain;
	    @Autowired
	    RedisFactory redisFactory;

	    public void clean() {
	        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSourceMain);
	        String[] tables = { "table1", "table2", "table3"};
	        jdbcTemplate.execute("SET FOREIGN_KEY_CHECKS=0");
	        for (int i = 0; i < tables.length; i++) {
	            jdbcTemplate.execute("truncate table " + tables[i]);
	        }
	        redisFactory.flushDB();
	    }
```
在场景结束后会执行DataBaseCleaner的clean方法
```java

		@After
    public void afterScenario() throws IOException {
        dataBaseCleaner.clean();
    }

```

+  factory_girl: 创建package:com.cbss.cucumber.factory, 在com.cbss.cucumber.factory包下面创建Builder.java和FactoryGirl.java和UserBuilder.java

```java

public interface Builder<T> {
    
    T build();

}

```

```java

@Component
public class FactoryGirl {
    
    public Builder<?> create(String name) throws InstantiationException, IllegalAccessException, ClassNotFoundException{
        String packageName = FactoryGirl.class.getPackage().getName();
        return (Builder<?>) Class.forName(packageName + "." + name + "Builder").newInstance();
    }
    
}

```

```java
	public class UserBuilder implements Builder<User>{
	    
	    private static int sequenceId = 20094;
	    
	    private static int sequenceUserName = 0;
	    
	    public int getSequenceId() {
	        sequenceId += 1;
	        return sequenceId;
	    }
	    
	    public int getSequenceUserName(){
	        sequenceUserName += 1;
	        return sequenceUserName;
	    }

	    @Override
	    public User build() {
	        User user = new User();
	        user.setId(getSequenceId());
	        user.setName("user" + getSequenceUserName());
	        user.setXXX("xxx");
	        ...
	        ...
	        return user;
	    }
	    
	}
```

创建user的时候可以调用

```java
	User user = (User)factoryGirl.create("User");
```

避免了像以下这样的重复代码
```
	User user = new User()
	user.setId(id);
	user.setName(name)
	user.setXxx("xxx");
	...
	...
```







