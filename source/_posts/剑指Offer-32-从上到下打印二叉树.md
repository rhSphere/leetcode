---
title: 剑指Offer(32) 从上到下打印二叉树
tags: [Tree]
date: 2019-07-10 19:04:59
permalink: print-tree
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

# 从上往下打印二叉树

## 题目一
（一）从上往下打印出二叉树的每一个节点，每一层的节点按照从左到右的顺序打印。

### 思路和代码

不分行从上到下打印二叉树，即二叉树的层序遍历，节点满足先进先出的原则，采用队列。每从队列取出头部节点并打印，若有子节点，把子节点放入队列尾部，直到所有节点打印完毕。

```java
/**
 * @description: 层序遍历
 * @author: rhsphere
 * @since: 2019-07-10 19:08 by jdk 1.8
 */
public class PrintTree1 {
	public class TreeNode {
		int val = 0;
		TreeNode left, right;
		public TreeNode(int val) {
			this.val = val;
		}
	}

	public void printTree1(TreeNode root) {
		if (root == null) 
			return;
		Queue<TreeNode> queue = new LinkedList<>();
		queue.add(root);
		while (!queue.isEmpty()) {
			TreeNode node = queue.element();
			if (node.left != null)
				queue.add(node.left);
			if (node.right != null)
				queue.add(node.right);
			System.out.print(queue.remove().val + " ");
		}
	}
}
```



## 题目二
（二）从上到下按层打印二叉树，同一层的结点按从左到右的顺序打印，每一层打印到一行。

### 思路和代码

同样使用队列，但是比第一题增加两个变来给你：当前层节点数目pCount，下一层节点数目nextCount。根据当前成节点数目来打印当前层节点，同时计算下一层节点数目，之后令pCount等于nextCount，重复循环，知道打印完毕。


```java
**
 * @description:
 * @author: rhsphere
 * @since: 2019-07-10 21:03 by jdk 1.8
 */
public class PrintTree2 {
	public void printTree2(TreeNode root) {
		if (root == null)
			return;
		Queue<TreeNode> queue = new LinkedList<>();
		queue.add(root);
		TreeNode current;
		int pCount = 0; //当前层的节点数
		int nextCount = 1; //下一层节点数
		while (!queue.isEmpty()) {
			pCount = nextCount;
			nextCount = 0;
			for (int i = 1; i <= pCount; i++) {
				current =  queue.element();
				if (current.left ！= null) {
					queue.offer(current.left);
					nextCount++;
				}
				if (current.right != null) {
					queue.offer(current.right);
					nextCount++;
				}
				System.out.print(queue.remove().val + " ");
			}
			System.out.println();
		}
	}
}
```



## 题目三
（三）请实现一个函数按照之字形顺序打印二叉树，即第一行按照从左到右的顺序打印，第二层按照从右到左的顺序打印，第三行再按照从左到右的顺序打印，其他行以此类推。

### 思路和代码

采用两个栈，对于不同层的节点，一个栈用于正向存储，一个栈用于逆向存储，打印出来就正好是相反方向。

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-07-11 10:33 by jdk 1.8
 */
public class PrintTree3 {
	public void printTree3(TreeNode root) {
		if (root == null)
			return;
		Stack<TreeNode> stack1 = new Stack<>();
		Stack<TreeNode> stack2 = new Stack<>();
		TreeNode node = null;

		stack1.push(root);
		while (!stack.empty() || !stack.empty()) {
			while (!stack.empty()) {
				node = stack1.pop();
				if (node.left != null)
					stack2.push(node.left);
				if (node.right != null)
					stack2.push(node.right);
				System.out.println(node.val + " ");
			}
			System.out.println();
			while (!stack2.empty()) {
				node = stack2.pop();
				if (node.right != null)
					stack1.push(node.right);
				if (node.left != null)
					stack1.push(node.left);
				System.out.print(node.val + " ");
			}
			System.out.println();
		}
	}
}
```






<hr />