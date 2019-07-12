---
title: 剑指Offer(28) 对称的二叉树
tags: [Tree]
date: 2019-07-09 10:55:04
permalink: symmetrical-binary-tree
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 对称的二叉树

### 题目

实现一个函数，用来判断一棵二叉树是不是对称的。如果一棵二叉树和它的镜像一样，那么它是对称的。

### 思路

还是画图分析，不用分析根结点，只需要分析左右子树。可以看出，左右子树刚好是呈镜像的两颗二叉树，所以：对左子树采用（父-左-右）的前序遍历，右子树采用（父-右-左）的前序遍历，遍历时判断两个结点位置的值是否相等即可。

也可以这样理解：左树的左子树等于右树的右子树，左树的右子树等于右树的左子树，对应位置刚好相反，判断两子树相反位置上的值是否相等即可。

使用递归。

### 测试用例
1. 功能测试（对称二叉树；结构不对称的二叉树；结构对称但值不对称二叉树）
2. 特殊测试（根节点为null；单个节点；所有节点的值都相等的二叉树）

## java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-07-09 10:18 by jdk 1.8
 */
public class SymmetricalBinaryTree {
    public class TreeNode {
        int val = 0;
        TreeNode left;
        TreeNode right;
        public TreeNode(int val) {
            this.val = val;
        }
    }

    public boolean isSymmetrical(TreeNode root) {
    	if (root == null) 
    		return true; //根节点为null时，认为是对称的
    	return isEqual(root.left, root.right);
    }

    private boolean isEqual(TreeNode la, TreeNode lb) {
    	if (la == null && lb == null)
    		return true;
    	if (la == null || lb == null)
    		return false;
    	return la.val == lb.val
    		   && isEqual(la.left, lb.right)
    		   && isEqual(la.right, lb.left);
    }

}
```

<hr />