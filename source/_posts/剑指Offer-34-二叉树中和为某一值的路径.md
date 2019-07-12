---
title: 剑指Offer(34) 二叉树中和为某一值的路径
tags: [Tree]
date: 2019-07-11 16:47:27
permalink: path-in-tree
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 二叉树中和为某一值的路径 

### 题目
输入一棵二叉树和一个整数，打印出二叉树中节点值的和为输入整数的所有路径。从树的根节点开始一直到也借点所经过的节点形成一条路径。

### 思路

1. 假设找到了其中一条路径，达到叶结点后，由于没有指向父节点的指针，所以必须 **提前创建一个链表** 存储前面经过的节点。
2. 由于从根节点出发，所以要想用到使用前序遍历。
3. 利用率I按表存储节点，在该节点完成左右子树的路径搜索后（即递归函数结束，返回到其父节点后），要删除 **该节点**，从而记录别的路径。

	具体实现：通过前序遍历，从根节点出发，每次在链表中存储便利到的节点，若到达叶子节点，则根据所有节点的和是否等于输入的整数，判断是否打印输出。在当前节点访问结束后，递归函数将会返回到它的父节点，所以在函数退出之前，要删除链表中的当前节点，以确保返回父节点是，储存的路径刚好是从根节点到父节点。

### 测试用例
1. 功能测试（一条或者多条对应的路径，无对应路径，节点值为正负零）
2. 特殊测试（根节点为null）

## java代码

```java

/**
 * @description:题目：输入一棵二叉树和一个整数，打印出二叉树中结点值的和为输入整数的所有路径。从树的根结点开始往下一直到叶结点所经过的结点形成一条路径。
 * @author: rhsphere
 * @since: 2019-07-11 16:58 by jdk 1.8
 */
public class PathInTree {
    public class TreeNode {
        int val = 0;
        TreeNode left, right;
        public TreeNode(int val) {
            this.val = val;
        }
    }

    public void findPath(TreeNode root, int target) {
    	if (root == null)
    		return;
    	ArrayList<TreeNode> list = new ArrayList<>();
    	printPath(root, target, list);

    }

    private void printPath(TreeNode node, int target, ArrayList<Integer> list) {
    	if (node == null)
    		return;
    	list.add(node.val);
    	target -= node.val;
    	if (target == 0 && node.left == null && node.right == null) {
    		for (Integer integer : list) {
    			System.out.print(integer + " ");
    		}
    		System.out.println();
    	} else {
    		printPath(node.left, target, list);
    		printPath(node.right, target, list);
    	}
    	list.remove(list.size() - 1);
    }
}


```


## 牛客网代码

```java
/*
 * 几个要点：
 * 1. 将nodeList和pathList定义成全局变量，避免在方法中的多次传递
 * 2. 在pathList中添加nodeList时，因为nodeList会不断变化，所以必须新建一个list存入
 *    复制ArrayList的方法：newList=new ArrayList<Integer>(oldList)(复制内容，而不是复制地址，
 *    注意与newList=oldList的区分）
 * 3. 在当前结点完成左右子树的路径搜索后，记得删除nodeList中的当前结点
 * 4. target是基本数据类型int，不会受到方法的影响而改变
 */
public class PathInTree2 {
    public static class TreeNode {
        int val = 0;
        TreeNode left, right;
        public TreeNode(int val) {
            this.val = val;
        }
    }
    private ArrayList<Integer> nodeList = new ArrayList<>();
    private ArrayList<ArrayList<Integer>> pathList = new ArrayList<>();

    pubilc ArrayList<ArrayList<Integer>> findPath(TreeNode node, int target) {
    	if (node == null)
    		return pathList;
    	nodelist.add(node.val);
    	target -= node.val;
    	if (target == 0 && node.left == null && node.right == null) {
    		int i = 0;
    		while (i < pathList.size() && nodeList.size() < pathList.get(i).size())
    			i++;
    		path.add(i, new ArrayList<Integer>(nodeList));
    	} else {
    		pathList = findPath(node.left, target);
    		pathList = findPath(node.right, target);
    	}
    	nodeList.remove(nodeList.size() - 1);
    	return pathList;
    }
}


```

## 总结
1. 二叉树的许多题目都与遍历（包括层次遍历）有关，要深刻理解；根据节点的位置判断使用哪一种遍历。
2. 而二叉树遍历过程没有父节点指针，要保存路径的话，需要创建容器存储之前的节点。
3. 熟悉这道题中在每次递归函数结束前删除当前节点的操作，这可以确保返回到父节点时路径刚好是从根节点到父节点。



<hr />