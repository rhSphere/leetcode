---
title: 876. Middle of the Linked List
tags: [Linked List, Two Pointers]
date: 2019-05-28 08:01:22
permalink: 876
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 链表的中间节点
### 题目
给定一个带有头结点 head 的非空单链表，返回链表的中间结点。

如果有两个中间结点，则返回第二个中间结点。

 

示例 1：

输入：[1,2,3,4,5]
输出：此列表中的结点 3 (序列化形式：[3,4,5])
返回的结点值为 3 。 (测评系统对该结点序列化表述是 [3,4,5])。
注意，我们返回了一个 ListNode 类型的对象 ans，这样：
ans.val = 3, ans.next.val = 4, ans.next.next.val = 5, 以及 ans.next.next.next = NULL.
示例 2：

输入：[1,2,3,4,5,6]
输出：此列表中的结点 4 (序列化形式：[4,5,6])
由于该列表有两个中间结点，值分别为 3 和 4，我们返回第二个结点。
 

提示：

给定链表的结点数介于 1 和 100 之间。

### 思路
头结点误导人

快慢指针： 1.慢指针一次走一步，快指针一次走2步，快指针走到末端，慢指针正好指向中间结点； 2.这里分两种情况：

快指针的next为null，慢指针正好指向中间结点，链表结点数为偶数；
快指针为null，慢指针正好指向第二个中间结点，链表结点数为奇数；


### java代码

```java
/**
 * @description: 快慢指针，找到链表的中间节点
 * @author: rhsphere
 * @since: 2019-05-28 08:02 by jdk 1.8
 */
public class MiddleNode {
    public static ListNode middleNode(ListNode head) {
        // 如果没有头结点
        //if (head == null) return head;

        ListNode fast = head, slow = head;

        
        //while (fast.next != null && fast.next.next != null) {

        while (fast != null && fast.next != null) {
            fast = fast.next.next;
            slow = slow.next;
        }
        return slow;
    }

    public static class ListNode{
        int val;
        ListNode next;
        public ListNode(int val, ListNode next) {
            this.val = val;
            this.next = next;
        }
    }
}
```



<hr />