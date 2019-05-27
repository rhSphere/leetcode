---
title: 136. Single Number
tags: [Hash Table, Bit Manipulation]
date: 2019-05-27 09:01:56
permalink: 136
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 数组中只出现一次的数
### 题目
给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。

说明：

你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？

示例 1:

输入: [2,2,1]
输出: 1
示例 2:

输入: [4,1,2,1,2]
输出: 4
### java代码 
```java

/**
 * @description: 异或操作最秀的用法了
 * @author: rhsphere
 * @since: 2019-05-27 09:06 by jdk 1.8
 */
public class SingleNumber {
	public static int singleNumber(int[] nums) {
		int ans = 0;
		/*
		for (int i : nums)
			ans ^= i;
		*/
		for (int i = 0; i < nums.length; i++) 
			ans ^= nusm[i];
		return ans;
	}
	 public static void main(String[] args) {
        int[] arr = {4,1,2,1,2};
        int a = singleNumber(arr);
        System.out.println(a);
    }
}
```



### 总结
1. 由于题目原因，用异或太简单了，但是foreach比正常for循环执行速度要慢很多

<hr />