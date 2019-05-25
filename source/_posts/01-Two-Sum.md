---
title: 01. Two Sum
tags: [Hash Table, Array]
date: 2019-05-25 16:45:10
permalink: 01
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 两数之和
给定一个整数数组nums和一个目标值target，请你在该数组中找出和为目标值的那两个整数，并返回他们的数组下标。

### Java代码

```java
import java.util.*;

public class TwoSum{
	public int[] twoSum(int[] nums, int target) {
		Map<Integer, Integer> map = new HashMap<>();
		for (int i = 0; i < nums.length; i++) {
			int key = target - nums[i];

			if (map.contains(key))
				return new int[]{map.get(key), i};

			map.put(nums[i], i);
		}
		throw new IllegalArgumentException("No two sum solution");
	}
}
```

<hr />