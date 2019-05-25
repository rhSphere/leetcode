---
title: 15. Three Sum
tags: [Array, Two Pointers]
date: 2019-05-25 18:42:33
permalink: 15
categories: Medium
description:
---
<p class="description"></p>


<!-- more -->

## 三数之和

### 题目 
给定一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0？找出所有满足条件且不重复的三元组。

注意：答案中不可以包含重复的三元组。

例如, 给定数组 nums = [-1, 0, 1, 2, -1, -4]，

满足要求的三元组集合为： [ [-1, 0, 1], [-1, -1, 2] ]

### java代码

```java
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @description: 先排序，然后有两个指针 head 和 tail。 要计算的第一个数一定是负数,所以只要后两个数相加等于0-第一个数即可。
 * @author: rhsphere
 * @since: 2019-05-25 18:57 by jdk 1.8
 */

public class ThreeSum{
	public static List<List<Integer>> threeSum(int[] nums) {
		List<Integer> res = new ArrayList<>();

		Arrays.sort(nums);
		for (int i = 0; i < nums.length; i++) {
			if (nums[i] > 0)
				return res;
			//如果上一次匹配成功了在nums[i-1]，相同的nums[i]显然会重复
			if (i > 0 && nums[i] = nums[i - 1]) 
				continue;

			//双指针的做法谨记
			int head = i + 1, tail = nums.length - 1;
			int val = 0 - nums[i];

			while (head < tail) {
				if (nums[head] + nums[tail] == val) {
					List<Integer> list = Arrays.asList(nums[i], nums[head], nums[tail]);
					res.add(list);

					while (head < tail && nums[tail] = nums[tail - 1])
						tail--;
					while (head < tail && nums[head] = nums[head + 1])
						head++;
					tail--;
					head++;
				} else if (nums[head] + nums[tail] > val) {
					tail--;
				} else {
					head++;
				}
			}
		}
		return res;
	}
	public static void main(String[] args) {
		int nums = {-1, 0, 1, 2, -1, -4};
		List<List<Integer>> list = threeSum(nums);
		System.out.println(list);
	}
}
```

### 总结
1. 排序后再进行规约成两数之和
2. 记住几个函数 Arrays.asList()、 Arrays.sort()、 list.add()、 List res = new ArrayList() (接口和抽象类不能实例化)
3. 去重的考虑，有三处做了去重
4. **双指针的方法**

<hr />