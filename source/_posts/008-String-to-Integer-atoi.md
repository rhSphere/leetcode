---
title: 008. String to Integer(atoi)
tags: [String]
date: 2019-10-29 11:38:46
permalink: string-to-integer
categories: 008
description:
---
<p class="description"></p>


<!-- more -->

# 字符串转换整数 (atoi)

LeetCode 8

[英文版](https://leetcode.com/problems/string-to-integer-atoi/submissions/)

[中文版](https://leetcode-cn.com/problems/string-to-integer-atoi/submissions/)

## 题目

请你来实现一个 atoi 函数，使其能将字符串转换成整数。

首先，该函数会根据需要丢弃无用的开头空格字符，直到寻找到第一个非空格的字符为止。

当我们寻找到的第一个非空字符为正或者负号时，则将该符号与之后面尽可能多的连续数字组合起来，作为该整数的正负号；假如第一个非空字符是数字，则直接将其与之后连续的数字字符组合起来，形成整数。

该字符串除了有效的整数部分之后也可能会存在多余的字符，这些字符可以被忽略，它们对于函数不应该造成影响。

注意：假如该字符串中的第一个非空格字符不是一个有效整数字符、字符串为空或字符串仅包含空白字符时，则你的函数不需要进行转换。

在任何情况下，若函数不能进行有效的转换时，请返回 0。

说明：

假设我们的环境只能存储 32 位大小的有符号整数，那么其数值范围为 [−231, 231 − 1]。如果数值超过这个范围，请返回 INT_MAX (2^31 − 1) 或 INT_MIN (−2^31) 。

示例 1:

输入: "42"
输出: 42
示例 2:

输入: "   -42"
输出: -42
解释: 第一个非空白字符为 '-', 它是一个负号。
     我们尽可能将负号与后面所有连续出现的数字组合起来，最后得到 -42 。
示例 3:

输入: "4193 with words"
输出: 4193
解释: 转换截止于数字 '3' ，因为它的下一个字符不为数字。
示例 4:

输入: "words and 987"
输出: 0
解释: 第一个非空字符是 'w', 但它不是数字或正、负号。
     因此无法执行有效的转换。
示例 5:

输入: "-91283472332"
输出: -2147483648
解释: 数字 "-91283472332" 超过 32 位有符号整数范围。
     因此返回 INT_MIN (−231) 。



# Java代码

```java
package algo09.string.leetcode_008;

/**
 * @description:
 * @author: rhsphere
 * @since: 2019-10-29 10:52 by jdk 1.8
 */
public class MyAtoi {
    public static int myAtoi(String str) {
        if (str == null || str.length() <= 0)
            return 0;

        String tmp = str.trim();
        if (tmp == "" || tmp.length() == 0)
            return 0;

        boolean isPos = true;
        char[] chars = tmp.toCharArray();

        int i = 0;
        int res = 0;
        int num = 0;
        if (chars[0] == '-')
            isPos = false;

        if (chars[0] == '+' || chars[0] == '-')
            i++;

        while (i < chars.length) {  //这样写 很容易忘掉 i++ 所以建议写成 for循环
            if (chars[i] >= '0' && chars[i] <= '9') {
                num = chars[i] - '0';
            } else {
                break;
            }

            if (res > Integer.MAX_VALUE/10 || (res == Integer.MAX_VALUE/10 && num > 7)) {
                return isPos ? Integer.MAX_VALUE : Integer.MIN_VALUE;
            }
            res = res * 10 + num;
            i++; //这里的条件一定要加上
        }
        return isPos ? res : -res;
    }


    public static void main(String[] args) {
        String string = " -91283472 like you";
        System.out.println(myAtoi(string));
    }
}

```


# 总结
1. 很容易忘记 i++的条件，所以这种while 循环 也建议写成for循环

```java
   for (; i < chars.length; i++) {
        if (chars[i] >= '0' && chars[i] <= '9') {
            digit = chars[i] - '0';
        } else {
            break;
        }
        
        if (res > Integer.MAX_VALUE/10 || (res == Integer.MAX_VALUE/10 && digit > 7)) {
            return isPos ? Integer.MAX_VALUE : Integer.MIN_VALUE;
        }            
        res = res*10 + digit;                
   }

```



<hr />