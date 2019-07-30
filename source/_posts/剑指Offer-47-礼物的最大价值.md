---
title: 剑指Offer(47) 礼物的最大价值
tags: [Dynamic Programming, matrix]
date: 2019-07-30 10:52:27
permalink: max-value-of-gifts
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 礼物的最大价值

### 题目
在一个m×n的棋盘的每一格都放有一个礼物，每个礼物都有一定的价值（价值大于0）。你可以从棋盘的左上角开始拿格子里的礼物，并每次向左或者向下移动一格直到到达棋盘的右下角。给定一个棋盘及其上面的礼物，请计算你最多能拿到多少价值的礼物？

### 思路
动态规划：定义f(i,j)为到达(i,j)位置格子时能拿到的礼物总和的最大值，显然有边界条件，f(i, 0) = arr[0][0] + arr[i][0]， f(0, j) = arr[0][0] + arr[0][j]。则有状态转移方程：f(i,j)=max{f(i,j),f(i,j)} + arr(i,j)。

　　同上道题一样，如果直接使用递归会产生大量的重复计算，因此，创建辅助的数组来保存中间计算结果。

　　辅助数组不用和m*n的二维数组一样大，只需要保存上一层的最大值就可以。代码中使用长度为列数n的一位数组作为辅助数组，注释部分为二维辅助数组。

### 测试用例
1. 功能测试（多行多列，一行多列，多行一列，一行一列）

2. 特殊测试（null）

## java代码

### 二维数组的辅助空间

```java

/**
 * @description:
 * @author: rhsphere
 * @since: 2019-07-30 10:55 by jdk 1.8
 */
public class Matrix_MaxValueOfGifts {
	public int maxValueOfGifts(int[][] values) {
		if (values == null || values.length <= 0 || values[0].length <= 0)
			return 0;
		int rows = values.length;
		int cols = values[0].length;
		int[][] cache = new int[rows][cols];

		cache[0][0] = values[0][0];

		for (int i = 1; i < rows; i++)
			cache[i][0] = cache[i-1][0] + values[i][0];
		for (int j = 1; j < cols; j++)
			cache[0][j] = cache[0][j-1] + values[0][j];

		for (int i = 1; i < rows; i++) {
			for (int j = 1; j < cols; j++) {
				if (cache[i-1][j] > cache[i][j-1])
					cache[i][j] = cahce[i-1][j] + values[i][j];
				else
					cache[i][j] = cache[i][j-1] + values[i][j]
			}
		}
		return cache[rows-1][cols-1];
	}

    public static void main(String[] args) {
        MaxValueOfGifts demo = new MaxValueOfGifts();
        int[][] values = {{1, 10, 3, 8}, {12, 2, 9, 6}, {5, 7, 4, 11}, {3, 7, 16, 5}};
        System.out.print("路径：");
        System.out.println("最大值为：" + demo.maxValueOfGifts(values));
    }
}
```


### 一维数组的辅助空间

分析见剑指offer书本，以及debug模式。

```java
/**
 * @description: 一维辅助空间
 * @author: rhsphere
 * @since: 2019-07-30 11:43 by jdk 1.8
 */
public class Array_MaxValueOfGifts {
	public int maxValueOfGifts(int[][] values) {
		if (values == null || values.length <= 0 || values[0].length <= 0)
			return 0;
		int rows = values.length;
		int cols = values[0].length;
		int[] maxValue = new int[clos];

		for (int i = 0; i < rows; i++) {
			for (int j = 0; j < cols; j++) {
				int left = 0;
				int up = 0;
				if (i > 0)
					up = maxValue[j];
				if (j > 0)
					left = maxValue[j-1];
				maxValue = Math.max(up, left) + value[i][j];
			}
		}
		return maxValue[cols - 1];
	}
}
```


## 总结

1. 动态规划问题，用公式来表示清楚。

2. 动态规划如果有大量重复计算，可以用循环+辅助空间来提高效率。

3. 这道题不用二维数组，只需要用一维数组作为辅助空间即可，以后遇到对中间结果的保存问题，看看能否优化辅助空间。

<hr />