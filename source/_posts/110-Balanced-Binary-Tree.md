---
title: 110. Balanced Binary Tree
tags: [Recursive, Tree]
date: 2019-08-29 01:00:23
permalink: balanced-binary-tree
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

# 平衡二叉树
参考[剑指Offer(55) 题目二 平衡二叉树判定](https://blogs.rhsphere.com/leetcode/2019/08/02/tree-depth.html)的思路。

[LeetCode 110 英文版](https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/)
[LeetCode 110 中文版](https://leetcode-cn.com/problems/balanced-binary-tree/)



# Java代码

```java
/**
 * @description: leetcode 110
 * @author: rhsphere
 * @since: 2019-08-29 01:08 by jdk 1.8
 */
public class BalancedBinaryTree {
    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int x) {
            val = x;
        }
    }

    public boolean isBalanced(TreeNode root) {
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
        return Math.abs(left - right) > 1 ? -1 : Math.max(left + 1, right + 1);
    }
}
```



# 题目
给定一个二叉树，判断它是否是高度平衡的二叉树。

本题中，一棵高度平衡二叉树定义为：

一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过1。

示例 1:

给定二叉树 [3,9,20,null,null,15,7]

    3
   / \
  9  20
    /  \
   15   7
返回 true 。

示例 2:

给定二叉树 [1,2,2,3,3,null,null,4,4]

       1
      / \
     2   2
    / \
   3   3
  / \
 4   4
返回 false 。




<hr />