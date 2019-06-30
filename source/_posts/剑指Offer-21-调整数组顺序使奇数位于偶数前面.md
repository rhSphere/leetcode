---
title: 剑指Offer(21) 调整数组顺序使奇数位于偶数前面
tags: [Two Pointers, Array]
date: 2019-06-30 09:34:57
permalink: reorder-array
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 调整数组顺序使奇数位于偶数前面

### 题目
输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有奇数位于数组的前半部分，所有偶数位于数组的后半部分。

### 思路
对于任意一个整数数组，设置一个left指针，从前往后走，如果遇到奇数则指针后移，遇到偶数时，指针停止；设置一个right指针，从前往后走，遇到偶数时指针前移，遇到奇数是，可以喝前面的指针所指的偶数进行调换。


### 测试用例
1. 功能测试（数组中奇偶交替出现、数组中先奇后偶、先偶后奇）
2. 特殊测试（null、空数组、一个数据的数组）


## java代码
```java
public class ReorderArray {
	public void reorderArray(int[] arr) {
		if (arr == null || arr.length <= 0)
			return;
		int left = 0;
		int right = arr.length - 1;
		int tmp;
		while (left < right) {
			while (left < right && (arr[left] & 1) != 0)
				left++;
			while (left < right && (arr[right] & 1) == 0)
				right--;
			tmp = arr[left];
			arr[left] = arr[right];
			arr[right] = tmp;
		}
	}
}
```


## 附加要求

如果题目附加要求：保证调整后的数组中，奇数和奇数之间，偶数和偶数之间的相对位置不变。
此时用上面的方法无法实现该功能，可以采用类似于“直接插入排序”的方法：从头开始遍历，遇到奇数时，将该奇数插入到该奇数前面的偶数之前。（如：从头开始遍历246183，遇到奇数1时，将1插入到246之前，变为：124683；该插入的实质是：奇数前面的所有偶数往后移一位，空出的位置放入该奇数）

### java代码
```java
public void reorderArray1(int[] arr) {
	if (arr == null || arr.length <= 0)
		return;

	int tmp, j;
	for (int i = 1; i < arr.length; i++) {
		if ((arr[i] & 1) != 0) {
			j = i;
			tmp = arr[i];
			while ((j > 0) && (arr[j - 1] & 1) == 0) {
				arr[j] = arr[j - 1];
				j--;
			}
			arr[j] = tmp;
		}
	}
}

```


<hr />