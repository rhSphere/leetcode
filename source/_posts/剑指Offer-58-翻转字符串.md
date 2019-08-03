---
title: 剑指Offer(58) 翻转字符串
tags: [String, Two Pointers]
date: 2019-08-03 10:59:02
permalink: reverse-words
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

# 翻转单词顺序

## 题目一
输入一个英文句子，翻转句子中单词的顺序，但单词内字符的顺序不变。为简单起见，标点符号和普通字母一样处理。例如输入字符串"I am a student. "，则输出"student. a am I"。


### 思路 
一开始自己觉得要用split()方法，但这要开辟新的数组，占内存空间，不行。

　　首先实现翻转整个句子：只需要在首尾两端各放置一个指针，交换指针所指的数字，两端指针往中间移动即可。之后根据空格的位置，对每个单词使用同样的方法翻转即可。


### 测试用例
1. 功能测试（句子中有一个/多个单词，空格在开头、中间、结尾）

2. 边界值测试（null，空字符串，句子全为空格）

## java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-03 10:53 by jdk 1.8
 */
public class ReverseWordsInSentence {
	public String reverseSetence(char[] chars) {
		if (chars == null || chars.length <= 0)
			return String.valueOf(chars);

		//翻转整个句子
		reverseSub(chars, 0, chars.length-1);

		//翻转单词（指针指向单词的第一个和最后一个）
		int start = 0;
		int end = 0;
		while (start < chars.length) {
			while (end < chars.length && chars[end] != ' ')
				end++;
			reverseSub(chars, start, end - 1);
			start = ++end;
		}
		return String.valueOf(chars);
	}

	public void reverseSub(char[] chars, int start, int end) {
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


# 左旋字符串

## 题目二
字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。请定义一个函数实现字符串左旋转操作的功能。比如输入字符串"abcdefg"和数字2，该函数将返回左旋转2位得到的结果"cdefgab"。


### 思路

本题思路和上一道题翻转单词顺序的原理一模一样，只是上一道题有空格，这道题没空格，其实这道题还更简单。先分别翻转前半部分字符串和后半部分字符串，最后翻转整个字符串即可。

### 测试用例

1. 功能测试（对长度为n的字符串，左旋转-1,0,1,2,n-1,n,n+1位）

2. 边界值测试（null）


## java代码


```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-03 11:33 by jdk 1.8
 */
public class LeftRotateString {
    public String leftRotateString(char[] chars, int n) {
        if (chars == null || chars.length <= 0)
            return String.valueOf(chars);

        if (n <= 0 || n > chars.length)
            return String.valueOf(chars);

        reverseSub(chars, 0, n-1);
        reverseSub(chars, n, chars.length - 1);
        reverseSub(chars, 0, chars.length - 1);

        return String.valueOf(chars);
    }

    private void reverseSub(char[] chars, int start, int end) {
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

## 总结

1. 这道题看似是移动字符，其实是翻转字符串实现的，要记住这类方法。



<hr />