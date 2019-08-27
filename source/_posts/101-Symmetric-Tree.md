---
title: 101. Symmetric Tree
tags: [Recursive, Tree]
date: 2019-08-28 00:58:34
permalink: Symmetric-tree
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 对称二叉树 
本题和 [剑指Offer(28) 对称的二叉树](https://blogs.rhsphere.com/leetcode/2019/07/09/symmetrical-binary-tree.html) 相似，请完成迭代解法。

### 题目
给定一个二叉树，检查它是否是镜像对称的。

例如，二叉树 [1,2,2,3,4,4,3] 是对称的。

    1
   / \
  2   2
 / \ / \
3  4 4  3
但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:

    1
   / \
  2   2
   \   \
   3    3
说明:

如果你可以运用递归和迭代两种方法解决这个问题，会很加分。

### 思路

如果一个树的左子树与右子树镜像对称，那么这个树是对称的。

因此，该问题可以转化为：两个树在什么情况下互为镜像？

如果同时满足下面的条件，两个树互为镜像：

1. 它们的两个根结点具有相同的值。
2. 每个树的右子树都与另一个树的左子树镜像对称。


时间复杂度：O(n)，因为我们遍历整个输入树一次，所以总的运行时间为 O(n)，其中 n 是树中结点的总数。

空间复杂度：递归调用的次数受树的高度限制。在最糟糕情况下，树是线性的，其高度为 O(n)。因此，在最糟糕的情况下，由栈上的递归调用造成的空间复杂度为 O(n))。


## Java代码

```java
/**
 * @description: leetcode 101 使用递归
 * @author: rhsphere
 * @since: 2019-08-28 00:53 by jdk 1.8
 */
public class StmmetricTree {
    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
    }

    public boolean isSymmetric(TreeNode root) {
        return isMirror(root, root);
    }
    private boolean isMirror(TreeNode p, TreeNode q) {
        if (p == null && q == null) return true;
        if (p == null || q == null) return false;
        return p.val == q.val && isMirror(p.left, q.right) && isMirror(p.right, q.left);
    }
}
```


<hr />