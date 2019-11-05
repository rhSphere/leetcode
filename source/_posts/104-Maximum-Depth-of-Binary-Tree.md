---
title: 104. Maximum Depth of Binary Tree
tags: [Recursive, Tree]
date: 2019-08-29 00:45:11
permalink: max-depth-of-binary-tree
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

# 二叉树的最大深度 
参考[剑指Offer(55) 题目一 二叉树的深度](https://blogs.rhsphere.com/leetcode/2019/08/02/tree-depth.html)的思路。

[英文版](https://leetcode.com/problems/maximum-depth-of-binary-tree/)
[中文版](https://leetcode-cn.com/problems/maximum-depth-of-binary-tree/)

# debug跟踪

通过debug跟踪发现，
对于树
     0
   1   2
 3  4 5  6
7
一直递归计算left_height，直到7的左右子节点，然后返回0，然后递归栈向上返回一层，计算3的左右子树高度，于是得到 max{1, 0}=1；
然后递归栈返回计算1的左右子树，左子树已经计算出来了，递归计算右子树4的高度，依次类推。。。

可以用  com.ludepeng.datastruct.base.datastruct.tree.leetcode104.DepthOfTree 进行查看。


# Java代码

```java
/**
 * @description: leetcode 104
 * @author: rhsphere
 * @since: 2019-08-29 00:46 by jdk 1.8
 */
public class MaxDepthOfBinaryTree {
    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int x) {
            val = x;
        }
    }

    public int maxDepth(TreeNode root) {
        if (root == null) {
            return 0;
        } else {
            int left_height = maxDepth(root.left);
            int right_height = maxDepth(root.right);
            return Math.max(left_height, right_height) + 1;
        }
    }
}
```


# 题目
给定一个二叉树，找出其最大深度。

二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。

说明: 叶子节点是指没有子节点的节点。

示例： 给定二叉树 [3,9,20,null,null,15,7]，

    3
   / \
  9  20
    /  \
   15   7
返回它的最大深度 3 。

## 思路
时间复杂度：我们每个结点只访问一次，因此时间复杂度为 O(N)
其中 N 是结点的数量。
空间复杂度：在最糟糕的情况下，树是完全不平衡的，例如每个结点只剩下左子结点，递归将会被调用 N 次（树的高度），因此保持调用栈的存储将是 O(N) 但在最好的情况下（树是完全平衡的），树的高度将是 log(N)。因此，在这种情况下的空间复杂度将是 O(log(N))。




<hr />