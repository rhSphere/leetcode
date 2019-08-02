---
title: 剑指Offer(55) 二叉树的深度
tags: [Tree]
date: 2019-08-02 19:29:45
permalink: tree-depth
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

# 二叉树的深度 
题目一：二叉树的深度
题目二：平衡二叉树

## 二叉树的深度
输入一棵二叉树的根结点，求该树的深度。从根结点到叶结点依次经过的/结点（含根、叶结点）形成树的一条路径，最长路径的长度为树的深度。


### 思路
简洁理解：

　　树的深度=max(左子树深度，右子树深度)+1，采用递归实现。


### 测试用例
1. 功能测试（左斜树、右斜树、普通树）

2. 边界值测试（一个结点）

3. 特殊测试（null）

## java代码
```java
/**
 * @description: 剑指offer55
 * @author: rhsphere
 * @since: 2019-08-02 19:29 by jdk 1.8
 */
public class TreeDepth {
	    public class TreeNode {
        int val = 0;
        TreeNode left, right;

        public TreeNode(int val) {
            this.val = val;
        }
    }

    public int treeDepth(TreeNode root) {
    	if (root == null)
    		return 0;

    	int left = treeDepth(root.left);
    	int right = treeDepth(root.right);
    	return Math.max(left + 1, right + 1);
    }
}
```


## 总结
1. 深度从递归的角度理解，很赞，要记住。



# 平衡二叉树

## 平衡二叉树判定

输入一棵二叉树的根结点，判断该树是不是平衡二叉树。如果某二叉树中任意结点的左右子树的深度相差不超过1，那么它就是一棵平衡二叉树。

### 思路
　在(55-1) 二叉树的深度基础上修改：计算树的深度，树的深度=max(左子树深度，右子树深度)+1。在遍历过程中，判断左右子树深度相差是否超过1，如果不平衡，则令树的深度=-1，用来表示树不平衡。最终根据树的深度是否等于-1来确定是否为平衡树。


### 测试用例

1. 功能测试（左斜树、右斜树、平衡或者不平衡树）

2. 特殊测试（一个结点，null）


## java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-02 20:29 by jdk 1.8
 */
public class BanlancedBST {
    public class TreeNode {
        int val = 0;
        TreeNode left, right;
        TreeNode (int val) {
            this.val = val;
        }
    }

    public boolean IntBalanced(TreeNode root) {
    	return getDepth(root) != -1;
    }

    private int getDepth(TreeNode root) {
    	if (root == null)
    		return 0;
    	int left = getDepth(root.left);
    	if (left == -1)
    		return -1;
    	int right = getDepth(root.right);
    	if (right == -1)
    		return -1;

    	return Math.abs(left - right) > 1 ? -1 : Math.max(left, right) + 1;
    }
}
```


## 总结

1. 在判断出树不平衡后，进行剪枝（即代码中直接返回-1，不再对其他子树进行判断），以提高效率。




<hr />