---
title: 344. Reverse String
tags: [String, Two Pointers]
date: 2019-03-08 10:26:37
permalink: 344
categories: Easy
description: 

---
<p class="description"></p>



<!-- more -->

# 反转字符串

LeetCode 334

[英文版](https://leetcode.com/problems/reverse-string/submissions/)

[中文版](https://leetcode-cn.com/problems/reverse-string/submissions/)

## 题目
编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组char[]的形式给出。不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用O(1)的额外空间解决这一问题。

示例 1:

输入: "hello" 输出: "olleh" 示例 2:

输入: "A man, a plan, a canal: Panama" 输出: "amanaP :lanac a ,nalp a ,nam A"


# Java代码

- 头尾两个指针

```java 

/**
 * @description:
 * @author: rhsphere
 * @since: 2019-10-29 10:30 by jdk 1.8
 */
public class ReverseStrings {
    public void reverseString(char[] s) {
        if (s == null || s.length <= 0)
            return;
        reverse(s);
    }

    private void reverse(char[] chars) {
        int start = 0;
        int end = chars.length - 1;
        while (start < end) {
            char tmp = chars[start];
            chars[start] = chars[end];
            chars[end] = tmp;
            start++;
            end--;
        }
    }
}

```


<hr />