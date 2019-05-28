---
title: 23. Merge k Sorted Lists
tags: [Linked List, Divide and Conquer, Heap, MergeSort]
date: 2019-05-28 08:26:23
permalink: 23
categories: Hard
description:
---
<p class="description"></p>


<!-- more -->

## 合并 k 个排序链表
### 题目
合并 k 个排序链表，返回合并后的排序链表。请分析和描述算法的复杂度。

示例:

输入:
[
  1->4->5,
  1->3->4,
  2->6
]
输出: 1->1->2->3->4->4->5->6 

### java代码
```java

/**
 * @description: 采用merge算法，一次合并两个
 * @author: rhsphere
 * @since: 2019-05-28 08:32 by jdk 1.8
 */
public class MergeKLists {
	public ListNode mergeKLists(ListNode[] lists) {
		return mergeKLists(lists, 0, list.length - 1);
	}
	private ListNode mergeKLists(ListNode[] listNodes, int start, int end) {
		if (start > end)
			return null;
		if (start == end)
			return listNodes[start];
		mid = start + ((end - start) >> 1);
		ListNode p = mergeKLists(listNodes, start, mid);
		ListNode q = mergeKLists(listNodes, mid + 1, end);
		ListNode res = merge(p, q);
		return res;
	}

	public ListNode merge(ListNode p, ListNode q) {
		ListNode head = new ListNode(0);
		ListNode r = head;

		while (true) {
			if (p == null && q == null) {
				break;
			} else if(p != null && (q == null || p.val <= q.val)) {
				r.next = p;
				p = p.next;
			} else if (p == null || q.val < p.val) {
				r.next = q;
				q = q.next;
			}
			r = r.next;
		}
		return head.next;
	}


 	public  class ListNode {
        int val;
        ListNode next;
        ListNode(int val) {
            this.val = val;
        }
    }

}
```

### 总结
失误的地方
1. else if(p != null && (q == null || p.val <= q.val)) 条件中少了判等， 写成了p.val < q.val。
2. mergeKLists(ListNode[] listNodes, int start, int end) start和end的形参类型写成了ListNode
3. 这题就是归并排序的衍生，理解归并排序，就能理解这里面的递归调用。

<hr />