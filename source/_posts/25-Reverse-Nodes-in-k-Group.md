---
title: 25. Reverse Nodes in k-Group
tags: [Linked List]
date: 2019-05-27 20:06:25
permalink: 25
categories: Hard
description:
---
<p class="description"></p>


<!-- more -->

## k 个一组翻转链表
### 题目
给出一个链表，每 k 个节点一组进行翻转，并返回翻转后的链表。

k 是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 k 的整数倍，那么将最后剩余节点保持原有顺序。

示例 :

给定这个链表：1->2->3->4->5

当 k = 2 时，应当返回: 2->1->4->3->5

当 k = 3 时，应当返回: 3->2->1->4->5
说明 :

你的算法只能使用常数的额外空间。 你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。 

### java代码
思路见注释

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-05-27 20:10 by jdk 1.8
 */
public class ReverseKGroup {

	public ListNode reverseKGroup(ListNode head, int k) {
        //计数器
        int length = 0;
        //当前组头结点
        ListNode r = head;
        //遍历剩余链表,用计数器记录,每当链表还满足长度>=k,则终止操作
        while (r != null && length != k) {
            r = r.next;
            length++;
        }
        //如果长度 == k,说明当前剩余链表长度>=k,还可以再分组
        if (length == k) {
            //对于剩余链表调用自身函数再进行分组,直至剩余长度不足k为止
            //用tail 接受此组的下一组反转完成之后的新头结点
            ListNode pre = reverseKGroup(r, k);
            //对于此组的节点进行指向反转
            while (k-- > 0) {
                ListNode next = head.next;
                head.next = pre;
                pre = head;
                head = next;
            }
            //值得注意的是:当上述的while循环结束的时候,head 指向的已经是下一组的原头结点了,所以
            //不要直接返回head
            //应该返回head 的上一个元素 ,如上面用pre记录了.
            return pre;
        }
        //如果长度不满足k,则剩余链表不需要进行任何操作,直接返回剩余链表的头结点即可.
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

### 总结
1. while(k-- > 0)的循环体内就是 反转链表的代码，这里reverse节点是下一组链表的头结点。

<hr />