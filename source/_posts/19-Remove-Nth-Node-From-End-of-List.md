---
title: 19. Remove Nth Node From End of List
tags: [Linked List, Two Pointers]
date: 2019-05-27 20:43:36
permalink: 19
categories: Medium
description:
---
<p class="description"></p>


<!-- more -->

## 删除链表的倒数第N个节点
### 题目
给定一个链表，删除链表的倒数第 n 个节点，并且返回链表的头结点。

示例：

给定一个链表: 1->2->3->4->5, 和 n = 2.

当删除了倒数第二个节点后，链表变为 1->2->3->5.
说明：

给定的 n 保证是有效的。

进阶：

你能尝试使用一趟扫描实现吗？

### 思路

使用fast指针先远离头结点 n-1 的位置，然后slow指针和fast再同时移动到链表尾部，此时slow指针的位置就是倒数第n个节点，提前保存slow的prev节点，然后prev.next = prev.next.next即可完成任务。

注意：
1. 链表为空的情况；
2. 链表只有一个元素的情况

### java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-05-27 20:45 by jdk 1.8
 */
public class RemoveNthFromEnd {
	public static ListNode removeNthFromEnd(ListNode head, int n) {
		ListNode fast = head;
		int i = 1;
		while (fast != null && i < n) {
			fast = fast.next;
			i++;
		}
		//链表为空
		if (fast == null) return head;
		ListNode slow = head, prev = null;

		while (fast.next != null) {
			fast = fast.next;
			prev = slow;
			slow = slow.next;
		}
		//链表只有一个元素
		if (prev == null) head = head.next;
		else prev.next = prev.next.next;
		return head;
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