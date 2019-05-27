---
title: 41. First Missing Positive
tags: [Array]
date: 2019-05-25 22:05:55
permalink: 41
categories: Hard
description:
---
<p class="description"></p>


<!-- more -->

## 缺失的第一个正数
### 题目
给定一个未排序的整数数组，找出其中没有出现的最小的正整数。

示例 1:

输入: [3,4,-1,1]
输出: 2
示例 3:

输入: [7,8,9,11,12]
输出: 1
说明:

你的算法的时间复杂度应为O(n)，并且只能使用常数级别的空间。

### 思路
**整个的思路就是把nums[i]存储的数放到，下标为nums[i]的位置，处理小于等于0和大于数组长度的nums[i]，交换nums[i]到下标nums[i]是做一下取负值处理，离开的位置i不做处理，把整个数组处理一遍后，遍历数组找到第一个正数所对应的位置，就是第一个缺失的正数。**


1. 和剑指offer中3. 数组中重复中的数字差不多，数组存储的数（长度范围内）放在对应下标的位置，离开的位置保持不变，如果没有人填回来说明这个位置空缺，这是只要遍历一次数组，找到第一个空缺的位置就是第一个缺失的正数。
2. 缺失的位置巧妙的用数组的0、1来辅助，先判断是否有1，如果有1那这个位置就可以拿出来放  数组中存储的不在长度范围内的数，把这些数置为1，
3. 如果说这个数离开现在的位置，到nums[i]的位置（比如数组长度6， i = 3, nums[i] = 4, nums[i]去填到i = 4的位置），把这个数变成负数，所以这种方法，最后统计有多少正数，还能统计在数组范围内缺失多少正数。


### java代码

```java

public class FindMissingPositive {
	public static int findMissingPositive(int[] nums) {
		//1. 判断1是否存在
		int n = nums.length;
		boolean isOneExists = false;

		for (int i : nums) {
			// foreach语句出错，错成nums[i] == 1
			if (i == 1)
				isOneExists = true;
		}
		if (!isOneExists) 
			return 1;
		 // n == 2判断出错
		if (n == 1) 
			return 2;
		//2. 因为上面判断出1存在的（否则程序结束了），所以可以借用数组下标为1的位置，
        // 存放不在数组长度范围内的数（小于0和大于数组长度的），将值设置为1，等下在搬移时
        //会一直搬移到下标为1的位置进行覆盖

		for (int i = 0; i < n; i++) {
			if (nums[i] <= 0 || nums[i] > n)
				nums[i] = 1;
		}

		//3. 把数组长度内的数都给置为负值，
		for (int i = 0; i < n; i++) {
			int v = Math.abs(nums[i]);
			if (v == n) {
			//避免越界，而且0位置不是正数
				nums[0] = -1 * Math.abs(nums[0]);
			} else {
				//由于这个位置v可能会反复访问，所以要加绝对值再取负值
				nums[v] = -1 * Math.abs(nums[v]);
			}
		}
		//4. 从下标为1的位置遍历
		for (int i = 1; i < n; i++) {
			if (nums[i] > 0)
				return i;
		}
		//若执行到此步，上面的for循环，说明n-1的位置都是在的，
		if (nums[0] > 0)
			return n;
		return n + 1;
	}

	public static void main(String[] args) {
		int[] nums = {3,4,-1,1};
        int a = firstMissingPositive(nums);
        System.out.println(a);
	} 
}
```


### 总结
1. O(2n)的意思是遍历两遍！！！
2. 本题思路借鉴了剑指Offer3. 重复的数字，请复习
3. **犯了两个错误**1. // foreach语句出错，错成nums[i] == 1 2. // n == 2判断出错
4. 可以看本题的思路



<hr />