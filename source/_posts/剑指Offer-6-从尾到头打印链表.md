---
title: 剑指Offer(6) 从尾到头打印链表
tags: [LikedList, Recursive]
date: 2019-03-26 23:07:55
permalink: print-list-from-head-to-tail
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 从头到尾打印链表

###  题目
输入一个链表的头结点，从尾到头反过来打印出每个结点的值。节点定义如下：
  
class ListNode {
    int val;
    ListNode next;
    ListNode(int val) {
        this.val = val;
    }
}


### 思路
输入一个链表的头结点，从尾到头反过来打印出每个结点的值。对于“后进先出”问题，要快速想到”栈“，也同时想到递归。

结点遍历顺序只能从头到尾，但是输出的顺序却为从尾到头，是典型的“后进先出”问题，这就要联想到使用栈，从而也可以联想到使用递归。

###  测试用例

1. 功能测试（单个节点链表，多个节点链表）
2. 特殊输入测试（链表为空）

## Java代码
 
```java
import java.util.Stack;
public class PrintListInReversedOrder {
    class Node {
        int element;
        Node next;
        public Node(int element) {
            this.element = element;           
        }
    }

    // 采用栈
    public void printListReversingly_Iteratively(Node node) {
        Stack<Node> stack = new Stack<>();
        while (node != null) {
            stack.push(node);
            node = node.next;
        }
        while (!stack.empty()) {
            System.out.println(stack.pop().element);
        }
    }

    // 采用递归
    public void printListReversingly_Recursively(Node node) {
        if (node != null) {
            printListReversingly_Recursively(node.next);
            System.out.println(node.element);
        } else {
            return;
        }
    }
}
```

测试代码：

```java
public class PrintListInReversedOrder {
    /**
     * 链表为空
     */
    public void test1() {
        Node aNode = null;
        System.out.println("采用栈：");
        printListReversingly_Iteratively(aNode);
        System.out.println("采用递归：");
        printListReversingly_Recursively(aNode);
    }

    /**
     * 多个结点链表
     */
    public void test2() {
        Node Node1 = new Node(1);
        Node Node2 = new Node(2);
        Node Node3 = new Node(3);
        Node Node4 = new Node(4);
        Node Node5 = new Node(5);
        Node1.next = Node2;
        Node2.next = Node3;
        Node3.next = Node4;
        Node4.next = Node5;
        System.out.println("采用栈：");
        printListReversingly_Iteratively(Node1);
        System.out.println("采用递归：");
        printListReversingly_Recursively(Node1);
    }

    /**
     * 单个结点链表
     */
    public void test3() {
        Node Node1 = new Node(1);
        System.out.println("采用栈：");
        printListReversingly_Iteratively(Node1);
        System.out.println("采用递归：");
        printListReversingly_Recursively(Node1);
    }
    public static void main(String[] args) {
        PrintListInReversedOrder demo = new PrintListInReversedOrder();
        System.out.println("test1:");
        demo.test1();
        System.out.println("test2:");
        demo.test2();
        System.out.println("test3:");
        demo.test3();
    }
}
```


### 递归的其他写法
递归部分代码也可以像下面这样写，注意体会不同的递归写法

```java
public void printListReversingly_Recursively(Node node) {
    if (node != null) {
        if (node.next != null) {
            printListReversingly_Recursively(node.next);
        }
        System.out.println(node.element);
    }
}
```

### 牛客网提交代码
采用的递归，非常简洁，很值得学习。

```java
/**
*    public class ListNode {
*        int val;
*        ListNode next = null;
*
*        ListNode(int val) {
*            this.val = val;
*        }
*    }
*/

import java.util.ArrayList;
public class Solution {
    ArrayList<Integer> list = new ArrayList<>();

    public ArrayList<Integer> printListFromTailToHead(ListNode node) {
        if (node != null) {
            this.printListFromTailToHead(listNode.next);
            list.add(node.val);
        }
        return list;
    }
}
```

## 总结
1. 对于“后进先出”问题，要快速想到”栈“，也同时想到递归。
2. 采用递归时，返回的函数值不一定要有赋值操作，只要实现了遍历的作用就可以了，牛客网的代码可以多多学习。

<hr />