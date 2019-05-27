---
title: 442. Find All Duplicates in an Array
tags: [Array]
date: 2019-05-27 09:24:30
permalink: 442
categories: Medium
description:
---
<p class="description"></p>


<!-- more -->

## 数组中重复的数据
### 题目
给定一个整数数组 a，其中1 ≤ a[i] ≤ n （n为数组长度）, 其中有些元素出现两次而其他元素出现一次。

找到所有出现两次的元素。

你可以不用到任何额外空间并在O(n)时间复杂度内解决这个问题吗？

示例：

输入:
[4,3,2,7,8,2,3,1]

输出:
[2,3]

### 思路
1. 元素的值在不超过数组的长度，我们遍历数组，将元素值映射的下标改为负数，当遇到负数时，说明该元素下标映射的值已经出现过了。
2. 和[41. First Missing Positive](https://blogs.rhsphere.com/leetcode/2019/05/25/41.html)中取负值的思路差不多，但是方法略有不同，**所以不要死记硬背！**

### java代码

```java
/**
 * @description: 元素的值在不超过数组的长度，遍历数组将元素映射的下标改成负数，当遇到负数时，说明该元素下标映射的值已经出现过了
 * @author: rhsphere
 * @since: 2019-05-27 09:30 by jdk 1.8
 */
public class FindAllDuplicates { 
	public static List<Integer> findDuplicates(int[] nums) {
		List<Integer> list = new ArrayList<>();

		if (nums.length <= 0)
			return list;

		for (int i = 0; i < nums.length; i++) {
			int v = Math.abs(nums[i]);
			if (nums[v - 1] > 0) {
				nums[v - 1] *= -1;
			} else {
				list.add(Math.nums[i]);
			}
		}
		return list;
	}

	public static void main(String[] args) {
        int[] arr = {4,3,2,7,8,2,3,1};
        List<Integer> list = findDuplicates(arr);
        System.out.println(list);
    }
}
```



<hr />