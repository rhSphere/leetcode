---
title: 215. Kth Largest Element in an Array
tags: [Heap, Divide and Conquer, Quick Sort]
date: 2019-05-27 08:49:21
permalink: 215
categories: Medium
description:
---
<p class="description"></p>


<!-- more -->

## 数组中的第K个最大元素
### 题目

在未排序的数组中找到第 k 个最大的元素。请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。

示例 1:

输入: [3,2,1,5,6,4] 和 k = 2
输出: 5
示例 2:

输入: [3,2,3,1,2,4,5,5,6] 和 k = 4
输出: 4
说明:

你可以假设 k 总是有效的，且 1 ≤ k ≤ 数组的长度。


### java代码
```java
/**
 * @description: 用快排的思想，partition函数
 * @author: rhsphere
 * @since: 2019-05-26 10:49 by jdk 1.8
 */
public class KthLarget {
	public static int findKthLargest(int[] nums, int k) {
		int start = 0;
		int end = nums.length - 1;
		int index = nums.length - 1;

		while (start < end) {
			int pivotIndex = partition(nums, start, end);

			if (pivotIndex < index) {
				start = pivotIndex + 1;
			} else if (pivotIndex > index) {
				end = startIndex - 1;
			} else {
				return nums[pivotIndex];
			}
		}
		return nums[start];
	}

	private static int partition(int[] nums, int start, int end) {
		int pivot = nums[start];
		int mark = start;

		for (int i = start + 1; i <= end; i++) {
			if (nums[i] < pivot) {
				mark++;
				int tmp = nums[i];
				nums[i] = nums[mark];
				nums[mark] = tmp;
			}
		}
		nums[start] = nums[mark];
		nums[mark] = pivot;
		return mark;
	}
	public static void main(String[] args) {
        int[] arr = {3,2,1,5,6,4};
        int a = findKthLargest(arr, 2);
        System.out.println(a);
    }

}

```

### 总结

1. 应用了快排中partition的函数，参看[partition函数的单边循环法](https://blogs.rhsphere.com/leetcode/2019/04/01/quick-sort.html)
2. 这种方法在提交时，运行时间效果不是很好，不知道有什么可以改进的地方吗?
3. partition单边循环时，可以用一个数组（4 7 6 5 3 2 8 1）演示一下就知道怎么写了



<hr />