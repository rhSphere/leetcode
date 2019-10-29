---
title: 151. Reverse Words in a String
tags: [String]
date: 2019-10-29 00:33:27
permalink: 151
categories: Medium
description:
---
<p class="description"></p>


<!-- more -->

## 翻转字符串里的单词

LeetCode 151

[英文版](https://leetcode.com/problems/reverse-words-in-a-string/submissions/)

[中文](https://leetcode-cn.com/problems/reverse-words-in-a-string/submissions/)

## 题目
给定一个字符串，逐个翻转字符串中的每个单词。

示例:

输入: "the sky is blue",
输出: "blue is sky the".
说明:

无空格字符构成一个单词。 输入字符串可以在前面或者后面包含多余的空格，但是反转后的字符不能包括。 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。 进阶: 请选用C语言的用户尝试使用 O(1) 空间复杂度的原地解法。

## Java代码

```java
package algo09.string.leetcode_151;

/**
 * @description: 翻转字符串，这里需要三步，
 *第一步把整个句子翻转，第二步把每个单词翻转，第三步删除多余的空格
 * @author: rhsphere
 * @since: 2019-10-28 23:54 by jdk 1.8
 */
public class ReverseWords {
    public String reverseWords(String s) {
        if (s == null || s.length() <= 0)
            return s;
        char[] chars = s.toCharArray();
        //第一步把整个句子翻转
        reverse(chars, 0, chars.length - 1);

        int start = 0;
        int end = 0;
        // 第二步把每个单词翻转
        while (start < chars.length) {
            while (end < chars.length && chars[end] != ' ')
                end++;
            reverse(chars, start, end - 1);  //这里是end-1
            start = ++end;
        }
        // 第三步删除多余的空格
        return cleanSpace(chars);
    }

    private void reverse(char[] chars, int start, int end) {
        while (start < end) {
            char tmp = chars[start];
            chars[start] = chars[end];
            chars[end] = tmp;
            start++;
            end--;
        }
    }

    private String cleanSpace(char[] chars) {
        int i = 0;
        int j = 0;

        while (j < chars.length) {
            while (j < chars.length && chars[j] == ' ')
                j++;
            while (j < chars.length && chars[j] != ' ')
                chars[i++] = chars[j++];
            while (j < chars.length && chars[j] == ' ')
                j++;
            if (j < chars.length)
                chars[i++] = ' ';
        }
        return new String(chars).substring(0, i);  //不是 subString
    }
}

```




<hr />