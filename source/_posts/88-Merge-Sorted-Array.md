---
title: 88. Merge Sorted Array
tags: [Array, Two Pointers]
date: 2019-05-25 21:28:29
permalink: 88
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 合并两个有序数组
### 题目

给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，使得 num1 成为一个有序数组。

说明:

初始化 nums1 和 nums2 的元素数量分别为 m 和 n。
你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。
示例:

输入:
nums1 = [1,2,3,0,0,0], m = 3
nums2 = [2,5,6],       n = 3

输出: [1,2,2,3,5,6]

### java实现
```java
/**
 * @description: 合并两个有序数组，考虑在归并排序中的merge函数，需要额外的空间，
 *本题目中，限制了数组的长度
 * @author: rhsphere
 * @since: 2019-05-25 21:30 by jdk 1.8
 */
public class MergeSorted {
	public static void merge(int[] nums1, int m, int[] nums2, int n) {
		int index = n + m - 1;
		m--;
		n--;
		while (m >= 0 || n >= 0) {
			if (n == -1) {
				return;
			} else if (m < 0) {
				nums1[index--] = nums2[n--];
			} else if (nums1[m] > nums1[n]) {
				nums1[index--] = nums1[m--];
			} else {
				nums1[index--] = nums2[n--];
			}
		}
	}

	public static void main(String[] args) {
        int[] nums1 = {1,2,7,0,0,0};
        int[] nums2 = {4,5,6};
        int m = 3, n = 3;

        merge(nums1, m, nums2, n);
        System.out.println(Arrays.toString(nums1));
    }
}

```

### 总结
1. 善用断点调试，看清流程怎么走的
2. 合并两个有序数组，虽然没有额外的控件，但是nums1数组的长度题目中是大于等于 m+n的，和归并排序中的merge函数是完全不一样的，归并排序中用了O(n)的空间，来存储合并后的数组
3. 对于 i-- 的合理利用


<hr />