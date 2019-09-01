---
title: 剑指Offer(8) 二叉树的下一个节点
tags: [BinaryTree]
date: 2019-03-28 12:24:39
permalink: next-node-in-binary-tree
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 二叉树的下一个节点

### 题目
给定一棵二叉树和其中的一个结点，如何找出中序遍历顺序的下一个结点？ 树中的结点除了有两个分别指向左右子结点的指针以外，还有一个指向父结点的指针。

### 思路
首先自己在草稿纸上画图，进行分析（不再展开）。可以发现下一个结点的规律为：
1. 若当前节点有右子树，旗下一个节点为右子树中最左子节点；
2. 若当前节点无右子树时，
  1. 若当前节点为其父节点的左子结点时，其子啊一个节点为其父节点；
  2. 若当前节点为其父节点的右子节点时，继续向上遍历父节点的父节点，直到找到一个节点是其父节点的左子结点（与(1)中判断相同），该节点的父节点即为下一节点。

### 测试用例

1. 正常二叉树
2. 左斜树、右斜树
3. 单个节点
4. null
5. 不同位置节点的下一节点(包含下一个节点为当前节点的右子树节点，右子树的最左子节点，父节点，跨层的父节点等；当前节点没有下一个节点)

## Java代码

```java 
public class NextNodeInBinaryTrees {
    private class TreeLinkNode {
        int val;

        TreeLinkNode left = null;
        TreeLinkNode right = null;
        TreeLinkNode parent = null;

        TreeLinkNode(int val) {
            this.val = val;
        }
    }

    public TreeLinkNode getNext(TreeLinkNode pNode) {
        if (pNode == null) {
            System.out.print("节点为null");
            return null;
        }

        if (pNode.right != null) {
            pNode = pNode.right;
            while (pNode.left != null) {
                pNode = pNode.left;
            }
            return pNode;
        }

        while (pNode.parent != null) {
            if (pNode == pNode.parent.left) {
                return pNode.parent;
            }
            pNode = pNode.parent;
        }
        return null;
    }
}
```

下面是测试代码：

```java
public class NextNodeInBinaryTrees {
    // ==================================测试代码==================================
    // 创建树较为繁琐，未包括所有测试代码。
    public void test1() {
        TreeLinkNode node = null;
        TreeLinkNode nextNode = getNext(node);
        if (nextNode != null)
            System.out.println(nextNode.val);
        else
            System.out.println("无下一结点");
    }

    public void test2() {
        TreeLinkNode node1 = new TreeLinkNode(1);
        TreeLinkNode node2 = new TreeLinkNode(2);
        TreeLinkNode node3 = new TreeLinkNode(3);
        TreeLinkNode node4 = new TreeLinkNode(4);
        node1.left = node2;
        node1.right = node3;
        node2.parent = node1;
        node3.parent = node1;
        node4.left = node1;
        node1.parent = node4;
        TreeLinkNode nextNodeOf1 = getNext(node1);
        TreeLinkNode nextNodeOf2 = getNext(node2);
        TreeLinkNode nextNodeOf3 = getNext(node3);
        TreeLinkNode nextNodeOf4 = getNext(node4);
        if (nextNodeOf1 != null)
            System.out.println("1结点的下一个结点值为：" + nextNodeOf1.val);
        else
            System.out.println("1结点无下一结点");
        if (nextNodeOf2 != null)
            System.out.println("2结点的下一个结点值为：" + nextNodeOf2.val);
        else
            System.out.println("2结点无下一结点");
        if (nextNodeOf3 != null)
            System.out.println("3结点的下一个结点值为：" + nextNodeOf3.val);
        else
            System.out.println("3结点无下一结点");
        if (nextNodeOf4 != null)
            System.out.println("4结点的下一个结点值为：" + nextNodeOf4.val);
        else
            System.out.println("4结点无下一结点");
    }

    public static void main(String[] args) {
        NextNodeInBinaryTrees demo = new NextNodeInBinaryTrees();
        System.out.print("test1:");
        demo.test1();
        System.out.print("test2:");
        demo.test2();
    }
}
```

## 总结

1. 在面对复杂问题时要学会画图和举例分析。
2. 在分情况讨论时，一定要考虑到所有情况，这些都是在写代码前需要考虑到的。

<hr />