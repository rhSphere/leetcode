---
title: 剑指Offer(2) 实现Singleton模式
tags: [DPModel, Singleton, volatile]
date: 2019-03-21 15:47:17
permalink: singleton
categories: 剑指Offer
description:
---
<p class="description">饿汉模式不会出现产生多个实例的情况，见单例模式的通用代码。懒汉模式在volatile关键字修饰后，使用双重锁机制，可以解决多个实例被构建的情况，以及由于指令重排而导致的返回一个没有初始化完成的singleton对象。 实现单例模式的手段非常多，还有通过静态内部类实现的方法。 但是上述方法存在共同的问题： 无法防止利用反射来重复构建对象。 阻止反射的构建方式是使用枚举类型，有了enum语法糖，JVM会阻止反射获取枚举类的私有构造方法。 最后还有使用工厂方法模式替代单例模式，当然，其他类也可以通过反射的方式构建一个单例模式。 本文还简单的总结了volatile的两种语义的使用。</p>


<!-- more -->

## DPModel中单例模式

### 单例模式的通用代码(线程安全)
如果单例初始值是null，还未构建，则构建单例对象并返回。这个写法属于单例模式当中的懒汉模式。
如果单例对象一开始就被new Singleton()主动构建，则不再需要判空操作，这种写法属于饿汉模式。


```java 单例模式的通用代码(饿汉模式)
public class Singleton {
    private static Singleton singleton = new Singleton();

    private Singleton(){

    }

    public static Singleton getInstance() {
        return singleton;
    }

    public static void doSomething() {

    }
}
```

### 线程不安全的单例模式
- 假设Singleton类刚刚被初始化，singleton对象还是空，这时候两个线程同时访问getInstance方法
- 因为singleton对象为空，所以两个线程同时通过了条件判断，开始执行new操作
- 这样一来，显然instance被构建了两次。

```java 线程不安全的单例(懒汉模式)
public class Singleton {
    private static Singleton singleton = null;

    private Singleton() {}

    public static Singleton getInstance() {
        if (singleton == null) {
            singleton = new Singleton();
        }
        return singleton;
    }
}
```


## 单例模式第二版(双重检测机制)
### 单例模式第二版
两次判空的机制叫做双重检测机制。 但是不是绝对的安全！！！
```java 双重检测
public class Singleton {
    private static Singleton singleton = null;

    private Singleton() {

    }

    public static Singleton getInstance() {
        if (singleton == null) {  //双重检测
            synchronized (Singleton.class) {  //同步锁
                if (singleton == null) {  //双重检测
                    singleton = new Singleton();
                }
            }
        }
        return singleton;
    }
}
```

1. 为了防止new Singleton被执行多次，因此在new操作之前加上Synchronized 同步锁，锁住整个类（注意，这里不能使用对象锁）；
2. 进入Synchronized 临界区以后，还要再做一次判空。因为当两个线程同时访问的时候，线程A构建完对象，线程B也已经通过了最初的判空验证，不做第二次判空的话，线程B还是会再次构建instance对象。

### 隐藏的漏洞(指令重排)
！！！！隐藏的漏洞
假设这样的场景，当两个线程一先一后访问getInstance方法的时候，当A线程正在构建对象，B线程刚刚进入方法。
这种情况表面看似没什么问题，要么singleton还没被线程A构建，线程B执行 if（singleton == null）的时候得到true；要么singleton已经被线程A构建完成，线程B执行 if（singleton == null）的时候得到false。

真的如此吗？答案是否定的。这里涉及到了JVM编译器的 **指令重排**。

指令重排是什么意思呢？比如java中简单的一句 singleton = new Singleton，会被编译器编译成如下JVM指令：

memory =allocate();    //1：分配对象的内存空间 
ctorInstance(memory);  //2：初始化对象 
singleton =memory;     //3：设置instance指向刚分配的内存地址 

但是这些指令顺序并非一成不变，有可能会经过JVM和CPU的优化，指令重排成下面的顺序：

memory =allocate();    //1：分配对象的内存空间 
singleton =memory;     //3：设置instance指向刚分配的内存地址 
ctorInstance(memory);  //2：初始化对象 



当线程A执行完1,3,时，singleton对象还未完成初始化，但已经不再指向null。此时如果线程B抢占到CPU资源，执行  if（singleton ==  null）的结果会是false，从而返回一个 **没有初始化完成的singleton对象**。

如何避免这一情况呢？我们需要在instance对象前面增加一个 **修饰符volatile**。

## 单例模式第三版(volatile关键字加双重检测)

```java volatile实现
public class Singleton {
    private volatile static Singleton singleton = null;

    private Singleton() {

    }

    public static Singleton getInstance() {
        if (singleton == null) {  //双重检测机制
            synchronized (Singleton.class) {  //同步锁
                if (singleton == null) {  //双重检测机制
                    singleton = new Singleton();
                }
            }
        }
        return singleton;
    }
}
```
经过volatile的修饰，当线程A执行singleton = new Singleton的时候，JVM执行顺序是什么样？始终保证是下面的顺序：

memory =allocate();    //1：分配对象的内存空间
ctorInstance(memory);  //2：初始化对象 
singleton =memory;     //3：设置instance指向刚分配的内存地址 

如此在线程B看来，singleton对象的引用要么指向null，要么指向一个初始化完毕的Singleton，而不会出现某个中间态，保证了安全。

## 静态内部类实现方式

```java
public class Singleton {   

    private static class LazyHolder {
        private static final Singleton SINGLETON = new Singleton();
    }

    private Singleton() {

    }

    public static Singleton getInstance() {
        return LazyHolder.SINGLETON;
    }
}
```
这里有几个需要注意的点：

1. 从外部无法访问静态内部类LazyHolder，只有当调用Singleton.getInstance方法的时候，才能得到单例对象SINGLETON。

2. SINGLETON对象初始化的时机并不是在单例类Singleton被加载的时候，而是在调用getInstance方法，使得静态内部类LazyHolder被加载的时候。因此这种实现方式是利用 **classloader的加载机制**来实现懒加载，并保证构建单例的线程安全。

**!!!!缺点：无法防止利用反射来重复构建对象。 这也是单例模式共同的问题。**


## 使用工厂方法模式(利用反射打破单例)


```java 单例类
public static Singleton {
    private Singleton() {
    }

    public void doSomething{
    }
}
```

```java 通过反射方式创建单例的工厂类
public class SingeltonFactory {
    private static Singleton singleton;

    static {
        try {
            Class c1 = Class.forName(singleton.class.getName());
            Constructor constructor = c1.getDeclaredConstructor();
            constructor.setAccessible(true);

            singleton = (Singleton) constructor.newInstance();
        } catch (Exception e) {
            // 异常处理
        }
    }

    public static Singleton getInstance() {
        return singleton;
    }
}
```

```java
//获得构造器
Constructor con = Singleton.class.getDeclaredConstructor();
//设置为可访问
con.setAccessible(true);
//构造两个不同的对象
Singleton singleton1 = (Singleton)con.newInstance();
Singleton singleton2 = (Singleton)con.newInstance();
//验证是否是不同对象
System.out.println(singleton1.equals(singleton2));
```

代码可以简单归纳为三个步骤：

第一步，获得单例类的构造器。
第二步，把构造器设置为可访问。
第三步，使用newInstance方法构造对象。

最后为了确认这两个对象是否真的是不同的对象，我们使用equals方法进行比较。毫无疑问，比较结果是false。

## 无懈可击的单例模式(枚举类实现)

```java
public enum SingletonEnum {
    SINGLETON;
}
```

让我们来做一个实验，仍然执行刚才的反射代码：

```java
//获得构造器
Constructor con = SingletonEnum.class.getDeclaredConstructor();
//设置为可访问
con.setAccessible(true);
//构造两个不同的对象
SingletonEnum singleton1 = (SingletonEnum)con.newInstance();
SingletonEnum singleton2 = (SingletonEnum)con.newInstance();
//验证是否是不同对象
System.out.println(singleton1.equals(singleton2));
```

执行获得构造器这一步的时候，抛出了异常。

唯一的缺点是，并非适用懒加载，其单例对象是在枚举类被加载的时候进行初始化的。



## 单例模式实现简单总结

|单例模式实现|是否线程安全|是否懒加载|是否防止反射构建|
|------|-----|-----|------|
|双重锁检测(第三版)|是|是|否|
|静态内部类|是|是|否|
|枚举|是|否|是|

几点补充：
1. volatile关键字不但可以防止指令重排，也可以保证线程访问的变量值是主内存中的最新值。
2. 使用枚举实现的单例模式，不但可以防止利用反射强行构建单例对象，而且可以在枚举类对象被反序列化的时候，保证反序列的返回结果是同一对象。
3. 对于其他方式实现的单例模式，如果既想要做到可序列化，又想要反序列化为同一对象，则必须实现readResolve方法。

## 枚举

C/C++ 的枚举类型是int类型常量值，不安全。

java在1.5 加入枚举。

- 枚举是类，枚举常量是类的对象，在枚举类外无法创建枚举对象，可以保证枚举的类型安全性
- 所有的枚举类都继承自java.lang.Enum，并且所有的枚举类都声明为final，每个枚举常量都声明为public static final，我们不能显示地继承Enum类
- 枚举类实例初始化中不能访问静态变量（枚举类特殊初始化方式：构造器先于静态初始化）

## volatile关键字
### Java内存模型
Java内存模型简称JMM（Java Memory Model），是Java虚拟机所定义的一种抽象规范，用来屏蔽不同硬件和操作系统的内存访问差异，让java程序在各种平台下都能达到一致的内存访问效果。

1. 主内存（Main Memory）
主内存可以简单理解为计算机当中的内存，但又不完全等同。主内存被所有的线程所共享，对于一个共享变量（比如静态变量，或是堆内存中的实例）来说，主内存当中存储了它的“本尊”。

2. 工作内存（Working Memory）
工作内存可以简单理解为计算机当中的CPU高速缓存，但又不完全等同。每一个线程拥有自己的工作内存，对于一个共享变量来说，工作内存当中存储了它的“副本”。

线程对共享变量的所有操作都必须在工作内存进行，不能直接读写主内存中的变量。不同线程之间也无法访问彼此的工作内存，变量值的传递只能通过主内存来进行。


volatile关键字具有许多特性，其中最重要的特性就是保证了 **用volatile修饰的变量对所有线程的可见性**。

为什么volatile关键字可以有这样的特性？这得益于java语言的先行发生原则（happens-before）。在计算机科学中，先行发生原则是两个事件的结果之间的关系，如果一个事件发生在另一个事件之前，结果必须反映，即使这些事件实际上是乱序执行的（通常是优化程序流程）。
这里所谓的事件，实际上就是各种指令操作，比如读操作、写操作、初始化操作、锁操作等等。先行发生原则作用于很多场景下，包括同步锁、线程启动、线程终止、volatile。

**volatile关键字只能保证变量的可见性，并不能保证变量的原子性。 不能保证线程安全！**
因此，什么时候适合用volatile呢？
1. **运行结果并不依赖变量的当前值，或者能够确保只有单一的线程修改变量的值。**
2. **变量不需要与其他的状态变量共同参与不变约束。**

### 指令重排
指令重排是指JVM在编译Java代码的时候，或者CPU在执行JVM字节码的时候，对现有的指令顺序进行重新排序。
指令重排的目的是为了在不改变程序执行结果的前提下，优化程序的运行效率。需要注意的是，这里所说的不改变执行结果，指的是不改变单线程下的程序执行结果。
然而，指令重排是一把双刃剑，虽然优化了程序的执行效率，但是在某些情况下，会影响到多线程的执行结果。

### 内存屏障
内存屏障（Memory Barrier）是一种CPU指令。
内存屏障也称为内存栅栏或栅栏指令，是一种屏障指令，它使CPU或编译器对屏障指令之前和之后发出的内存操作执行一个排序约束。 这通常意味着在屏障之前发布的操作被保证在屏障之后发布的操作之前执行。
内存屏障共分为四种类型：
1. LoadLoad屏障
2. StoreStore屏障
3. LoadStore屏障
4. StoreLoad屏障

### volatile做了什么？
在一个变量被volatile修饰后，JVM会为我们做两件事：

1. 在每个volatile写操作前插入StoreStore屏障，在写操作后插入StoreLoad屏障。

2. 在每个volatile读操作前插入LoadLoad屏障，在读操作后插入LoadStore屏障。

### 两种语义

volatile特性之一：

保证变量在线程之间的可见性。可见性的保证是基于CPU的内存屏障指令，被JSR-133抽象为happens-before原则。

volatile特性之二：
阻止编译时和运行时的指令重排。编译时JVM编译器遵循内存屏障的约束，运行时依靠CPU屏障指令来阻止重排。


几点补充：
1. 关于volatile的介绍，本文很多内容来自《深入理解Java虚拟机》这本书。
2. 在使用volatile引入内存屏障的时候，普通读、普通写、volatile读、volatile写会排列组合出许多不同的场景。
3. volatile除了保证可见性和阻止指令重排，还解决了long类型和double类型数据的8字节赋值问题。这个特性相对简单，本文就不详细描述了。


<hr />