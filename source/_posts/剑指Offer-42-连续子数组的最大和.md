---
title: 剑指Offer(42) 连续子数组的最大和
tags: [array]
date: 2019-07-29 22:56:30
permalink: greatest-sum-of-subarrays
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 连续子数组的最大和 

本题的动态规划解法，待完成。

### 题目
输入一个整型数组，数组里有正数也有负数。数组中一个或连续的多个整/数组成一个子数组。求所有子数组的和的最大值。要求时间复杂度为O(n)。

### 思路

分析规律，从第一个数字开始累加，若走到某一个数字时，前面的累加和为负数，说明不能继续累加了，要从当前数字重新开始累加。在累加过程中，将每次累加和的最大值记录下来，遍历完成后，返回该数字。


### 测试用例

1. 功能测试（输入数组有正有负，全负数，全正数）

2. 特殊输入测试（null）

## java代码

```java

/**
 * @description:
 * @author: rhsphere
 * @since: 2019-07-29 23:00 by jdk 1.8
 */
public class GreatestSumOFSubArrays {
    boolean isInvalidInput = false;

    public int findGreatestSumOfSubarray(int[] arr) {
        if (arr == null || arr.length <= 0) {
            isInvalidInput = true;
            return 0;
        }
        isInvalidInput = false;

        int sum = arr[0];
        int maxSum = arr[0];

        for (int i = 1; i < arr.length; i++) {
            if (sum < 0) {
                sum = arr[i];
            } else {
                sum += arr[i];
            }
            if (sum > maxSum)
                maxSum = sum;
        }
        return maxSum;
    }
}
```





<hr />