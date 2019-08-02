---
title: 剑指Offer(54) 二叉搜索树的第k大节点
tags: [BST]
date: 2019-08-02 14:39:59
permalink: kth-node-in-BST
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 二叉搜索树的第K大节点 

### 题目
给定一棵二叉搜索树，请找出其中的第k小的结点。

### 思路
设置全局变量index=0，对BST进行中序遍历，每遍历一个结点，index+1，当index=k时，该结点即为所求结点。

### 测试用例
1. 功能测试（左斜树、右斜树、普通树）

2. 边界值测试（k=1,k=结点数目）

3. 特殊测试（null，k<=0，k>结点数目）

## java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-02 14:42 by jdk 1.8
 */
public class KthNodeInBST {
    public class TreeNode {
        int val = 0;
        TreeNode left, right;
        public TreeNode(int val) {
            this.val = val;
        }
    }

    int index = 0;

    public TreeNode kthNode(TreeNode root, int k) {
    	TreeNode p = null;

    	if (root == null || k <= 0)
    		return p;
    	p = getKthNode(root, k);
    	return p;
    }

    private TreeNode getKthNode(TreeNode root, int k) {
    	TreeNode kthNode = null;

    	if (root.left != null)
    		kthNode = getKthNode(root.left, k);

    	if(kthNode == null) {
    		index++;
    		if (k == index)
    			kthNode = root;
    	}

    	if (kthNode == null && root.right != null)
    		kthNode = getKthNode(root.right, k);

    	reurn kthNode;
    }
}
```

## 总结

1. 熟练掌握二叉搜索树和中序遍历。

2. 用中序遍历实现功能时，一定要注意返回值是否满足要求。

<hr />