---
title: 剑指Offer(53-1) 数字在排序数组中出现的次数
tags: [BinarySearch, Array]
date: 2019-08-02 09:20:17
permalink: number-of-k
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 数字在排序数组中出现的次数 

### 题目

统计一个数字在排序数组中出现的次数。例如输入排序数组{1, 2, 3, 3,3, 3, 4, 5}和数字3，由于3在这个数组中出现了4次，因此输出4。

### 思路

[二分查找的一种变型](https://blogs.rhsphere.com/leetcode/2019/04/15/binary-search.html)

分析：对于例子来说，如果采用二分法找到某一个3后，再往前遍历和往后遍历到第一个和最后一个3，在长度为n的数组中有可能出现O(n)个3，因此这样的扫描方法时间复杂度为O(n)，效率与从头到尾扫描一样，速度太慢。

　　这题关键是找到第一个和最后一个3，因此我们尝试改进二分法：中间数字比3大或者小的情况与之前类似，关键是中间数字等于3的情况，这时可以分类讨论如下：

　　1）如果中间数字的前一个数字也等于3，说明第一个3在前面，继续在前半段查找第一个3；

　　2）如果中间数字的前一个数字不等于3，说明该位置是第一个3；

　　3）如果中间数字的后一个数字也等于3，说明最后一个3在后面，继续在后半段查找最后一个3；

　　2）如果中间数字的后一个数字不等于3，说明该位置是最后一个3；


### 测试用例

1. 功能测试（数字出现次数为0、1、2等）

2. 边界值测试（数组只有一个数字，查找数字为第一个或者最后一个）

3. 特殊测试（null）

## java代码 

### 用二分法的变型
非递归写法，可以参考文章[二分查找的一种变型](https://blogs.rhsphere.com/leetcode/2019/04/15/binary-search.html)中查找第一个与key相等的元素、查找最后一个与key相等的元素。

```java
/**
 * @description: 剑指offer53-1（1）
 * @author: rhsphere
 * @since: 2019-08-02 09:51 by jdk 1.8
 */
public class NumberOfK2 {
	public int getNumberOfK(int[] arr, int k) {
		if (arr == null || arr.length <= 0)
			return 0;
		int firstK = getFirstEqual(arr, 0, arr.length-1, k);
		if (first == -1)
			return 0;
		//这个firstK作为getLastEqual参数有点亮
		int lastK = getLastEqual(arr, firstK, arr.length-1, k);
		return lastK - firstK + 1;
	}
	private int getFirstEqual(int[] arr, int left, int right, int key) {
		while (left <= right) {
			int mid = (left + right) / 2;
			if (arr[mid] >= key) {
				right = mid - 1;
			} else {
				left = mid + 1;
			}
		}

		if (left < arr.length && arr[left] == key)
			return left;
		return -1;
	}
	private int getLastEqual(int[] arr, int left, int right, int key) {
		while (left <= right) {
			int mid = (left + right) / 2;
			if (arr[mid] <= key) {
				left = mid + 1;
			} else {
				right = mid - 1;
			}
		}
		if (right >= 0 && arr[right] == key)
			return right;
		return -1;
	}
}
```

### 递归写法
剑指offer上的写法，不够简洁。

```java
/**
 * @description: 剑指offer53-1
 * @author: rhsphere
 * @since: 2019-08-02 09:19 by jdk 1.8
 */
public class NumberOfK {
	public int getNumberOfK(int[] arr, int k) {
		if (arr == null || arr.length <= 0)
			return 0;
		int firstK = getFirstK(arr, 0, arr.length-1, k);
		if (firstK == -1)
			return 0;
		int lastK = getLastK(arr, firstK, arr.length-1, k);
		return lastK - firstK + 1;
	}

	private int getFirstK(int[] arr, int left, int right, int k) {
		if (left > right)
			return -1;
		int mid = left + ((right - left) >> 1);
		if (arr[mid] == k) {
			if (mid == 0 || arr[mid-1] != k)
				return mid;
			else
				right = mid - 1;
		} else if (arr[mid] < k) {
			left = mid + 1;
		} else {
			right = mid - 1;
		}
		return getFirstK(arr, left, right, k);
	}
	private int getLastK(int[] arr, int left, int right, int k) {
		if (left > right)
			return -1;
		int mid = (left + right) / 2;
		if (arr[mid] == k) {
			if (mid == arr.length - 1 || arr[mid+1] != k)
				return mid;
			else
				left = mid + 1;
		} else if (arr[mid] < k) {
			left = mid + 1;
		} else {
			right = mid - 1;
		}
		return getLastK(arr, left, right, k);
	}
}
```


<hr />