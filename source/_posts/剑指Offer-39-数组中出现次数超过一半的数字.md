---
title: 剑指Offer(39) 数组中出现次数超过一半的数字
tags: [Array]
date: 2019-07-28 19:33:07
permalink: more-than-hanlf-number
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 数组中出现次数超过一半的数字 

### 题目
  数组中有一个数字出现的次数超过数组长度的一半，请找出这个数字。例如输入一个长度为9的数组{1, 2, 3, 2, 2, 2, 5, 4, 2}。由于数字2在数组中出现了5次，超过数组长度的一半，因此输出2。

### 思路

思路一：数字次数超过一半，则说明：排序之后数组中间的数字一定就是所求的数字。

　　利用partition()函数获得某一随机数字，其余数字按大小排在该数字的左右。若该数字下标刚好为n/2，则该数字即为所求数字；若小于n/2，则在右边部分继续查找；反之，左边部分查找。

　　思路二：数字次数超过一半，则说明：该数字出现的次数比其他数字之和还多

　　遍历数组过程中保存两个值：一个是数组中某一数字，另一个是次数。遍历到下一个数字时，若与保存数字相同，则次数加1，反之减1。若次数=0，则保存下一个数字，次数重新设置为1。由于要找的数字出现的次数比其他数字之和还多，那么要找的数字肯定是最后一次把次数设置为1的数字。

　　也可以这样理解（来源：牛客网 cm问前程）：

　　采用阵地攻守的思想：
　　第一个数字作为第一个士兵，守阵地；count = 1；
　　遇到相同元素，count++;
　　遇到不相同元素，即为敌人，同归于尽,count--；当遇到count为0的情况，又以新的i值作为守阵地的士兵，继续下去，到最后还留在阵地上的士兵，有可能是主元素。
　　再加一次循环，记录这个士兵的个数看是否大于数组一般即可。

### 测试用例

1. 功能测试（存在或者不存在超过数组长度一半的数字）

2. 特殊测试（null、1个数字）


## java代码

```java
/**
 * @description: 剑指offer39
 * @author: rhsphere
 * @since: 2019-07-28 20:21 by jdk 1.8
 */
public class MoreThanHalfNumber {
    boolean isInputInvalid = true;

    //方法一：partition方法
    public int moreThanHalfNum(int[] arr) {
        if (arr == null || arr.length <= 0)
            return 0;
        int low = 0;
        int high = arr.length - 1;
        int index = partition(arr, low, high);
        while (index != arr.length >> 1) {
            if (index < arr.length >> 1) {
                low = index + 1;
                index = partition(arr, low, high);
            } else {
                high = index - 1;
                index = partition(arr, low, high);
            }
        }
        //判断次数是否超过一半
        int num = arr[index];
        int times = 0;
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == num) {
                times++;
            }
        }
        if (times * 2 > arr.length) {
            isInputInvalid = false;
            return num;
        }
        return 0;
    }

    //partition简洁的的单边循环法
    private int partition(int[] arr, int low, int high) {
        int pivot = arr[low];
        int mark = low;
        for (int i = low + 1; i <= high; i++) {
            if (arr[i] < pivot) {
                mark++;
                int tmp = arr[mark];
                arr[mark] = arr[i];
                arr[i] = tmp;
            }
        }
        arr[low] = arr[mark];
        arr[mark] = pivot;
        return mark;
    }

    //方法二

    public int moreThanHalfNum(int[] arr) {
        if (arr == null || arr.length <= 0)
            return 0;

        int num = arr[0];
        int count = 1;
        for (int i = 1; i < arr.length - 1; i++) {
            if (count == 0) {
                num = arr[i];
                count++;
            } else if (arr[i] == num) {
                count++;
            } else {
                count--;
            }
        }
        if (count > 0) {
            int times = 0;
            for (int i = 0; i < arr.length; i++) {
                if (arr[i] == num) {
                    times++;
                }
            }
            if (times * 2 > arr.length) {
                isInputInvalid = false;
                return num;
            }
        }
        return 0;
    }
}
```


## 总结
1. length/2 用 length>>1 来代替，具有更高的效率

2. 本题中，找到了所求数字，别忘记判断该数字的次数是否超过一半，感觉很容易忘记进行判断。

3. 题目所要求的返回值为int，所以如果数组不满足要求时，无法通过返回值来告知是否出错，所以这道题设置了一个全局变量来进行判断。调用该方法时，需要记得对全局变量进行检查。

4. 方法一中，采用了partition()函数，该函数会改变修改的数组，因此在面试的时候，需要和面试官讨论是否可以修改数组。

5. 两种方法的时间复杂度均为O(n)。



<hr />