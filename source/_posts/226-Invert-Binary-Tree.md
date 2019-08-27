---
title: 226. Invert Binary Tree
tags: [Recursive, Tree]
date: 2019-08-28 01:12:36
permalink: invert-binary-tree
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

##  翻转二叉树
注意区分和[剑指Offer(27) 二叉树的镜像](https://blogs.rhsphere.com/leetcode/2019/07/09/mirror-of-binary-tree.html)的区别，另一种迭代解法待完成。

### 题目

翻转一棵二叉树。

示例：

输入：

     4
   /   \
  2     7
 / \   / \
1   3 6   9
输出：

     4
   /   \
  7     2
 / \   / \
9   6 3   1
备注: 这个问题是受到 Max Howell 的 原问题 启发的 ：

谷歌：我们90％的工程师使用您编写的软件(Homebrew)，但是您却无法在面试时在白板上写出翻转二叉树这道题，这太糟糕了。

### 思路

既然树中的每个节点都只被访问一次，那么时间复杂度就是 O(n)O(n)，其中 nn 是树中节点的个数。在反转之前，不论怎样我们至少都得访问每个节点至少一次，因此这个问题无法做地比 O(n)O(n) 更好了。

本方法使用了递归，在最坏情况下栈内需要存放 O(h)O(h) 个方法调用，其中 hh 是树的高度。由于 h\in O(n)h∈O(n)，可得出空间复杂度为 O(n)O(n)。


## Java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-28 01:06 by jdk 1.8
 */
public class InvertBinaryTree {
    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
    }
    public TreeNode invertTree(TreeNode root) {
        if (root == null) return null;
        //这里的left、right顺序注意
        TreeNode left = invertTree(root.left);
        TreeNode right = invertTree(root.right);
        root.left = right;
        root.right = left;
        return root;
    }
}
```

<hr />