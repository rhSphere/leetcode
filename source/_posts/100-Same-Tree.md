---
title: 100. Same Tree
tags: [Recursive, Tree]
date: 2019-08-28 00:33:29
permalink: same-tree
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 相同的树 

思考：本题使用迭代法如何做？

### 题目
给定两个二叉树，编写一个函数来检验它们是否相同。

如果两个树在结构上相同，并且节点具有相同的值，则认为它们是相同的。

示例 1:

输入:       1         1
          / \       / \
         2   3     2   3

        [1,2,3],   [1,2,3]

输出: true
示例 2:

输入:      1          1
          /           \
         2             2

        [1,2],     [1,null,2]

输出: false
示例 3:

输入:       1         1
          / \       / \
         2   1     1   2

        [1,2,1],   [1,1,2]

输出: false


### 思路

最简单的策略是使用递归。首先判断 p 和 q 是不是 null，然后判断它们的值是否相等。

时间复杂度 : O(N)O(N)，其中 N 是树的结点数，因为每个结点都访问一次。

空间复杂度 : 最优情况（完全平衡二叉树）时为 O(\log(N))O(log(N))，最坏情况下（完全不平衡二叉树）时为 {O}(N)O(N)，用于维护递归栈。


## Java代码

```java
**
 * @description: leetcode 100 使用递归
 * @author: rhsphere
 * @since: 2019-08-28 00:33 by jdk 1.8
 */
public class SameTree {
    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
     }

    public boolean  isSameTree(TreeNode p, TreeNode q) {
        if (p == null && q == null)
            return true;
        if (p == null || q == null)
            return false;
        if (p.val != q.val)
            return false;
        return isSameTree(p.left, q.left) && isSameTree(p.right, q.right);
    }
}
```

<hr />