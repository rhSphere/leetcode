---
title: 剑指Offer(18) 删除链表中的节点
tags: [Linked List, HQ Code]
date: 2019-06-22 11:19:00
permalink: delete-nodes-in-linkedlist
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

# 在O(1)时间内删除链表结点 
## 题目一
在给定单向链表的头指针和一个节点指针，定义一个函数在O(1)时间内删除该节点。

## 思路
**本题缺陷，要求O(1)时间删除，相当于隐藏了一个假设：待删除的节点的确在链表中。**

在单向链表中，节点没有指向前一个节点的指针，所以只好从链表的链表的头结点开始顺序查找。这样的时间复杂度为O(n)，要在O(1)的时间删除节点，可以这样实现：
	将待删除节点的next节点 j 的值赋值给 i ，再把 i 的指针指向 j 的下一个节点，最后删除 j ，效果等同于删除 j 。

全面考虑其他情况：
1. 待删除节点i为尾节点是，无下一个节点，只能从头开始遍历到尾节点；
2. 链表中只有一个节点时（即是头结点，又是尾节点），必须把头结点也设置为null；



## 测试用例
1. 功能测试 （多个节点链表，删除头结点、中间节点和尾节点；单个节点链表）

2. 特殊测试 （头结点或者删除节点为null）

## java代码

```java
/**
 * @description: 给定单向链表的头结点和一个节点指针，定义一个函数在O(1)时间删除该节点
 * @author: rhsphere
 * @since: 2019-06-22 15:49 by jdk 1.8
 */

// 注:本题存在缺陷，要求O(1)时间，则无法确定待删除节点的确在表中

public class DeleteNodeInList {
	private class ListNode {
		int val;
		ListNode next;
		ListNode(int val, ListNode next) {
			this.val = val;
			this.next = next;
		}
	}

	public ListNode deleteNode(ListNode head, ListNode pToBeDeleted) {
		ListNode p = pToBeDeleted;
		if (head == null || p == null) 
			return head;
		if (p.next != null) {
			ListNode q = p.next;
			p.val = q.val;
			p.next = q.next;
			q = null;
		} else if (head == p) {
			p = null;
			head = null;
		} else {
			ListNode pre = head;
			while (pre.next != p && pre != null) {
				pre = pre.next;
			}
			if (pre == null) {
				System.out.println("无法找到待删除节点")；
				return head;
			}
			pre.next = null;
			p = null;
		}
		return head;
	}


	//=========测试代码==========
    void test(ListNode head,ListNode PToBeDelete) {
        System.out.println("============");
        System.out.print("The original list is: ");
        ListNode curr=head;
        if(curr!=null) {
            while(curr.next!=null) {
                System.out.print(curr.val+",");
                curr=curr.next;
            }
            System.out.println(curr.val);
        }else {
            System.out.println();
        }
         
        System.out.print("The node to be deleted is: ");
        if(PToBeDelete!=null)
            System.out.println(PToBeDelete.val);
        else
            System.out.println();
         
        curr=deleteNode(head, PToBeDelete);    
        System.out.print("The result list is: ");
        if(curr!=null) {
            while(curr.next!=null) {
                System.out.print(curr.val+",");
                curr=curr.next;
            }
            System.out.println(curr.val);
        }else {
            System.out.println();
        }
        System.out.println("============");
    }
     
    /**
     * 链表含多个结点，删除头结点
     */
    void test1() {
        ListNode p4=new ListNode(4, null);
        ListNode p3=new ListNode(3, p4);
        ListNode p2=new ListNode(2, p3);
        ListNode p1=new ListNode(1, p2);
        test(p1, p1);
    }
     
    /**
     * 链表含多个结点，删除中间结点
     */
    void test2() {
        ListNode p4=new ListNode(4, null);
        ListNode p3=new ListNode(3, p4);
        ListNode p2=new ListNode(2, p3);
        ListNode p1=new ListNode(1, p2);
        test(p1, p3);
    }
     
    /**
     * 链表含多个结点，删除尾结点
     */
    void test3() {
        ListNode p4=new ListNode(4, null);
        ListNode p3=new ListNode(3, p4);
        ListNode p2=new ListNode(2, p3);
        ListNode p1=new ListNode(1, p2);
        test(p1, p4);
    }
     
    /**
     * 链表含一个结点，删除结点
     */
    void test4() {
        ListNode p4=new ListNode(4, null);
        test(p4, p4);
    }
     
    /**
     * 链表为空
     */
    void test5() {
        test(null, null);
    }
         
    public static void main(String[] args) {
        DeleteNodeInList demo = new DeleteNodeInList();
        demo.test1();
        demo.test2();
        demo.test3();
        demo.test4();
        demo.test5();
    }
}
```

## 总结
1. 链表中删除节点的方法中，虽然直接令 head=null, 但是在主函数中的head还是不变的，因此要令删除节点的返回值为LinkNode，将返回值赋值给主函数中的head，这样才能实现真正的删除。
2. 另一种情况可以令删除函数返回值为void，只是需要定义一个头结点head（1中的head相当于第一个节点），这个头结点中不存任何数据，仅仅起到执政的作用，第一个节点是头结点的下一个节点，通过对head.next操作，能够实现真正的删除。
3. 和链表有关的特殊情况：头结点、尾节点，链表仅有一个节点，null等。



# 删除链表中的重复节点

## 题目二

在一个排序的链表中，如何删除重复的节点？

## 思路
设置一个 pre ，用于记录当前节点的前一个节点，再设置一个布尔变量 needDelete ，如果说当前节点和后一结点的值相同（记该值为dupVal)，needDelete赋值为真。
当 needDelete 为真时，通过寻魂往后找到第一个不为 dupVal 的节点，把该节点设置为当前节点，并赋值给 pre.next, 即相当于完成了删除操作；而当 needDelete 为假时，把当前节点和 pre 往后移一位即可。


## 测试用例
1. 功能测试（重复的节点位于链表的头部、中间、尾部；链表中无重复节点）
2. 特殊输入测试（头结点为null、所有节点都重复）


## java代码

```java
/**
 * @description: 在一个排序链表中删除重复的节点
 * @author: rhsphere
 * @since: 2019-06-23 08:37 by jdk 1.8
 */
public class DeleteDuplicatedNode {
    private class ListNode {
        int val;
        ListNode next = null;
        ListNode(int val, ListNode next) {
            this.val = val;
            this.next = next;
        }
    }

    public ListNode deleteDuplication(ListNode pHead) {
        if (pHead == null || pHead.next == null) {
            // 空节点或者仅一个节点
            return pHead;
        }
        ListNode pre = null;
        ListNode cur = pHead;

        while (cur != null) {
            boolean needDelete = false;
            if (cur.next != null && cur.val == cur.next.val) {
                needDelete = true;
            }

            if (!needDelete) { // 当前节点不重复
                pre = cur;
                cur = cur.next;
            } else {
                int dupValue = cur.val;
                ListNode toBeDel = cur;
                while (toBeDel != null && toBeDel.val == dupValue) {
                    // 这里删除在那还是不涉及前一节点操作，其实主要是找出后面第一个不重复节点
                    toBeDel = toBeDel.next;
                }
                if (pre == null) { //说明删除的节点是头结点
                    pHead = toBeDel;
                } else {
                    pre.next = toBeDel;
                }
                cur = toBeDel;  //这个节点还是可能出现重复，所以不能 =next
            }
        }
        return pHead;
    }


    //========测试代码======
    void test(ListNode pHead) {
        System.out.println("-----------");
        System.out.print("The original list is: ");
        ListNode curr=pHead;
        if(curr!=null) {
            while(curr.next!=null) {
                System.out.print(curr.val+",");
                curr=curr.next;
            }
            System.out.println(curr.val);
        }else {
            System.out.println();
        }
        pHead=deleteDuplication(pHead);
        System.out.print("The result list is: ");
        curr=pHead;
        if(curr!=null) {
            while(curr.next!=null) {
                System.out.print(curr.val+",");
                curr=curr.next;
            }
            System.out.println(curr.val);
        }else {
            System.out.println();
        }
        System.out.println("-----------");
    }


    /**
     * 重复结点位于链表头部
     */
    void test1() {
        ListNode p4=new ListNode(3, null);
        ListNode p3=new ListNode(2, p4);
        ListNode p2=new ListNode(1, p3);
        ListNode p1=new ListNode(1, p2);
        test(p1);
    }

    /**
     * 重复结点位于链表尾部
     */
    void test2() {
        ListNode p4=new ListNode(3, null);
        ListNode p3=new ListNode(3, p4);
        ListNode p2=new ListNode(2, p3);
        ListNode p1=new ListNode(1, p2);
        test(p1);
    }

    /**
     * 重复结点位于链表中部
     */
    void test3() {
        ListNode p4=new ListNode(3, null);
        ListNode p3=new ListNode(2, p4);
        ListNode p2=new ListNode(2, p3);
        ListNode p1=new ListNode(1, p2);
        test(p1);
    }

    /**
     * 连续出现重复结点
     */
    void test4() {
        ListNode p6=new ListNode(3, null);
        ListNode p5=new ListNode(3, p6);
        ListNode p4=new ListNode(2, p5);
        ListNode p3=new ListNode(2, p4);
        ListNode p2=new ListNode(1, p3);
        ListNode p1=new ListNode(1, p2);
        test(p1);
    }

    /**
     * 多个重复结点
     */
    void test5() {
        ListNode p6=new ListNode(3, null);
        ListNode p5=new ListNode(3, p6);
        ListNode p4=new ListNode(3, p5);
        ListNode p3=new ListNode(2, p4);
        ListNode p2=new ListNode(1, p3);
        ListNode p1=new ListNode(1, p2);
        test(p1);
    }

    /**
     * 无重复结点
     */
    void test6() {
        ListNode p6=new ListNode(6, null);
        ListNode p5=new ListNode(5, p6);
        ListNode p4=new ListNode(4, p5);
        ListNode p3=new ListNode(3, p4);
        ListNode p2=new ListNode(2, p3);
        ListNode p1=new ListNode(1, p2);
        test(p1);
    }

    /**
     * 单个结点
     */
    void test7() {
        ListNode p1=new ListNode(6, null);
        test(p1);
    }

    /**
     * null
     */
    void test8() {
        ListNode p1=null;
        test(p1);
    }

    public static void main(String[] args) {
        DeleteDuplicatedNode demo= new DeleteDuplicatedNode();
        demo.test1();
        demo.test2();
        demo.test3();
        demo.test4();
        demo.test5();
        demo.test6();
        demo.test7();
        demo.test8();
    }
}
```


## 总结
1. 删除多个节点时，只需要把重复节点前一个节点的next指向重复节点的后一个节点；
2. 不要把重复节点一个一个删除，先定义一个布尔变量确定当前节点是否重复，然后按1 中的方法删除即可。

<hr />