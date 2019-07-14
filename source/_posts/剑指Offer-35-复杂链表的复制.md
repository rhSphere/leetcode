---
title: 剑指Offer(35) 复杂链表的复制
tags: [LinkedList]
date: 2019-07-12 15:05:19
permalink: cpoy-complex-list
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 复杂链表的复制


### 题目
　请实现函数ComplexListNode* Clone(ComplexListNode* pHead)，复制一个复杂链表。在复杂链表中，每个结点除了有一个m_pNext指针指向下一个点外，还有一个m_pSibling 指向链表中的任意结点或者nullptr。

### 思路

思路1：先复制结点，用next链接，最后根据原始结点的sibling指针确定该sibling结点距离头结点的位置，从而对复制结点设置sibling指针。但是该思路对于n个结点的链表，每个结点的sibling都需要O(n)个时间步才能找到，所以时间复杂度为O(n^2)

　　思路2：复制原始结点N创建N’，用next链接。将<N,N'>的配对信息存放入一个哈希表中；在设置sibling时，通过哈希表，只需要用O(1)的时间即可找到复制结点的sibling。该方法的时间复杂度为O(n)，但空间复杂度为O(n)。

　　思路3：复制原始结点N创建N’，将N'链接到N的后面；根据原始结点N的sibling可以快速设置N'结点的sibling，最后将这个长链表拆分成原始链表和复制链表（根据奇偶位置）

### 测试用例
1. 功能测试（sibling指向自己；链表只有一个节点；sibling指向null或者指向节点）
2. 特殊测试（头结点为null）




## java代码

```java
/**
 * @description: 剑指offer35题
 * @author: rhsphere
 * @since: 2019-07-12 15:15 by jdk 1.8
 */
public class CopyComplexList {
	public class ComplexListNode {
		int val;
		ComplexListNode next, sibling;
		ComplexListNode(int val) {
			this.val = val;
		}
	}

	//主程序
	public ComplexListNode cloneList(ComplexListNode head) {
		cloneNodes(head);
		connectSiblingNodes(head);
		return reconnectNodes(head);
	}

	//1.第一步，复制每个节点，并插入到原节点后面
	private void cloneNodes(ComplexListNode head) {
		ComplexListNode pNode = head;
		while (pNode != null) {
			ComplexListNode clonedNode = new ComplexListNode(pNode.val);
			clonedNode.next = pNode.next;
			pNode.next = clonedNode;
			pNode = clonedNode.next;
		}
	}
	//2.第二步，根据原节点的位置，设置sibling的指针
	private ComplexListNode connectSiblingNodes(ComplexListNode head) {
		ComplexListNode pHead = head;
		while (pNode != null) {
			if (pNode.sibling != null) 
				pNode.next.sibling = pNode.sibling.next;
			pNode = pNode.next.next;
		}
	}
	//3.第三步，将长链表拆分成原始链表和复制链表（按照奇偶位置）
	public ComplexListNode reconnectNodes(ComplexListNode head) {
		ComplexListNode clonedHead = null;
		ComplexListNode clonedNode = null;
		ComplexListNode pNode = head;
		if (head != null) {
			clonedHead = head.next;
			clonedNode = pNode.next;
			pNode.next = clonedNode.next;
			pNode = pNode.next; //提前将pNode指向下一个结点，方便判断是否为null
		}
		while (pNode != null) {
			clonedNode.next = pNode.next;
			clonedNode = clonedNode.next;
			pNode.next = clonedNode.next;
			pNode = pNode.next;
		}
		return clonedHead;
	}

}	

```


## 总结
1. 有关于拆分函数，需要画图分析，才能厘清思路；
2. 复制链表时，在演示节点后面直接插入复制节点，这种方法很方便，有较高的效率。




<hr />