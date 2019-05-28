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

## 数组实现顺序栈



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



## 链式和顺序栈测试代码
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