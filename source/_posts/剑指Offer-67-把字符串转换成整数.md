---
title: 剑指Offer(67) 把字符串转换成整数
tags: [String]
date: 2019-10-29 12:24:57
permalink: string-to-int-atoi
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 把字符串转换成整数
　请你写一个函数StrToInt，实现把字符串转换成整数这个功能。当然，不能使用atoi或者其他类似的库函数。


参考leetcode 008

## Java 代码

```java

/**
 * @description: 参考leetcode008，这里放上牛客网的代码
 * @author: rhsphere
 * @since: 2019-10-29 12:15 by jdk 1.8
 */
public class StringToInteger {

    public int strToInt(String str) {
        if (str == null || str.length() <= 0)
            return 0;
        String tmp = str.trim();

        if (tmp == "" || tmp.length() <= 0)
            return 0;

        char[] chars = tmp.toCharArray();
        int i = 0;
        int res = 0;
        int digit;
        boolean isPos = true;

        if (chars[i] == '-')
            isPos = false;

        if (chars[i] == '-' || chars[i] == '+')
            i++;

        for (; i < chars.length; i++) {  //这里的i++，如果用while循环容易遗漏
            if (chars[i] >= '0' && chars[i] <= '9') {
                digit = chars[i] - '0';
            } else {
                return 0;
            }
            //超过最大值，和leetcode008对比
            if (res > Integer.MAX_VALUE/10 || (res == Integer.MAX_VALUE/10 && digit > 7)) {
                if (!isPos && digit == 8) {  //但如果是负数最大值，返回
                    return Integer.MIN_VALUE;
                } else {  //正数最大值返回0
                    return 0;
                }
            }
            res = res * 10 + digit;
        }
        return isPos ? res : -res;
    }
}

```


## 总结
1. 记住int类型最大正整数为0x7FFFFFFF，最小负整数为0x80000000。

<hr />