---
title: 剑指Offer(36) 二叉搜索树与双向链表
tags: [Tree]
date: 2019-07-14 19:45:49
permalink: convert-binary-search-tree
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

# 二叉搜索树与双向链表

## 题目
  输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的双向链表，要求不能创建任何新的节点，只能调整树中节点指针。

## 思路
	二叉搜索树、排序链表，想到使用中序遍历。

要实现双向链表，必须知道当前节点的前一个节点。根据中序遍历，可以知道，当遍历到根节点的时候，左子树已经转化成了一个排序的链表了，根节点的前一节点就是该链表的最后一个节点（这个节点必须记录下来，将遍历函数的返回值设置为该节点即可），连接根节点和前一个节点，此时链表最后一个节点就是根节点了。再处理右子树，遍历右子树，将右子树的最小节点和根节点连接起来即可。左右子树的转化采用递归即可。

首先想象一下中序遍历的大概代码结构（先处理左子树，再处理根节点，之后处理右子树），假设左子树处理完了，就要处理根节点，而根节点必须知道左子树的最大节点，所以要用函数返回值记录下来；之后处理右子树，右子树的最小节点（也是用中序遍历得到）要和根节点链接。


## 测试用例
1. 功能测试(一个节点；左、右斜树；完全二叉树；普通二叉树)
2. 特殊测试(根节点为null)

# java代码

## 采用中序遍历非递归的方式

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-11-05 10:28 by jdk 1.8
 */
public class BSTConvertToDoubleList {
    public class TreeNode {
        int val;
        TreeNode left, right;
        public TreeNode(int val) {
            this.val = val;
        }
    }

    public TreeNode convert(TreeNode root) {
        TreeNode head = null;
        TreeNode pre = null;

        Stack<TreeNode> stack = new Stack<>();
        TreeNode cur = root;

        while (!stack.empty() || cur != null) {
            if (cur != null) {
                stack.push(cur);
                cur = cur.left;
            } else {
                TreeNode node = stack.pop();
                if (head == null) {
                    head = node;
                    pre = node;
                } else {
                    node.left = pre;
                    pre.right = node;
                    pre = node;
                }
                cur = node.right;
            }
        }
        return head;
    }

}

```

上面中序遍历里面if else嵌套过多，不便于阅读，进行如下修改。

```java

public TreeNode convert(TreeNode root) {
	TreeNode head = null;
	TreeNode pre = null;
	TreeNode cur = root;

	Stack<TreeNode> stack = new Stack<>();
	while (!stack.empty() || cur != null) {
		while (cur != null) {
			stack.push(cur);
			cur = cur.left;
		}

		TreeNode node = stack.pop();
		if (head == null) {
			head = node;
			pre = node;
		} else {
			node.left = pre;
			pre.right = node;
			pre = node;
		}
		cur = node.right;
	}
	return head;
}

```


## 采用递归的方法

//TODO

<hr />