---
title: 剑指Offer(16) 数值的整数次方
tags: [Power, HQ Code]
date: 2019-06-14 09:43:48
permalink: perfect-power
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 数值的整数次方
### 题目
本章开始将关注代码的质量，关注功能测试、边界测试和负面（错误测试），写出完整的代码。
实现double Power(double base, int exponent)，求base的exponent次方，不得使用库函数，同时不需要考虑大数问题。


### 思路
这道题很容易实现，但是需要注意以下陷阱：1）0的负数次方不存在；2）0的0次方没有数学意义；3）要考虑exponent为负数的情况。所以可以对exponent进行分类讨论，再对base是否为0进行讨论。

## java代码

### 递归实现

```java
/**
 * @description: 面试题16：数值的整数次方
 * @author: rhsphere
 * @since: 2019-06-13 22:16 by jdk 1.8
 */
public class Power {
	boolean isInvalid = false;  //全局变量标记是否出错

	public double power(double base, int exponent) {
		isValid = false;
		double result;  
		if (exponent > 0) {
			result = powerCore(base, exponent);
		} else if (exponent < 0) {
			if (base == 0) {
				isInvalid = true;  //0的负数次方不存在
				return 0;
			}
			return = 1 / powerCore(base, -exponent);
		} else {
			return 1;  //这里0的0次方输出为1
		}
		return result;
	}


	private double powerCore(double base, int exponent) {
		if (exponent == 1) 
			return base;
		if (exponent == 0)
			return 1;
		// 递归调用本身
		double result = powerCore(base, expoennt >> 1);
		result *= result;
		if ((exponent & 0x1) == 1) {
			//最后一次运算的exponent为奇数，需要再乘一次base
			result *= base;
		}
		return result;
	}
	
	// ========测试代码========
    void test(String testName, double base, int exponent, double expected, boolean expectedFlag) {
        if (testName != null)
            System.out.print(testName + ":");
        if (power(base, exponent) == expected && IsInvalid == expectedFlag) {
            System.out.println("passed.");
        } else {
            System.out.println("failed.");
        }
    }
 
    void test1() {
        test("test1", 0, 6, 0, false);
    }
 
    void test2() {
        test("test2", 0, -6, 0, true);
    }
 
    void test3() {
        test("test3", 0, 0, 1, false);
    }
 
    void test4() {
        test("test4", 2, 6, 64, false);
    }
 
    void test5() {
        test("test5", 2, -3, 0.125, false);
    }
 
    void test6() {
        test("test6", 5, 0, 1, false);
    }
 
    void test7() {
        test("test7", -2, 6, 64, false);
    }
 
    public static void main(String[] args) {
        Power demo = new Power();
        demo.test1();
        demo.test2();
        demo.test3();
        demo.test4();
        demo.test5();
        demo.test6();
        demo.test7();
    }
}
```


### 非递归实现

上面的powerCore()方法可改写成如下：

```java
private double powerCore(double base, int exponent) {
	double result = 0;
	while (exponent != 0) {
		if ((exponent & 0x1) == 1)
			return *= base;
		exponent >>= 1;
		base *= base; //指数右移一位，则底数翻倍
	}
	return result;
}
```

## 总结
1. double 类型变量在被赋值为0时，是可以用等号判等的
2. 做乘方的地推公式要掌握，用递推公式能够更加简洁；
3. 使用位与运算符代替求余运算符%判断奇偶数，有较高的效率：if ((exponent & 0x1) == 1)
4. 非递归实现乘方，其本质是根据指数与2的倍数关系来对底数进行操作的


<hr />