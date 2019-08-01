---
title: 剑指Offer(49) 丑数
tags: []
date: 2019-07-30 22:27:40
permalink: ugly-number
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 丑数 

### 题目
我们把只包含因子2、3和5的数称作丑数（Ugly Number）。求按从小到大的顺序的第1500个丑数。例如6、8都是丑数，但14不是，因为它包含因子7。习惯上我们把1当做第一个丑数。



### 思路

**直观思路**：逐一判断每个整数是否为丑数，效率太低。

**空间换时间的解法**：

　　创建数组存放已经排序好的丑数，这将消耗一定的内存开销。根据丑数的定义，丑数应该是另一个丑数的2、3或者5倍的结果，因此，我们从数组中已有的丑数里找到三个丑数T2、T3、T5，它们分别和2、3、5相乘得到的值恰好比已有的最大丑数大，三个乘积中最小的一个就是下一个丑数，存放入数组中，同时更新T2、T3、T5，使它们仍然保持与2、3、5的乘积恰好比已有的最大丑数大。

### 测试用例
1. 功能测试（2，3，4，5等）

2. 特殊测试（0，1）

3. 性能测试（1500等）


## java代码

### 逐个判断每个整数

```java
/**
 * @description: 暴力法求丑数
 * @author: rhsphere
 * @since: 2019-07-30 22:49 by jdk 1.8
 */
public class BF_UglyNumber {
    public int getUglyNumber(int index) {
        if (index <= 0)
            return 0;
        int number = 1;
        int count = 0;
        while (true) {
            if (isUgly(number))
                count++;
            if (count == index)
                return number;
            number++;
        }
    }

    private boolean isUgly(int number) {
        while (number % 5 == 0)
            number /= 5;
        while (number % 3 == 0)
            number /= 3;
        while (number % 2 == 0)
            number /= 2;
        return number == 1;
    }
}
```

### 创建数组保存已经找到的丑数，用时间换空间的解法

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-07-30 22:30 by jdk 1.8
 */
public class UglyNumber {
    public int getUglyNumber(int index) {
        if (index <= 0)
            return 0;
        int[] uglyNum = new int[index];

        uglyNum[0] = 1;
        int index2 = 0;
        int index3 = 0;
        int index5 = 0;

        for (int i = 1; i < index; i++) {
            uglyNum[i] = getMinimum(uglyNum[index2] * 2,
                    uglyNum[index3] * 3, uglyNum[index5] * 5);
            while(uglyNum[index2] * 2 <= uglyNum[i])
                index2++;
            while(uglyNum[index3] * 3 <= uglyNum[i])
                index3++;
            while(uglyNum[index5] * 5 <= uglyNum[i])
                index5++;
        }
        return uglyNum[index - 1];
    }

    private int getMinimum(int a, int b, int c) {
        return Math.min(Math.min(a, b), c);
    }
}
```


## 总结

1. 判断m是否为n的因子：即判断n能否被m整除，也就是n%m=0。要掌握判断因子的方法。例如判断丑数的程序如下：

```java
private boolean isUgly(int number) {
    while (number % 5 == 0)
        number /= 5;
    while (number % 3 == 0)
        number /= 3;
    while (number % 2 == 0)
        number /= 2;
    return number == 1;
}
```

2. 丑数是另一个丑数的2、3或者5倍，要记住这类特性和规律。特别是在遇到类似的新概念时。


<hr />