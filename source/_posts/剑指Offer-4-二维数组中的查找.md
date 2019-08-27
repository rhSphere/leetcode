---
title: 剑指Offer(4) 二维数组中的查找
tags: [Array, Search]
date: 2019-03-24 00:36:36
permalink: find-in-partially-sorted-matrix
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 二维数组中的查找 

### 题目
在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。

### 思路
查找整数时，如果从左上角开始查找，情况较为复杂，可以转换思路，从右上角开始查找：左边数字比较小，下边数字比较大，容易进行判断。

**当我们需要解决一个复杂的问题是，一个很有效的办法就是从一个具体的问题入手，通过分析简单具体的例子，寻找普遍规律。**

### 测试用例：

1. 要查找的数字在数组中
2. 要查找的数字不在数组中
3. 数组为空
4. 数组不满足大小规则
5. 数组每行长度不一致

## Java代码及复杂度

```java
public class FindInPartiallySortedMatrix {
	/*
     * 判断二维数组matrix中是否含有整数a
     * 返回值为a的下标，{-1，-1}代表不存在
     */

	public int[] find(int[][] martrix, int a) {
		int[] index = {-1, -1};

		if (matrix == null || matrix.length <= 0) {
			System.out.println("数组无效");
			return index;
		}
		int columns = matrix[0].length;
		for (int i = 0; i < matrix.length; i) {
			if (matrix[i].length != columns) {
				System.out.println("数组列数不一致");
				return index;
			}

			for (int j = 0; j < matrix[i].length; j++) {
				if (i == 0 && j == 0)
					break;	//matrix[0][0]不比较
				if (i == 0) { //第一行的数,仅和前一列比较
					if (matrix[i][j] < matrix[i][j - 1]){
						System.out.print("数组中数字大小不符合要求")；
						return index;
					}
				} else if (j == 0) { //第一列的，仅和前一行比较
					if (matrix[i][j] < matrix[i - 1][j]) {
						System.out.print("数组中数字大小不符合要求")；
						return index;
					}
				} else if (matrix[i][j] < matrix[i - 1][j] || matrix[i][j] < matrix[i][j - 1]){
					System.out.print("数组中数字大小不符合要求")；
						return index;
				}
			}
		}

		//查找过程
		int row = 0;  //行数
		int col = matrix[0].length - 1;  //列数
		while (row <= matrix.length - 1 && col >= 0) {
			if (a == matrix[row][col]) {
				index[0] = row;
				index[1] = col;
				System.out.println("数字" + a + "在二维数组中的下标为： " + index[0] + ", " + index[1]);
				return index;
			} else if (a < matrix[row][col]) {
				col--;
			} else {
				row++;
			}
		}
		System.out.println("数组中不含数字" + a);
		return index;
	}
}
```

在同一个类中，与上面的函数拆开的测试代码，为了函数更加简洁。

```java
public class FindInPartiallySortedMatrix {
	// 1 2 8 9
    // 2 4 9 12
    // 4 7 10 13
    // 6 8 11 15
    // 要查找的数在数组中
    public void test1() {
        System.out.print("test1：");
        int[][] matrix = { { 1, 2, 8, 9 }, { 2, 4, 9, 12 }, { 4, 7, 10, 13 }, { 6, 8, 11, 15 } };
        int[] index = find(matrix, 7);
    }
 
    // 1 2 8 9
    // 2 4 9 12
    // 4 7 10 13
    // 6 8 11 15
    // 要查找的数不在数组中
    public void test2() {
        System.out.print("test2：");
        int[][] matrix = { { 1, 2, 8, 9 }, { 2, 4, 9, 12 }, { 4, 7, 10, 13 }, { 6, 8, 11, 15 } };
        int[] index = find(matrix, 5);
    }
 
    // 数组为空
    public void test3() {
        System.out.print("test3：");
        int[][] matrix = null;
        int[] index = find(matrix, 7);
    }
 
    // 1 2 8 9
    // 4 3 9 12
    // 4 7 10 13
    // 6 8 11 15
    // 数组不满足大小规则
    public void test4() {
        System.out.print("test4：");
        int[][] matrix = { { 1, 2, 8, 9 }, { 4, 3, 9, 12 }, { 4, 7, 10, 13 }, { 6, 8, 11, 15 } };
        int[] index = find(matrix, 7);
    }
 
    // 数组每行长度不一致
    public void test5() {
        System.out.print("test5：");
        int[][] matrix = { { 1, 2, 8 }, { 4, 3, 9, 12 }, { 4, 7, 10 }, { 6, 8, 11, 15 } };
        int[] index = find(matrix, 7);
    }
 
    public static void main(String[] args) {
        FindInPartiallySortedMatrix f = new FindInPartiallySortedMatrix();
        f.test1(); // 注意下标是从0开始的
        f.test2();
        f.test3();
        f.test4();
        f.test5();
    }
}
```

### 不含测试代码(简化版)

上面代码考虑了数组数字大小不符合规则的情况，较为繁琐。下面为剑指Offer4 二维数组中的查找(简化版)：

```java 
public class Solution {
	public boolean Find(int target, int[][] array) {
		if (array == null || array.length <= 0)
			return false;

		int row = 0;
		int col = array[0].length - 1;
		while (row <= array.length - 1 && col >= 0) {
			if (target == array[row][col]) {
				return false;
			} else if (target < array[row][col]) {
				col--;
			} else {
				row++;
			}
		}
		return false;
	}
}
```


<hr />