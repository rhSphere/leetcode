---
title: 206. Reverse Linked List
tags: [Linked List]
date: 2019-05-27 16:34:16
permalink: 206
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 反转链表
### 题目
反转一个单链表。

示例:

输入: 1->2->3->4->5->NULL
输出: 5->4->3->2->1->NULL
进阶: 你可以迭代或递归地反转链表。你能否用两种方法解决这道题？

### 思路
有很多种写法：
1）迭代方式的解答
为了完成这个任务，需要记录链表中三个连续的节点：reverse、head、second。在每一轮迭代中，从原始链表中提取节点head并将它插入到逆链表的开头。我们需要一直保持head指向原链表中所有剩余节点的首节点，second指向原链表中所有剩余节点的第二个节点，reverse指向结果链表中的首节点。

2）假设链表有N个节点，首先递归颠倒最后N-1个节点，然后小心地将原链表的首节点插入到结果链表的末端。

### java代码

迭代和递归写法，见代码注释。

```java
/**
 * @description: 反转一个链表
 * @author: rhsphere
 * @since: 2019-05-27 16:32 by jdk 1.8
 */
public class ReverseLinkedList {
	//迭代解法
	public static ListNode reverse(ListNode head) {
		ListNode reverse = null;

		while (head != null) {
			ListNode second = head.next;
			head.next = reverse;
			reverse = head;
			head = second;
		}
		return reverse;
	}

	//递归解法
	public static ListNode reverseRecursive(ListNode head) {
		if (head == null) return head;
		if (head.next == null) return head;

		ListNode second = head.next;
		ListNode res = reverseRecursive(second);
		second.next = head;
		head.next = null;
		return res;
	}


	private class ListNode{
		private int val;
		private ListNode next;

		public ListNode(int val, ListNode next) {
			this.val = val;
			this.next = next;
		}
		public int getData() {return val;}
	}
}
```


### 总结
1. 编写和链表相关的代码时，必须要小心处理异常情况（链表为空或是只有一个或两个节点）和边界情况（处理首尾节点）。这些情况通常更加需，要画图等手段来看清楚指针变化。


<hr />