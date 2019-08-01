---
title: 剑指Offer(52) 两个链表的第一个公共节点
tags: [LinkedList]
date: 2019-08-01 21:22:47
permalink: first-common-node-in-lists
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 两个链表的第一个公共节点 

### 题目
输入两个链表，找出它们的第一个公共结点。

### 思路

蛮力法：遍历第一个链表的结点，每到一个结点，就在第二个链表上遍历每个结点，判断是否相等。时间复杂度为O(m*n)，效率低；

　　使用栈：由于公共结点出现在尾部，所以用两个栈分别放入两个链表中的结点，从尾结点开始出栈比较。时间复杂度O(m+n)，空间复杂度O(m+n)。

　　利用长度关系：计算两个链表的长度之差，长链表先走相差的步数，之后长短链表同时遍历，找到的第一个相同的结点就是第一个公共结点。

　　利用两个指针：一个指针顺序遍历list1和list2，另一个指针顺序遍历list2和list1，（这样两指针能够保证最终同时走到尾结点），两个指针找到的第一个相同结点就是第一个公共结点。


### 测试用例

1. 功能测试（有/无公共结点；公共结点分别在链表的中间，头结点和尾结点）

2. 特殊测试（头结点为null）

## java代码

```java
/**
 * @description: 剑指offer52
 * @author: rhsphere
 * @since: 2019-08-01 21:09 by jdk 1.8
 */
public class FirstCommonNodesInLists {
    public class ListNode {
        int val;
        ListNode next = null;
        ListNode(int val) {
            this.val = val;
        }
    }
    //方法1：利用长度关系
    public ListNode findFirstCommonNode1(ListNode list1, ListNode list2) {
    	int len1 = getLength(list1);
    	int len2 = getLength(list2);
    	int lenDiff = len1 - len2;
    	ListNode longList = list1;
    	ListNode shortList = list2;

    	if (lenDiff < 0) {
    		longList =list2;
    		shortList = list1;
    		lenDiff = - lenDiff;
    	}
    	for (int i = 0; i < lenDiff; i++)
    		longList = longList.next;
    	while (longList != null && longList != shortList) {
    		longList = longList.next;
    		shortList =shortList.next;
    	}
    	return longList;
    }
    private int getLength(ListNode list) {
    	int len = 0;
    	while (list != null) {
    		len++;
    		list = list.next;
    	}
    	return len;
    }

    //方法2：两个指针，p1顺序遍历list1和list2，p2顺序遍历list2和list1；最终一定会相遇
    public ListNode findFirstCommonNode2(ListNode list1, ListNode list2) {
    	ListNode p = list1;
    	ListNode q = list2;

    	while (p != q) {
    		if (p != null) p = p.next;
    		if (q != null) q = q.next;

    		if (p != q) {
    			if (p == null) p = list2;
    			if (q == null) q = list1;
    		}
    	}
    	return p;
    }

}
```


## 总结
1.由于有共同结点时，后面的链表是重合的，所以这道题关键是要保证最后同时遍历到达尾结点，因此就有了后面三种方法：

　　利用栈的先进后出实现同时到达；

　　利用长度关系，长链表先行几步，实现同时到达；

　　两个指针同时遍历两个链表，一个先list1后list2，另一个则相反，也可以实现同时到达。


<hr />