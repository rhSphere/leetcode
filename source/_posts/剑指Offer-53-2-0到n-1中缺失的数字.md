---
title: 剑指Offer(53-2) 0到n-1中缺失的数字
tags: [BinarySearch, Array]
date: 2019-08-02 11:17:47
permalink: missing-number
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 0 ~ n-1中缺失的数字

### 题目
一个长度为n-1的递增排序数组中的所有数字都是唯一的，并且每个数字都在范围0到n-1之内。在范围0到n-1的n个数字中有且只有一个数字不在该数组中，请找出这个数字。

### 思路

　如果从头到尾依次比较值与小标是否相等，时间复杂度为O(n)，效率低。

　　由于是排序数组，我们继续考虑使用二分查找算法，结合上图可知：

　　　　当中间数字等于其下标时，我们在后半部分查找；

　　　　当中间数字不等于其下标时，

　　　　1）如果中间数字的前一个数字也不等于其下标，则在前半部分查找；

　　　　2）如果中间数字的前一个数字等于其下标，则说明中间数字的下标即为我们所要找的数字。

### 测试用例

1. 功能测试（缺失数字位于数组开头、中间或者结尾）

2. 边界值测试（数字只有0或1）

3. 特殊测试（null）

## java代码
```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-02 11:21 by jdk 1.8
 */
public class MissingNumber {
    public int getMissingNum(int[] arr) {
        if (arr.length <= 0 || arr == null)
            return -1;
        int low = 0;
        int high = arr.length - 1;
        while (low <= high) {
            int mid = (low + high) >> 1;
            if (arr[mid] != mid) {
                if (mid == 0 || arr[mid -1] == mid - 1)
                    return mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return -1;
    }
}
```




<hr />