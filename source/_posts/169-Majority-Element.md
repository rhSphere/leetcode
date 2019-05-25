---
title: 169. Majority Element
tags: [Array, Divide and Conquer, Bit Manipulation]
date: 2019-05-25 20:15:22
permalink: 169
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 求众数
###  题目
给定一个大小为 n 的数组，找到其中的众数。众数是指在数组中出现次数大于 ⌊ n/2 ⌋ 的元素。

你可以假设数组是非空的，并且给定的数组总是存在众数。

示例 1:

输入: [3,2,3]
输出: 3
示例 2:

输入: [2,2,1,1,1,2,2]
输出: 2


### java代码
```java
**
 * @description: leetcode上说明, 一定是具有众数存在的，则可以计算出一个初始值 count,从数组的下标1开始，
 * 如果与下一个数组下标的数字不相等，则count-- 当count 为0 就切换为下一个比较的数字
 * @author: rhsphere
 * @since: 2019-05-25 20:19 by jdk 1.8
 */
public class MajorityElement {
	public static int majorityElement(int[] nums) {
		int maj = nums[0];
		int count = 1;
		int i = 1;
		while (i < nums.length) {
			if (nums[i] == maj) count++;
			else {
				count--;
				if (count == 0) {
					maj = nums[i];
					count = 1;
				}
			}
			i++;
		}
		return maj;
	}

	/*另一种写法
	
	public static int majorityElement(int[] nums) {
		int maj = nums[0];
		int count = 1;
		for (int i = 1; i < nums.length; i++) {
			if (nums[i] == maj) {
				count++;
			} else {
				count--;
			}
			if (count == 0) {
				maj = nums[i + 1];
			}
		}
		return maj;
	}
	*/

	public static void main(Sting[] args) {
		int[] test1 = {2, 2, 1, 1, 1, 2, 2};
        int a = majorityElement(test1);
        System.out.println(a);
	}
}
```



### 总结
1. O(n) time and O(n) space

2. O(n) time and O(1) space 使用 major 变量记录众数，count 记录遇到 major +1，非 major -1，最终 count 会大于0，major 即代表众数。


<hr />