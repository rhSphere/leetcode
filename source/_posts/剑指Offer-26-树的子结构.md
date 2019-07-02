---
title: 剑指Offer(26) 树的子结构
tags: [Tree, Recursive]
date: 2019-07-02 12:23:41
permalink: substructure-in-tree
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 树的子结构
### 题目
输入两棵二叉树A和B，判断B是不是A的子结构。

### 思路 
1. 先对A树进行遍历，找到与B树的根节点值相同的节点R；
2. 判断A树中以R为根节点的子树是否包含B树一样的结构。

### 测试用例
1. 功能测试（A和B为普通二叉树；B是或者不是A的子结构）
2. 特殊测试（任意一个或者两个数的根节点为null；左斜、右斜树）


## java代码
```java
**
 * @description: 剑指Offer26 树的子结构
 * @author: rhsphere
 * @since: 2019-07-02 12:19 by jdk 1.8
 */
public class SubstructureInTree {
	public class TreeNode {
		int val;
		TreeNode left;
		TreeNode right;
		public TreeNode(int val) {
			this.val = val;
		}
	}
	//主程序
	public boolean hasSubTree(TreeNode root1, TreeNode root2) {
		if (root1 == null || root2 == null)
			return false;
//        boolean result=false;
//        if(equal(root1.val, root2.val)) {
//          result = doesTree1HasTree2(root1, root2);
//          if(!result)
//              result=hasSubtree(root1.left, root2)
//              ||hasSubtree(root1.right, root2);
//        }
//        return result;
        //上面几行可以直接写成：
		return doesTree1HasTree2(root1, root2) || hasSubtree(root1.left, root2)
				|| hasSubtree(root1.right, root2);
	}
	//判断root节点开始的子树中各个节点是否相同
	private boolean doesTree1HasTree2(TreeNode root1, TreeNode root2) {
		if (root2 == null) return true;
		if (root1 == null) return true;
		return equal(root1.val, root2.val) && doesTree1HasTree2(root1.left, root2.left)
				&& doesTree1HasTree2(root1.right, root2.right);
	}
	//判断两个浮点数是否相同
	private boolean equal(double num1, double num2) {
		if (Math.abs(num1 - num2) < 0.00000001)
			return true;
		return false;
	}
}
```

## 总结
1. 本题是对二叉树遍历的扩展，利用递归比较简洁方便；
2. 浮点数判等方法，不能直接用 "==" 判断。


<hr />