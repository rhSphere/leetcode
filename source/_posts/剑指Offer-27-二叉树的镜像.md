---
title: 剑指Offer(27) 二叉树的镜像
tags: [Tree]
date: 2019-07-09 09:46:35
permalink: mirror-of-binary-tree
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 二叉树的镜像

### 题目
请完成一个函数，输入一个二叉树，该函数输出它的镜像。

### 思路

先画图，可以看到用递归很容易求解：先前序遍历，对每个节点交换左右子节点。

递归使用的3个条件：1）一个问题的解可以分解成几个问题的解；2）这个问题与分解之后的子问题，除了数据规模不同，求解思路完全一样；3）存在递归终止条件。

### 测试用例
1. 功能测试（普通二叉树；左斜树、右斜树；一个节点）
2. 特殊测试（根节点为null）

## java代码

```java
/**
 * @description: 输入一个二叉树，该函数输出它的镜像
 * @author: rhsphere
 * @since: 2019-07-09 10:16 by jdk 1.8
 */
public class MirrorOfBinaryTree {
    public class TreeNode {
        int val = 0;
        TreeNode left;
        TreeNode right;
        public TreeNode(int val) {
            this.val = val;
        }
    }

    public void mirror(TreeNode root) {
        if (root == null) return;
        //交换左右子节点
        TreeNode tmpNode = root.left;
        root.left = root.right;
        root.right = tmpNode;

        mirror(root.left);
        mirror(root.right);
    }
}
```


<hr />