---
title: 剑指Offer(11) 旋转数组中的最小数字
tags: [BinarySearch]
date: 2019-04-16 22:15:13
permalink: min-number-in-rotate-array
categories: 剑指Offer
description:
---
<p class="description">数组在一定程度上是排序的，很容易分析出：可以采用二分法来寻找最小数字。</p>


<!-- more -->

## 查找和排序
在面试时，如果面试官要求实现一个排序算法，那么一定要问清楚这个排序应用的环境是什么、有哪些约束条件。

### 题目
把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。输入一个递增排序的数组的一个旋转，输出旋转数组的最小元素。例如数组 {3, 4, 5, 1, 2} 为 {1, 2, 3, 4, 5} 的一个旋转，该数组的最小值为1。

### 思路
数组在一定程度上是排序的，很容易分析出：可以采用二分法来寻找最小数字。

但是这里面有一些陷阱：

1.递增排序数组的本身是自己的旋转，则最小数字是第一个数字

2.中间数字与首尾数字大小相等，如 {1, 0, 1, 1, 1, 1} 和 {1, 1, 1, 1, 0, 1}，无法采用二分法，只能顺序查找。

### 测试用例

1.功能测试（正常旋转数组，中间有或者无重复数字）

2.边界值测试（升序数组，1个数字的数组）

3.特殊输入测试（null，空数组）

## 完整java代码

```java 旋转数组中的最小数字
public class MinNumberInRotateArray {
	public int minNumberInRotateArray(int[] arr) {
		if (arr == null || arr.length <= 0)
			return 0;
		int low = 0;
		int high = arr.length - 1;
		int mid = low + (high - low) >> 1;

		// 升序数组
		if (arr[low] < arr[high])
			return arr[low];
		// 中间数字与首尾数字相等
		if (arr[mid] == arr[high] && arr[mid] == arr[low]) {
			for (int i = 1; i <= high; i++) {
				if (arr[i] < arr[i - 1])
					return arr[i];
			}
			return arr[low];
		}
		// 正常情况
		while (low < high) {
			if (high - low == 1)
				break;
			mid = (low + high) / 2;
			if (arr[mid] <= arr[high]) {
				high = mid;
			} else {
				low = mid;
			}
		}
		return arr[high];
	}



	public void test1() {
		int[] array = null;
		System.out.println("test1:" + minNumberInRotateArray(array));
	}

	public void test2() {
		int[] array = {};
		System.out.println("test2:" + minNumberInRotateArray(array));
	}

	public void test3() {
		int[] array = { 1 };
		System.out.println("test3:" + minNumberInRotateArray(array));
	}

	public void test4() {
		int[] array = { 1, 2, 3, 4, 5, 6 };
		System.out.println("test4:" + minNumberInRotateArray(array));
	}

	public void test5() {
		int[] array = { 2, 2, 2, 2, 1, 2 };
		System.out.println("test5:" + minNumberInRotateArray(array));
	}

	public void test6() {
		int[] array = { 2, 1, 2, 2, 2, 2 };
		System.out.println("test6:" + minNumberInRotateArray(array));
	}

	public void test7() {
		int[] array = { 6, 6, 8, 9, 10, 1, 2, 2, 3, 3, 4, 5, 6 };
		System.out.println("test7:" + minNumberInRotateArray(array));
	}

	public static void main(String[] args) {
		MinNumberInRotateArray demo = new MinNumberInRotateArray();
		demo.test1();
		demo.test2();
		demo.test3();
		demo.test4();
		demo.test5();
		demo.test6();
		demo.test7();
	}
}
```


## 牛客网优秀代码

```java 牛客网中的FINACK写的代码
public class Solution{
	public int minNuberInRotateArray(int[] arr) {
		int low = 0;
		int high = arr.length - 1;
		while (low < high) {
			int mid = low + (high - low) >> 1;
			if (arr[mid] > arr[high]) {
				low = mid + 1;
			} else if (arr[mid] == arr[high]) {
				high = high - 1;
			} else {
				high = mid;
			}
		}
		return arr[low];
	}
}
```
这段代码的细节：
1.使用low = mid + 1，而不是low = mid，最终会使得low = high（左右指针重合）而跳出循环。
2.使用high = mid，而不是high = mid - 1，因为mid有可能就是最小值点，不能减1。
3.升序数组的情况可以直接在循环中一起搞定，不用单独列出来判断。

不好的地方：
1.1.该程序在array[mid] = array[high]时直接顺序查找。但其实这还有可能可以用二分法的，除非还满足array[mid] = array[low]，才只能使用顺序查找。所以可以先排除掉必须顺序查找的情况（类似自己上面的程序，提前判断掉），之后就可以直接删除else if(array[mid] == array[high]){high = high - 1;这两行了。

2.缺少null的判断。

## 总结
1.题目中给定的特殊条件一定要去关注，往往就是解法的题眼，尤其是接触到一个新的概念时，要能快速理解并考虑全面。
2.要注意一些特例，如递增数组的本身是自己的旋转、相同数字数组。
3.如果数组一定程度上是排序的，可以考虑使用二分法来解题。对于数组的方法（如二分法等），可以用low、high、mid或者left、right、mid来表示左右指针，也即数组下标。

<hr />