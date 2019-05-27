---
title: 141. Linked List Cycle 1
tags: [Linked List, Two Pointers]
date: 2019-05-27 17:58:55
permalink: 141
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 环形链表Ⅰ 
### 题目
给定一个链表，判断链表中是否有环。

为了表示给定链表中的环，我们使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。
 

示例 1：
输入：head = [3,2,0,-4], pos = 1
输出：true
解释：链表中有一个环，其尾部连接到第二个节点。

示例 2：
输入：head = [1,2], pos = 0
输出：true
解释：链表中有一个环，其尾部连接到第一个节点。

示例 3：
输入：head = [1], pos = -1
输出：false
解释：链表中没有环。

进阶：
你能用 O(1)（即，常量）内存解决此问题吗？

### 思路
1. 如果链表中没有环，则fast指针最终将到达终点，返回false；
2. 对于环形链表，fast和slow指针是两个围绕跑道的跑者。 快速跑步者最终会遇到慢跑者。 为什么？ 考虑这种情况（将其命名为情形A） ： 快速跑步者仅仅是慢跑者的一步。 在下一次迭代中，它们分别增加一步和两步并相互会合。

例如，我们还没有考虑过快速跑步者落后慢跑者两到三步的情况。 这很简单，因为在下一次或下次的下一次迭代中，这种情况将简化为上面的情形A。

证明方法采用了，归纳法。


### java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-05-27 18:06 by jdk 1.8
 */
public class HasCycle { 
	public static boolean hasCycle(ListNode head) {
		if (head == null)
			return false;

		ListNode fast = head.next;
		ListNode slow = head;
		// while (fast != null && slow != null) {
		// 错误示范
		while (fast != null && fast.next != null) {
			fast = fast.next.next;
			slow = slow.next;
			if (fast == slow) {
				return true;
			}
		}
		return false;
	}

	private static class ListNode{
		int val;
		ListNode next;

		ListNode(int val, ListNode next) {
			this.val = val;
			this.next = next;
		}
	}

	public static void main(String[] args) {
        ListNode head = new ListNode(3, null);
        ListNode second = new ListNode(2, null);
        ListNode third = new ListNode(0, null);
        ListNode fourth = new ListNode(-4, null);
        head.next = second;
        second.next = third;
        third.next = fourth;
        fourth.next = second;

        boolean hasCycle = hasCycle(head);
        System.out.println(hasCycle);
    }
}
```

### 总结
1. 错误示范  while (fast != null && slow != null) {

<hr />