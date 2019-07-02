---
title: 剑指Offer(25) 合并两个有序链表
tags: [LinkedList]
date: 2019-06-30 17:25:47
permalink: merge-sorted-linkedlist
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 合并两个有序链表

### 题目
输入两个递增排序的链表，合并这两个链表并使新链表中的结点仍然是按照递增排序的。

### 思路
**递归实现：** 合并过程中，每次都是从两个链表中找出较小的一个来链接，因此可以采用递归来实现：当任意一个链表为null时，直接连接另一个链表即可；其余情况只需要在两个链表中找出一个较小的节点进行连接，该节点的next值继续通过递归函数来链接。



**非递归实现：** 参考[leetcode 21. Merge Two Sorted Lists](https://blogs.rhsphere.com/leetcode/2019/05/27/21.html)  进行分类讨论即可。

### 测试用例
1. 功能测试（两个链表有多个或一个节点；节点值相同、不同）
2. 特殊测试（任意一个或者两个链表的头结点为null）

## java代码

```java
/**
 * @description: 剑指offer25
 * @author: rhsphere
 * @since: 2019-07-02 10:25 by jdk 1.8
 */
public class MergeSortedLists {
	public class ListNode {
		int val;
		ListNode next;
		public ListNode(int val) {
			this.val = val;
		}
	}

	//递归
	public ListNode merge(ListNode la, ListNode lb) {
		if (la == null) return lb;
		if (lb == null) return la;
		if (la.val < lb.val) {
			la.next = merge(la.next, lb);
			return la;
		} else {
			lb.next = merge(la, lb.next);
			return lb;
		}
	}

	//非递归
	public ListNode mergeSortedList(ListNode la, ListNode lb) {
		if (la == null) return lb;
		if (lb == null) return la;
		ListNode p = la, q = lb, head;
		if (p.val < q.val) {
			head = p;
			p = p.next;
		} else {
			head = q;
			q = q.next;
		}
		ListNode r = head;
		while (p != null && q != null) {
			if (p.val < q.val) {
				r.next = p;
				p = p.next;
			} else {
				r.next = q;
				q = q.next;
			}
			r = r.next;
		}
		if (p != null) {
			r.next = p;
		} else {
			r.next = q;
		}
		return head;
	}
}

```

## 总结
1. 对于递归实现方法，得到链表中值叫次奥的头结点并把它连接到已经合并的链表之后，两个链表剩余的节点依然是排序的，因此合并的步骤和之前的步骤是一样的。这就是典型的递归过程，我们可以定义递归函数完成这一合并过程。


<hr />