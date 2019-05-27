---
title: 142. Linked List Cycle 2
tags: [Linked List, Two Pointers]
date: 2019-05-27 17:58:10
permalink: 142
categories: Medium
description:
---
<p class="description"></p>


<!-- more -->

## 环形链表Ⅱ

### 题目

给定一个链表，判断链表中是否有环。

为了表示给定链表中的环，我们使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。
说明：不允许修改给定的链表。


示例 1：

输入：head = [3,2,0,-4], pos = 1
输出：tail connects to node index 1
解释：链表中有一个环，其尾部连接到第二个节点。

示例 2：

输入：head = [1,2], pos = 0
输出：tail connects to node index 0
解释：链表中有一个环，其尾部连接到第一个节点。

示例 3：

输入：head = [1], pos = -1
输出：no cycle
解释：链表中没有环。

进阶：
你能用 O(1)（即，常量）内存解决此问题吗？

### 思路

分两个步骤，首先通过快慢指针的方法判断链表是否有环；接下来如果有环，则寻找入环的第一个节点。

具体的方法为，首先假定链表起点到入环的第一个节点A的长度为a【未知】，到快慢指针相遇的节点B的长度为（a + b）【这个长度是已知的】。

现在我们想知道a的值，注意到快指针 fast 始终是慢指针 slow 走过长度的2倍，所以慢指针 slow 从B继续走（a + b）又能回到B点，如果只走a个长度就能回到节点A。

但是a的值是不知道的，解决思路是曲线救国，注意到起点到A的长度是a，那么可以用一个从起点开始的新指针head和从节点B开始的慢指针slow同步走，相遇的地方必然是入环的第一个节点A。

画个图就一目了然了~

### java代码

```java
/**
 * @description: 链表有环，返回节点
 * @author: rhsphere
 * @since: 2019-05-27 18:58 by jdk 1.8
 */
public class DetectCycle {
    public ListNode detectCycle(ListNode head) {
        if (head == null || head.next == null)
            return null;

        ListNode slow = head;
        ListNode fast = head;

        while (fast != null && fast.next != null) {
            fast = fast.next.next;
            slow = slow.next;
            if (fast == slow) {
                while (head != fast) {
                    fast = fast.next;
                    head = head.next;
                }
                return head;
            }
        }
        return null;
    }

    private static class ListNode{
        int val;
        ListNode next;

        ListNode(int val, ListNode next) {
            this.val = val;
            this.next = next;
        }
    }
}
```


<hr />