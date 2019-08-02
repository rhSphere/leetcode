---
title: 剑指Offer(56) 数组中数字出现的次数
tags: [Array]
date: 2019-08-02 20:40:53
permalink: number-appear-once
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

# 数组中数字出现的次数

题目一：数组中只出现一次的两个数字 

## 题目一
一个整型数组里除了两个数字之外，其他的数字都出现了两次。请写程序找出这两个只出现一次的数字。要求时间复杂度是O(n)，空间复杂度是O(1)。

### 思路

　记住：两个相同的数字异或等于0.

　　如果数组中只有一个数字只出现一次，我们从头到尾异或每个数字，那么最终的结果刚好是那个只出现一次的数字。

　　而本题里数组中有两个数字只出现一次，如果能够将数组分为两部分，两部分中都只有一个数字只出现一次，那么就可以解决该问题了。

　　求解方法：

　　我们依旧从头到尾异或每个数字，那么最终的结果就是这两个只出现一次的数字的异或结果，由于两个数不同，因此这个结果数字中一定有一位为1，把结果中第一个1的位置记为第n位。因为是两个只出现一次的数字的异或结果，所以这两个数字在第n位上的数字一定是1和0。

　　 接下来我们根据数组中每个数字的第n位上的数字是否为1来进行分组，恰好能将数组分为两个都只有一个数字只出现一次的数组，对两个数组从头到尾异或，就可以得到这两个数了。


### 测试用例
1. 功能测试（数组中有多对重复的数字；无重复的数字）


## java代码
```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-02 20:55 by jdk 1.8
 */
public class NumbersAppearOnce {
    public void findNumsAppearOnce(int[] arr, int[] num1, int[] num2) {
        if (arr == null || arr.length <= 0)
            return;

        int res = 0;
        for (int i = 0; i < arr.length; i++)
        	res ^= arr[i];

        int indexOf1 = 0;
        while (((res & 1) == 0) && (indexOf1 <= 32)) {
        	res = res >> 1;
        	indexOf1++;
        }

        num1[0] = 0;
        num2[0] = 2;

        for (int i = 0; i < arr.length; i++) {
        	if (((arr[i] >> indexOf1) & 1) == 1)
        		num1[0] ^= arr[i];
        	else 
        		num2[0] ^= arr[i];
        }
    }
}
```

## 总结
1. 当一个数字出现两次（或者偶数次）时，用异或^ 可以进行消除。一定要牢记 异或的这个功能！

2. 将一组数字分为两组，可以根据某位上是否为1来进行分组，即根据和1相与（&1）的结果来进行分组。

3. 判断某个数x的第n位（如第3位）上是否为1，

　　　　1）通过 x&00000100 的结果是否为0 来判断。（不能根据是否等于1来判断）

　　　　2）通过（x>>3)&1 是否为0 来判断

4. 将某个数x右移m位，一定要写成 x=x>>m；而不能只写成 x>>m；这个语句


# 数组中唯一只出现一次的数字

## 题目二
在一个数组中除了一个数字只出现一次之外，其他数字都出现了三次。请找出那个只出现一次的数字。

### 思路

　这道题中数字出现了三次，无法像56-1) 数组中只出现一次的两个数字一样通过利用异或位运算进行消除相同个数字。但是仍然可以沿用位运算的思路。

　　将所有数字的二进制表示的对应位都加起来，如果某一位能被三整除，那么只出现一次的数字在该位为0；反之，为1。

### 测试用例
1. 功能测试（唯一出现的数字是0，正数，负数；重复出现的数字是0，正数，负数）

## java代码
```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-02 21:51 by jdk 1.8
 */
public class NumberAppear {
	public static int findNumsAppearOnce(int[] arr) {
		if (arr == null || arr.length <= 0)
			throw new RuntimeException();
		int[] bitSum = new int[32];

		for (int i = 0; i < 32; i++)
			bitSum[i] = 0;

		for (int i = 0; i < arr.length; i++) {
			int bitMask = 1;
			for (int j = 31; j >= 0; j--) {
				int bit = arr[i] & bitMask;
				for (bit != 0)
					bitSum[i] += 1;
				bitMask = bitMask << 1;
			}
		}
		int res = 0;
		for (int i = 0; i < 32; i++) {
			res = res << 1;
			res += (bitSum[i] % 3);
		}
		return res;
	}
}
```

## 总结
1. 判断某个数x的第n位（如第3位）上是否为1，

　　　　1）通过 x&00000100 的结果是否为0 来判断。（不能根据是否等于1来判断）

　　　　2）通过（x>>3)&1 是否为0 来判断

2. 通过number&bitMask的结果是否为0（不能用1判断），bitMask=1不断左移，可以将一个数的二进制存储到32位的数组中。

```java
int number = 100;
int bitMask = 1;
for(int j = 31; j >= 0; j--) {
    int bit = number & bitMask;  //注意arr[i]&bitMask不一定等于1或者0，有可能等于00010000
    if(bit != 0)
        bits[j] =1;
    bitMask = bitMask << 1;
}
```

3. 通过以下代码实现二进制转化为数字（注意左移语句的位置）：

```java
int result = 0;
for(int i = 0;i < 32; i++) {
    result = result << 1;
    result += bits[i];
    //result=result<<1;  //不能放在后面，否则最前面一位就没了
}
```

<hr />