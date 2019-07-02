---
title: 剑指Offer(23) 链表中环的入口节点
tags: [LinkedList]
date: 2019-06-30 17:25:04
permalink: entry-node-in-linkedlist
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 链表中环的入口节点 

### 题目
一个链表中包含环，如何找出环的入口结点？


### 思路

1. 确定链表是否有环：通过两个不同速度的指针确定，当两个指针指向同一个结点时，该结点为环中的一个结点。
2. 确定环中结点的数目n：指针走一圈，边走边计数
3. 找到环的入口：从头结点开始，通过两个相差为n的指针来得到（即寻找链表中倒数第n个结点）

本题和 [ leetcode 141. Linked List Cycle 1](https://blogs.rhsphere.com/leetcode/2019/05/27/141.html) 及 [  leetcode 142. Linked List Cycle 2](https://blogs.rhsphere.com/leetcode/2019/05/27/142.html)相同

### 测试用例
1. 功能测试 （链表包含与不包含环；链表有多个或一个节点）
2. 特殊测试（头结点为null）


## java代码

```java
/**
 * @description: 剑指Offer23
 * @author: rhsphere
 * @since: 2019-06-30 23:34 by jdk 1.8
 */
public class EntryNodeOfLoop {
    public static class ListNode {
        int val;
        ListNode next = null;
        ListNode(int val) {
            this.val = val;
        }
    }

    //确定链表中是否有环，采用快慢指针
    private ListNode meetingNode(ListNode head) {
        if (head == null)
            return null;
        ListNode slow = head;
        ListNode fast = head;
        while (fast != null) {
            slow = slow.next;
            fast = fast.next;
            if (fast != null)
                fast = fast.next;
            if (slow != null && slow == fast)
                return slow;
        }
        return null;
    }

    //计算环中入口节点
    public ListNode entryNodeOfLoop(ListNode head) {
        ListNode meetingNode = meetingNode(head);
        if (meetingNode == null)
            return null;
        //计算环中节点的数目
        int count = 1;
        ListNode fast = meetingNode.next;
        while (fast != meetingNode) {
            count++;
            fast = fast.next;
        }
        //先移动p，次数为count
        fast = head;
        for (int i = 1; i <= count; i++) {
            fast = fast.next;
        }
        ListNode slow = head;
        while (slow != fast) {
            slow = slow.next;
            fast = fast.next;
        }
        return slow;
    }
}

```






<hr />