---
title: 剑指Offer(22) 链表中倒数第k个节点
tags: [LinkedList]
date: 2019-06-30 17:24:16
permalink: kth-listnode-from-end
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 链表中倒数第k个节点

### 题目

输入一个链表，输出该链表中倒数第k个结点。为了符合大多数人的习惯，本题从1开始计数，即链表的尾结点是倒数第1个结点。例如一个链表有6个结点，从头结点开始它们的值依次是1、2、3、4、5、6。这个链表的倒数第3个结点是值为4的结点。


### 思路

本题和 [leetcode 19. Remove Nth Node From End of List](https://blogs.rhsphere.com/leetcode/2019/05/27/19.html) 是同一道题，和书中是同一个思路：设置两个指针，第一个指针先遍历k-1步；从第k步开始，第二个指针指向头结点，两个节点同时往后遍历，当第一个指针到达最后一个节点时，第二个指针指向的正好是倒数第k个节点。


### 测试用例 
1. 功能测试（第k个节点分别在链表的中间、头结点和尾节点）
2. 特殊测试（头结点为null、k超出范围）

## java代码
```java
public class KthNodeFromEnd {
	public static class ListNode {
		int val;
		ListNode next = null;
		ListNode(int val) {
			this.val = val;
		}
	}

	//方法1：利用栈
	public ListNode findKthToTail(ListNode head, int k) {
		if (head == null || k < 0)
			return null;
		int numOfList = 1;
		Stack<ListNode> st = new Stack<>();
		st.push(head);
		ListNode node = head.next;
		while (node != null) {
			numOfList++;
			st.push(node);
			node = node.next;
		}
		if (k > numOfList) {
			return null;
		} else {
			for (int i = 1; i <= k; i++)
				node = st.pop();
			return node;
		}
	}


	//方法2：利用两个相距为k-1的指针
	public ListNode findKthToTail2(ListNode head, int k) {
		if (head == null || k <= 0)
			return null;
		ListNode fast = head;
		for (int i = 1; i < k; i++) {
			fast = fast.next;
			if (fast == null)
				return null;
		}
		ListNode slow = head;
		while (fast.next != null) {
			fast = fast.next;
			slow = slow.next;
		}
		return slow;
	}
}

```


## 总结

1. 注意代码的鲁棒性，开始思考前都需要注意特殊输入测试；
2. 一个指针遍历链表无法解决问题时，可以考虑使用两个指针来遍历链表：两个指针先后遍历（即该题目）、或者两个指针遍历速度不同（如：求链表中的中间结点，可以令一个指针一次走一步，另一个指针一次走两步来实现）

<hr />