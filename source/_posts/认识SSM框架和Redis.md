---
title: 认识SSM框架和Redis
tags: [Spring， Spring MVC， MyBatis， Redis]
date: 2018-10-26 14:09:31
permalink: SSM-framework-Redis
categories: Java EE
description:
image: /images/JavaEE/SSM-Redis-framework.jpg
---
<p class="description">文章对以下要点进行总结和归纳：1)了解Spring IoC和Spring AOP的基础概念；2)了解MyBatis的特点；3)了解Spring MVC的特点；4)了解为什么要使用NoSQL(Redis)及Redis的优点；5)掌握SSM和Redis的基本结构框图和各种技术的作用。</p>


<!-- more -->

## Spring框架
Spring框架是Java应用最广的框架，它优秀的理念包括 **IoC** (Inversion of Control， 控制反转)和 **AOP** (Aspect Oriented Programming， 面向切面编程)。
### Spring IoC简介
Spring IoC（Inversion of Control，控制反转）承担了一个资源管理、整合、即插即拔的功能。举个例子，在Java中我们为国家插座设计两种接口，那我们就可以为两种插座分别new两个对象，但是如果要更改上千次这种插座，难道要new很多对象吗？所以不用new的方式创建对象，而是使用配置的方式，然后使用配置的方式，然后让Spring IoC容器自己通过配置去找到插座。
不需要去找资源(Bean)，只要向Spring IoC容器描述所需资源，Spring IoC自己会找到你所需要的资源，这就是Spring IoC的理念。这样就把Bean之间的依赖关系解耦了，更容易写出结构清晰的程序。除此之外，Spring IoC还提供对Java Bean生命周期的管理，可以延迟加载，可以在其生命周期内定义一些行为等，更加有效地使用和管理Java资源。
如果使用new的方式来使用插座，代码如下。
```java 使用插座1
User user = new User();
Socket socket = new Socket1();
user.setSocket(socket);
user.useSocket();
```
这样会有一个弊端，如果使用其他插座，就需要修改代码。可以使用配置的方式代替new的方式创建对象，让Spring IoC容器通过配置去找到插座。
```xml 使用Spring IoC注入插座1个用户
<bean id="socket" class="Socket1" />
<bean id="user" class="xxx.User">
    <spanroperty name="socket" ref="socket" />
</bean>
```
只需要修改XML配置文件，就可以切换：
```diff 切换插座的实现类
- <bean id="socket" class="Socket1" />
+ <bean id="socket" class="Socket2" />
<bean id="user" class="xxx.User">
    <spanroperty name="socket" ref="socket" />
</bean>
```
显然，IoC的目标就是为了管理Bean而存在的。
### Spring AOP
IoC的目标就是为了管理Bean，而Bean是Java面向对象(OOP)的基础设计，比如声明一个用户类、插座类等都是基于面向对象的概念。
有些情况是面向对象没办法处理的。
举个例子，生产部门的订单、生产部门、财务部门三者符合OOP的设计理念。订单发出，生产部门审批通过准备付款，但是财务部门发现订单的价格超支了，需要取消订单。 显然超支限定已经不只是影响财务部门了，还会影响生产部门之前所做的审批，需要把它们作废。把预算超支这个条件称为切面，它影响了订单、生产部门和财务部门3个OOP对象。在现实中，这样的切面条件跨越了3个甚至更多的对象，并且影响了它们的协作。所以只用OOP并不完善，还需要面向切面的编程，通过它去管理在切面上的某些对象之间的协作。
Spring AOP常用于数据库事务的编程，很多情况都如同上而的例子，我们在做完第一步数据库数据更新后，不知道下一步是否会成功，如果下一步失收，会使用数据库事务的回滚功能去回滚事务，使得第一步的数据库更新也作废。
在Spring AOP实现的数据库事务管理中，是以异常作为消息的。在默认的情况下(可以通过Spring的配置修改)，只要Spring接收到了异常信息，它就会将数据库的事务回滚，从而保证数据的一致性。这样我们就知道在Spring的事务管理中只要让它接收到异常信息，它就会回滚事务，而不需要通过代码来实现这个过程。
比如上面的例子，可用一段伪代码来进行一些必要的说明。
```Java Spring AOP处理订单伪代码
private void proceed(Order order) {
    //判断生产部门是否通过订单，数据库记录订单
    boolean pflag = productionDept.isPass(order);
    if(pflag) {//如果生产部门通过进行财务部门审批
        if (financialDept.isOverBudget(order)) {//财务审批是否超限
            //抛出异常回滚事务，之前的订单操作也会被回滚
            throw new RuntimeException("预算超限！！");
        }
    }
}
```
Spring AOP的编程屏蔽了数据库代码，只需关注业务代码，知道只要发生了一场异常，Spring会回滚事务就足够了。

## MyBatis简介
MyBatis的前身是Apache的开源项目iBatis，是一个基于 Java的持久层框架。2010年这个项目由Apache software foundation迁移到Google code，并更名为MyBatis。2013年11月，MyBatis迁移到GitHub上，目前由GitHub提供维护。
MyBatis的优势在于灵活，它几乎可以代替JDBC，同时提供了接口编程。目前MyBatis的数据访问层 DAO(Data Access Objects)是不需要实现类的，它只需要一个接口和XML(或者注解)。MyBatis提供自动映射、动态SQL、级联、缓存、注解、代码和SQL分离等特性，使用方便，同时也可以对SQL进行优化。因为其具有封装少、映射多样化、支持存储过程、可以进行SQL优化等特点，使得它取代了Hibernate成为了Java互联网中首选的持久框架。
Hibernate作为一种十分流行的框架，它有其无可替代的优势，这里我们有必要讨论一下它和MyBatis的区别。由于MyBatis和Hibernate都是持久层框架，都会涉及数据库，所以首先定义一个数据库表一角色表(t_role)。
```sql 角色表的sql语句
create table t_role(
    编号 int(12) primary key，
    角色名称 varchar(60)，
    备注 varchar(1024)
);
```
用一个POJO(Plain Ordinary Java Object)和这张表定义的字段对应起来。
```Java 定义角色POJO
package com.learn.chapter1.pojo;
public class Role implements java.io.Serializable {
    private Integer id;
    private String roleName;
    private String note;
    /**
    * setter and getter
    **/
}
```
无论是MyBatis还是Hibernate都是依靠某种方法，将数据库的表和POJO映射起来的，这样就可以操作POJO来完成相关的逻辑了。
### Hibernate简介
映射规则

|语言    | 映射方法|
| :----  | :----  |
| MyBatis | 使用注解方式会受到一定的限制，通常使用XML方式实现映射关系|
| Hibernate | XML和注解提供映射规则|
把POJO对象和数据库表相互映射的框架称为对象关系映射(Object Relational Mapping，ORM，或O/RM，或O/R mapping)框架。Hibernate的设计理念是完全面向POJO的，不需要编写SQL就可以通过映射关系来操作数据库，是一种全表映射的体现；MyBatis需要提供SQL去运行。
```xml Hibernate映射文件
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-mapping PUBLIC "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
  "http://www.hibernate.rg/dtd/hibernate-mapping-3.0.dtd">
<hibernate-mapping>
    <class name="com.learn.chapter1.pojo.Role" tbale="t_role">
    <id name="id" type="java.lang.Integer">
        <column name="id" />
        <generator class="identity" />
    </id>
    
    <spanroperty name="roleName" type="string">
        <column name="role_name" length="60" not-null="true" />
    </property>
    
    <spanroperty name="note" type="string">
        <column name="note" length="512" />
    </property> 
    </class>
</hibernate-mapping>
```
首先，对POJO和表t_role进行了映射配置，把两者映射起来了。然后，对POJO进行操作，从而影响t_role表的数据，比如对其增删改查可以按照如下操作。
```Java Hibernate通过Session操作数据库数据
    Session session = null;
    Transaction tx = null;        
    try {
        //打开Session
        session = HibernateUtil.getSessionFactory().openSession();
        //事务
        tx = session.beginTransaction();
        //POJO
        Role role = new Role();
        role.setId(1);
        role.setRoleName("rolename1");
        role.setNote("note1");  //保存
        Role role2 = (Role) session.get(Role.class， 1); //查询
        role2.setNote("修改备注");
        session.update(role2); //更新
        System.err.println(role2.getRoleName());
        session.delete(role2); //删除
        tx.commit(); //提交事务
    } 
    catch (Exception ex) {
        if (tx != null && tx.isActive()) {
            tx.rollback(); //回滚事务
        }
        ex.printStackTrace();
    } 
    finally {
        if (session != null && session.isOpen()) {
            session.close();
        }
    }
```
这里没有SQL，因为Hibernate会根据映射关系来生成对应的SQL。
### MyBatis
可以自己拟定SQL规则，能精确定义SQL，从而符合移动互联网高并发、大数据、高性能、高响应的需求。MyBatis也需要映射文件把POJO和数据库的表对应起来。
```xml MyBatis映射文件
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper   PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.learn.chapter1.mapper.RoleMapper">
    <resultMap id="roleMap" type="com.learn.chaper1.pojo.Role">
        <id property="id" column="id" />
        <result property="roleName" column="role_name" />
        <result property="note" column="note" />
    </resultMap>
    
    <select id="getRole" resultMap="roleMap">
        select id， role_name， note from t_rle where id = #{id}
    </select>
    
    <delete id="deleteRole" parameterType="int">
        delete from t_role where id = #{id}
    </delete>
    
    <insert id="insertRole" parameterType="com.learn.chapter1.pojo.Role">
        insert into t_role(role_name， note) values(#{roleName}， #{note})
    </insert>
    
    <update id="updateRole" parameterType="com.learn.chapter1.pojo.Role">
        update t_role set
        role_name = #{roleName}，
        note = #{note}
        where id = #{id}
    </update> 
</mapper>
```
这里的resultMap元素用于定义映射规则，而实际上MyBatis在满足一定的规则下，完成自动映射，而增删改查对应着insert、delete、select、update四个元素。mapper元素中的namespace属性，要和一个接口的全限定名保持一致，而里面的SQL的id也需要和接口定义的方法完全保持一致，定义MyBatis映射文件。
```Java 定义MyBatis映射文件
package com.learn.chapter1.mapper;
import com.learn.chapter1.pojo.Role;

public interface RoleMapper {
    public Role getRole(Integer id);
    public int deleteRole(Integer id);
    public int insertROle(Role role);
    public int updateROle(Role role);
}
```
定义了MyBatis映射文件，不需要定义一个实现类。
<span style="color:#5073b8;">显然MyBatis在业务逻辑上和Hibernate是大同小异的。其区别在于，MyBatis需要提供接口和SQL，这意味着工作量会比较大，但是由于自定义SQL、映射关系，所以灵活性、可优化性超过了Hibernate。互联网可优化性、灵活性是十分重要的，因为一条SQL的性能可能相差十几倍到几十倍。</span>
### Hibernate和MyBatis的区别
Hibernate和MyBatis的增、删、改、查，对于业务逻辑层来说大同小异，对于映射层而言Hibernate的配置不需要接口和SQL，相反MyBatis是需要的。对于Hibernate而言，不需要编写大量的SQL，就可以完全映射，同时提供了日志、缓存、级联(级联比MyBatis强大)等特性，此外还提供HQL( Hibernate Query Language)对POJO进行操作，使用十分方便，但是它也有致命的缺陷。
由于无须SQL，当多表关联超过3个的时候，通过Hibernate的级联会造成太多性能的丢失，又或者我现在访问一个财务的表，然后它会关联财产信息表，财产又分为机械、原料等，显然机械和原料的字段是不一样的，这样关联字段只能根据特定的条件变化而变化而Hibernate无法支持这样的变化。遇到存储过程，Hibernate只能作罢。更为关键的是性能，在管理系统的时代，对于性能的要求不是那么苛刻，但是在互联网时代性能就是系统的根本，响应过慢就会丧失客户，试想一下谁会去用一个经常需要等待超过10秒以上的应用呢?
以上的问题MyBatis都可以解决，MyBatis可以自由书写SQL、支持动态SQL、处理列表、动态生成表名、支持存储过程。这样就可以灵活地定义查询语句，满足各类需求和性能优化的需要，这些在互联网系统中是十分重要的。
但MyBatis也有缺陷。首先，它要编写SQL和映射规则，其工作量稍微大于Hibernate。 其次，它支持的工具也很有限，不能像Hibernate那样有许多的插件可以帮助生成映射代码和关联关系，而即使使用生成工具，往往也需要开发者进一步简化，MyBatis通过手工编码，工作量相对大些。所以对于性能要求不太苛刻的系统，比如管理系统、ERP等推荐使用Hibernate;而对于性能要求高、响应快、灵活的系统则推荐使用MyBatis。

## Spring MVC简介
也许你还在问为什么使用Spring MVC，Struts 2.x不才是主流吗？看SSH的概念多火!其实很多初学者都混淆了一个概念，SSH时间上指的是Struts 1.x + Spring + Hibernate，这个概念已经有十几年的历史了。在Structs 1.x的时代，Structs1.x是当之无愧的MVC框架的霸主，但是在新的MVC框架涌现的时代，形式已经完全不是这样的了，Structs 2.x借助了Structs 1.x的好名声，让国内开发者认为Structs 2.x是霸主继任者（其实两者在技术上没有任何关系），导致国内的很多程序员大多数学习基于Structs 2.x的框架，有一个貌似很火的概念出来了S2SH(Struts 2.x + Spring + Hibernate)整合开发。
根据JRebel厂商统计，Spring MVC的市场占有率是40%，而Structs 2.x只有可怜的6%。<span style="color:#5073b8;">Spring MVC是目前Java Web框架当之无愧的霸主。</span>
Spring MVC和三层架构是什么关系，可能很多读者会抢答：
MVC：Model + View + Controller (数据模型+视图+控制器)
三层架构：Prensentation tier + Application tier + Data tier（展现层+应用层+数据访问层）
那MVC和三层架构有什么关系呢？但是实际上MVC只存在三层架构的展现层，M实际上是数据模型，是包含数据的对象。在Spring MVC里，有一个专门的类叫Model，用来和V之间的数据交互、传值；V指的是视图页面，包含JSP、freeMarker、Velocity、Thymeleaf、Tile等；C当然就是控制器（Spring MVC的注解@Controller的类）。
而三层架构是整个应用的架构，是由Spring框架负责管理的。一般项目中会有Service层、DAO层，这两个反馈在应用层和数据访问层。
### Java EE应用的分层模型
经典的Java EE架构大致上都可以分为如下几层：
* **Domain Object(领域对象)层**。此层有一系列的POJO(Plain Object Java Object，普通的传统的Java对象)组成，这些对象是该系统的Domain Object(领域对象)，往往包含了各自所需实现的业务逻辑方法。
* **DAO(Data Access Object，数据访问对象)层**。此层由一系列的DAO组件组成，这些DAO实现了对数据库的创建、查询、更新和删除（CRUD）等原子操作。
* **Service(业务逻辑)层**。此层由一系列的业务逻辑对象组成，这些业务逻辑对象实现了系统所需的业务逻辑方法。这些业务逻辑方法可能仅仅用于暴露Domain Object对象所实现的业务逻辑方法，也可能是依赖DAO组件实现的业务逻辑方法。
* **Controller(控制器)层**。此层由一系列控制器组成，这些控制器用于拦截用户请求，并调用业务逻辑组件的业务逻辑方法，处理用户请求，并根据处理结果向不同的表现层组件转发。
* **View(表现)层**。此层由一系列的JSP页面、Velocity页面、PDF文档视图组件组成，负责手机用户请求，并显示处理结果。
### Java EE应用的组件
总体而言，Java EE应用应该大致包括如下几类组件：
* **表现层组件**。主要负责收集用户输入数据，或者想客户显示系统状态。最常用的表现层技术是JSP，但JSP并不是唯一的表现层技术。表现层还可以由Velocity、FreeMarker和Tapestry等技术完成，或者使用普通的应用程序充当表现层组件，甚至可以是小型智能设备。
* **控制器组件**。关于Java EE的MVC框架，其提供了一个前端核心控制器，核心控制器负责拦截用户请求，并将请求转发给用户实现的控制器组件。这些用户实现的控制器组件则负责调用业务逻辑方法，处理用户请求。
* **业务逻辑组件**。这是系统的核心组件，实现系统的业务逻辑。通常，一个业务逻辑方法对应一次用户操作。一个业务逻辑方法应该是一个整体，因此要求对业务逻辑方法增加事务性。业务逻辑方法仅仅实现也呜呜逻辑，不应该进行数据库访问。因此，业务逻辑组件中不应该出现原始的MyBatis、Hibernate和JDBC等API。<span style="color:#5073b8;">最重要的原因是：保证业务逻辑方法的实现与具体的持久层访问技术分离。当系统需要在不同持久层技术之间切换时，系统的业务逻辑组件无序任何改变。</span>
* **DAO组件**。这个类型的对象比较缺乏变化，每个DAO组件都提供Domain Object对象基本的创建、查询、更新和删除等操作，这些操作对应于数据库的CRUD（创建、查询、更新和删除）等原子操作。当然，如果采用不同的持久层访问技术，DAO组件的会完全不同。为了实现业务逻辑组件的实现与DAO组件的实现分离，程序应该为每个DAO组件都提供接口，业务逻辑组件面向DAO接口编程，这样才能提供更好的解耦。
* **领域对象组件**。领域对象（Doamin Object）抽象了系统的对象模型。通常而言，这些领域对象的状态都必须保存在数据库里。因此，每个领域对象通常对应一个或多个数据表，领域对象通常需要提供对数据记录的访问方式。

## 最流行的NoSQL -- Redis
NoSQL(Not Only SQL)存储的数据是半结构化的，Redis成为主要的NoSQL工具。
1. 响应速度快。
2. 支持6种数据类型：字符串、哈希结构、列表、集合、可排序集合和基数。比如字符串可以存储Java基础数据类型，哈希可以存储对象，列表可以存储List对象等。
3. 操作都是原子的。
4. MultiUtility工具：Redis可以再如缓存、、消息传递队列中使用（Reids支持“发布+订阅”的消息模式），在应用程序如Web应用程序绘画、网站页面点击数等任何短暂的数据中使用。

## SSM+Redis结构框图及概述
在Java Web中，以Spring + Spring MVC + MyBatis（SSM）作为主流框架，SSM+Redis的结构框图如下：
![SSM+Redis结构示意图](/images/JavaEE/SSM-Redis-architecture.png)
- Spring IoC承担了一个资源管理、整合、即插即拔的功能。
- Spring AOP可以提供切面管理，特别是书U哭事务管理的功能。
- Spring MVC用于把模型、视图和控制器分层，组合成了一个有机灵活的系统。
- MyBatis提供了一个数据库访问的持久层，通过MyBatis-Spring项目，它便能和Spring无缝对接。
- Redis作为缓存工具，它提供了高速度处理数据和缓存数据的功能，使得系统大部分只需要访问缓存，而无须从数据库磁盘中重复读/写；在一些需要高速运算的场合中，也可以先用它来完成运算，再把数据批量存入数据库，这样便能极大地提升互联网系统的性能和响应能力。

在后面会讲解这些技术的使用方法、原理和优化方法。

<hr />