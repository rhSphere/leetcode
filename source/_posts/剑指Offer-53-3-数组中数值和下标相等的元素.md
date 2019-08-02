---
title: 剑指Offer(53-3) 数组中数值和下标相等的元素
tags: [BinarySearch, Array]
date: 2019-08-02 14:30:13
permalink: get-number-same-as-index
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 数组中数值和下标相等的元素 

### 题目
假设一个单调递增的数组里的每个元素都是整数并且是唯一的。请编程实现一个函数找出数组中任意一个数值等于其下标的元素。例如，在数组{-3, -1,1, 3, 5}中，数字3和它的下标相等。


### 思路
　同53-1和53-2一样，不再从头到尾遍历，由于是排序数组，我们继续考虑使用二分查找算法：

　　  1）当中间数字等于其下标时，中间数字即为所求数字；

　　  2）当中间数字大于其下标时，在左半部分区域寻找；

　　  2）当中间数字小于其下标时，在右半部分区域寻找；


### 测试用例
1. 功能测试（包含/不包含与下标相等的数字）

2. 边界值测试（数字位于数组开头、中间或者结尾；仅一个数字数组）

3. 特殊测试（null）

## java代码
```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-02 14:33 by jdk 1.8
 */
public class IntegerIdenticalToIndex {
	public int getNumberSameAsIndex(int[] arr) {
		if (arr == null || arr.length <= 0)
			return -1;
		int low = 0;
		int high = arr.length - 1;
		while (low <= high) {
			int mid = (low + high) / 2;
			if (arr[mid] > mid) {
				high = mid - 1;
			} else if (arr[mid] < mid) {
				low = mid +１;
			} else {
				return mid;
			}
		}
		return -1;
	}
}
```




<hr />