---
title: 剑指Offer(20) 表示数值的字符串
tags: [String]
date: 2019-06-29 22:36:23
permalink: numberic-strings
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 表示数值的字符串 

### 题目
请实现一个函数用来判断字符串是否表示数值（包括整数和小数）。例如，字符串“+100”、“5e2”、“-123”、“3.1416”及“-1E-16”都表示数值，但“12e”、“1a3.14”、“1.2.3”、“+-5”及“12e+5.4”都不是。


### 思路

具体思路参考剑指offer，需要将数字总结出规律，（A.B E/e A），按顺序进行判断，（A代表有符号整数，B代表无符号整数）

另一种思路：借助几个flag从头到尾遍历，leetcode 65. Valid Number

### 测试用例

1. 功能测试（正负数、含整数与不含整数部分、含小数与不含、含与不含指数部分；不匹配情况）
2. 特殊测试（null、空字符串）

## java代码
```java
public class NumericStrings{
	public boolean isNumeric(char[] str) {
		if (str == null || str.length == 0)
			return false;
		int[] index = new int[1];
		index[0] = 0;
		boolean isNumeric;
		isNumeric = isInteger(str, index);
		if (index[0] < str.lengrh && (str[index[0]] == '.')) {
			index[0]++;
			isNumeric = isUnsignedInteger(str, index) || isNumeric;
		}

		if (index[0] < str.length && (str[index[0]] == 'e' || str[index[0]] == 'E')) {
			index[0]++;
			isNumeric = isInteger(str, index) && isNumeric;
		}
		if (isNumeric && index[0] == str.length)
			return true;
		else
			return false;
	}

	private boolean isInteger(char[] str, int[] index) {
		if (index[0] < str.length && (str[index[0]] == '+' || str[index[0]] == '-'))
			index[0]++;
		return isUnsignedInteger(str, index);
	}
	private boolean isUnsignedInteger(char[] str, int[] index) {
		int start = index[0];
		while (index[0] < str.length && (str[index[0]] - '0' <= 9 && str[index[0]] - '0' >= 0))
			index[0]++;
		if (index[0] > start)
			return true;
		else
			return false;
	}
}
```

## 总结
1. 对字符串进行依次判断时，定义一个boolean变量，每判断一部分就进行更新，最终改变量即为判断结果，不需要进行循环判断。
2. if (isNumeric && index[0] == str.length) 判断index是否到达结尾处了。
3. isNumeric = isUnsignedInteger(str, index) || isNumeric; 顺序不能反了，否则当isNumeric为true时，不会判断后半部分，index就不会走向'e'，从而导致错误。




<hr />