---
title: 剑指Offer(51) 数组中逆序对
tags: [Array]
date: 2019-08-01 20:05:59
permalink: inverse-pairs
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 数组中的逆序对 

### 题目
在数组中的两个数字如果前面一个数字大于后面的数字，则这两个数字组成一个逆序对。输入一个数组，求出这个数组中的逆序对的总数。

### 思路
如果遍历数组，对每个数字都和后面的数字比较大小，时间复杂度为O(n^2)，效率太低。

　　利用归并排序的思想，先将数组分解成为n个长度为1的子数组，然后进行两两合并同时排好顺序。

　　在对两个子区域合并排序时，记左边区域（下标为start~mid）的指针为i，右边区域（下标为mid+1~end）的指针为j，两个指针都指向该区域内最大的数字，排序时：

　　（1）如果i指向的数字大于j指向的数字，说明：逆序对有j-mid个，我们把i指向的数字放入临时创建的排序数组中，然后令i-1，指向该区域前一个数字，继续进行排序；

　　（2）如果i指向的数字小于等于j指向的数字，说明暂时不存在逆序对，将j指向的数字放入临时创建的排序数组中，然后令j-1，指向该区域前一个数字，继续进行排序；

　　（3）某一子区域数字都放入排序数组后，将另一个子区域剩下的数字放入排序数组中，完成排序；

　　（4）最后将排序好的数字按顺序赋值给原始数组的两个子区域，以便合并后的区域与别的区域合并。

### 测试用例

1. 功能测试（普通数组，递增数组，递减数组，含重复数字）

2. 边界值测试（数组只有两个数字，只有一个数字）

3. 特殊测试（null）


## java代码

```java
/**
 * @description: 剑指offer51
 * @author: rhsphere
 * @since: 2019-08-01 20:05 by jdk 1.8
 */
public class InversePairs {
	public static int inversePairs(int[] arr) {
		if (arr == null || arr.length <= 0)
			return 0;
		int count = getCount(arr, 0, arr.length - 1);
		return count;
	}

	private static int getCount(int[] arr, int start, int end) {
		if (start >= end)
			return 0; 

		int mid = start + ((end - start) >> 1);
		int left = getCount(arr, start, mid);
		int right = getCount(arr, mid+1, end);

		//合并
		int count = 0;
		int i = mid;	//左边区域的指针
		int j = end;	//右边区域的指针
		int[] tmp = new int[end - start + 1];	//临时区域
		int k = end - start;	//临时区域的指针

		while (i >= start && j >= mid + 1) {
			if (arr[i] > arr[j]) {
				count += (j - mid);
				tmp[k--] = arr[i--];
			} else {
				tmp[k--] = arr[j--];
			}
		}

		//下面两句while 不要忘记里面的等号
		while (i >= start)
			tmp[k--] = arr[i--];
		while (j >= mid + 1)
			tmp[k--] = arr[j--];

		// k + start 不是很理解
		for (k = 0; k < tmp.length; k++)
			arr[k + start] = tmp[k];

		return count + left + right;
	}
}

```


## 总结

1. 归并排序的变形，递归的熟练使用。

<hr />