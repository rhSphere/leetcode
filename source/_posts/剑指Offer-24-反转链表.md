---
title: 剑指Offer(24) 反转链表
tags: [LinkedList]
date: 2019-06-30 17:25:30
permalink: reverse-linkedlist
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 反转链表

### 题目
　定义一个函数，输入一个链表的头结点，反转该链表并输出反转后链表的头结点。

### 思路

参考 [leetcode 206. Reverse Linked List](https://blogs.rhsphere.com/leetcode/2019/05/27/206.html)


### 测试用例
1. 功能测试（链表有多个或一个节点）
2. 特殊测试（头结点为null）

## java代码

```java
/**
 * @description: 剑指Offer24
 * @author: rhsphere
 * @since: 2019-07-01 10:48 by jdk 1.8
 */
public class ReverseList {
    public static class ListNode {
        int val;
        ListNode next = null;
        ListNode(int val) {
            this.val = val;
        }
    }

    //迭代
    public ListNode reverseList(ListNode head) {
       ListNode reverse = null;
       while (head != null) {
           ListNode second = head.next;
           head.next = reverse;
           reverse = head;
           head = second;
       }
       return reverse;
    }

    //递归
    public ListNode reverseListRecursively(ListNode head) {
        if (head == null || head.next == null)
            return head;
        ListNode res = reverseListRecursively(head.next);
        head.next.next = head;
        head.next = null;
        return res;
    }
}
```





<hr />