---
title: LinkedStack && ArrayStack
tags: [Stack, LinkedStack, ArrayStack]
date: 2019-05-28 19:08:37
permalink: linked-and-array-stack
categories: Sum-up
description:
---
<p class="description"></p>


<!-- more -->
## 栈

**当某个数据集合致设计在一端插入和删除数据，并且满足后进先出、先进后出的特性，我们就应该首选“栈”这种数据结构。**

栈主要包括两个操作，入栈和出栈，在栈顶插入一个数据和从栈顶删除一个数据。

栈既可以用数组来实现，也可以用链表来实现。用数组实现的栈，就做顺序栈，用链表实现的栈，叫链式栈。

不管是顺序栈还是链式栈，我们存储数据只需要一个大小为n的数组就够了。在入栈和出栈过程中，只需要一两个临时变量存储空间，所以空间复杂度是O(1)。

**注意，这里存储数据需要一个大小为n的数组，并不是说空间复杂度就是O(n)。因为这个空间是必须的，无法省掉。所以我们说空间复杂度的时候，是指除了原本的数据存储空间外，算法运行还需要额外的存储空间。**

栈的一些应用：

1. **栈在函数调用中的应用**
2. **栈在表达式求值中的应用**
3. **栈在括号匹配中的应用**

关于用函数调用栈来保存临时变量，为什么函数调用要用“栈”来保存变量呢？用其他数据结构不行吗？

**解答：** 其实，不一定非要栈来保存临时变量，只不过如果这个函数调用符合后进先出的特性，用栈这种数据结构来实现，是最顺理成章的选择。

从调用函数进入被调用函数，对于数据来说，变化的是什么？是作用域。所以根本上，只要能保证每进入一个新的函数，都是一个新的作用域就可以。而要实现这个，用栈就非常方便。在进入被调用函数的时候，分配一段栈空间给这个函数的变量，在函数结束的时候，将栈顶复位，正好回到调用函数的作用域内。


## 数组实现顺序栈

支持动态扩容的顺序栈，底层依赖一个支持动态扩容的数组就可以了。当栈满了，就申请一个更大的数组，将原来的数据搬移到新数组中。

实际上，支持动态扩容的顺序栈，平时开发并不常用到。
出栈的时间复杂度是O(1)，那入栈操作的 **均摊时间复杂度是O(1)**。 关于分析，参考[极客时间08|栈](https://time.geekbang.org/column/article/41222)



### 数组实现栈的代码
```java
package Stack;

import java.util.*;

/**
 * @description: 数组实现栈，使用支持动态调整数组大小的泛型数组
 * @author: rhsphere
 * @since: 2019-05-28 16:43 by jdk 1.8
 */
public class ArrayStack<E> implements Iterable<E> {
    private E[] arr;
    private int n;

    public ArrayStack(){
        arr = (E[]) new Object[2];
        n = 0;
    }
    public boolean isEmpty() {
        return n == 0;
    }
    public int size() {
        return n;
    }
    private void resize(int capacity) {
        assert capacity >= 0;
        E[] tmp = (E[]) new Object[capacity];
        for (int i = 0; i < n; i++) {
            tmp[i] = arr[i];
        }
        arr = tmp;
    }
    public void push(E e) {
        if (n == arr.length)
            resize(2 * arr.length);
        arr[n++] = e;
    }
    public E pop() {
        if (isEmpty())
            throw new NoSuchElementException("Stack underflow");

        E e = arr[n - 1];
        arr[n - 1] = null;
        n--;
        if (n > 0 && n == arr.length / 4)
            resize(arr.length / 2);
        return e;
    }

    public E peek() {
        if (isEmpty())
            throw new NoSuchElementException("Stack underflow");
        return arr[n - 1];
    }

    public Iterator<E> iterator() {
        return new ArrayIterator();
    }
    // 这里写ArrayIterator<E> 会报错是为什么？？？
    private class ArrayIterator implements Iterator<E> {
        private int i;
        public ArrayIterator() {
            i = n - 1;
        }
        public boolean hasNext() {
            return i >= 0;
        }

        public void remove() {
            throw new UnsupportedOperationException();
        }
        public E next() {
            if (!hasNext())
                throw new NoSuchElementException();
            return arr[i--];
        }
    }
}
```




## 链表实现链式栈
### 思路
1. 用链表结点存储栈顶top节点，存储链表长度
2. 实现isEmpty()方法、size()方法
3. push()用增加的节点作为头节点

### 链表实现栈的代码
```java
package Stack;

import java.util.*;
/**
 * @description: 实现链表栈，使用泛型的单链表
 * @author: rhsphere
 * @since: 2019-05-28 15:57 by jdk 1.8
 */
public class LinkedStack<E> implements Iterable<E> {
    //栈顶节点top和栈的大小
    private Node<E> top;
    private int n;

    //内部静态类，因为不用接触类的任何实例对象和方法
    //外部类可以访问内部类的private/protected变量，就像访问自己的private/protected变量一样.
    private static class Node<E> {
        private E e;
        private Node<E> next;
    }
    //构造一个空的stack
    public LinkedStack() {
        top = null;
        n = 0;
    }
    //判断栈顶结点是不是null
    public boolean isEmpty() {
        return top == null;
    }

    public int size() {
        return n;
    }

    /**
     * 添加一个元素
     * @param  e 待添加的元素
     */
    public void push(E e) {
        Node<E> oldTop = top;
        top = new Node<E>();
        top.e = e;
        top.next = oldTop;
        n++;
    }
    /**
     * 删除并返回最近添加的元素
     * @return 最近添加的元素
     * @throws NoSuchElementException 如果栈为空
     */
    public E pop() {
        if (isEmpty())
            throw new NoSuchElementException("LinkedStack underflow");
        E e = top.e;
        top = top.next;
        n--;
        return e;
    }
    /**
     * 返回但不移除最近添加的栈顶元素
     * @return 最近添加的元素
     * @throws NoSuchElementException 如果栈为空
     */
    public E peek() {
        if (isEmpty())
            throw new NoSuchElementException("LinkedStack underflow");
        return top.e;
    }

    //foreach的写法是因为LinkedStack的对象实现了Iterable接口
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (E e : this) {
            sb.append(e);
            sb.append(' ');
        }
        return sb.toString();
    }
    /**
     * 返回一个以LIFO顺序遍历栈元素的迭代器
     * @return 一个以LIFO顺序遍历栈元素的迭代器
     */
    public Iterator<E> iterator() {
        return new ListIterator<E>(top);
    }
    private class ListIterator<E> implements Iterator<E> {
        private Node<E> cur;
        public ListIterator(Node<E> top) {
            cur = top;
        }
        public boolean hasNext() {
            return cur != null;
        }
        public void remove() {
            throw new UnsupportedOperationException();
        }
        public E next() {
            if (!hasNext())
                throw new NoSuchElementException("LinkedStack underflow");
            E e = cur.e;
            cur = cur.next;
            return e;
        }
    }
}
```



## 顺序和链式栈测试代码

```java
package Stack;

/**
 * @description:
 * @author: rhsphere
 * @since: 2019-05-28 16:28 by jdk 1.8
 */
public class TestStack {
    public static void main(String[] args) {
        System.out.println("==========测试ArrayStack==========");

        LinkedStack<String> stack = new LinkedStack<String>();
        stack.push("! ");
        stack.push("world");
        stack.push(", ");
        stack.push("Hello");
        stack.push("Hi. ");
        System.out.println("栈顶元素是：" + stack.peek());

        // 使用foreach遍历栈元素
        for(String s : stack)
            System.out.print(s);

        System.out.println();

        while (!stack.isEmpty()) {
            System.out.print(stack.pop());
        }
        System.out.println("\n(now " + stack.size() + " left on linked stack)");

        System.out.println("==========测试ArrayStack==========");
        ArrayStack<String> arrStack = new ArrayStack<String>();
        arrStack.push("! ");
        arrStack.push("world");
        arrStack.push(", ");
        arrStack.push("Goodbye");
        arrStack.push("woo. ");
        System.out.println("栈顶元素是：" + arrStack.peek());

        // 使用foreach遍历栈元素
        for(String s : arrStack)
            System.out.print(s);

        System.out.println();

        while (!arrStack.isEmpty()) {
            System.out.print(arrStack.pop());
        }
        System.out.println("\n(now " + arrStack.size() + " left on  array stack)");

    }
}
```


<hr />