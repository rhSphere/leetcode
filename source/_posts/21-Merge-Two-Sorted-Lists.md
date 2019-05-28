---
title: 21. Merge Two Sorted Lists
tags: [Linked List]
date: 2019-05-27 19:21:04
permalink: 21
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 合并两个有序链表
### 题目
将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。

示例：

输入：1->2->4, 1->3->4
输出：1->1->2->3->4->4

### java代码

```java
**
 * @description: 合并两个有序链表
 * @author: rhsphere
 * @since: 2019-05-27 19:41 by jdk 1.8
 */
public class MergeSortedLists {
	public static ListNode mergeSortedLists(ListNode la, ListNode lb) {
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

### 总结
脑袋要清楚知道指针是如何移动的！

<hr />