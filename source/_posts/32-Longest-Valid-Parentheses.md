---
title: 32. Longest Valid Parentheses
tags: [String, Stack, Dynamic Programming]
date: 2019-05-30 18:44:28
permalink: 32
categories: Hard
description:
---
<p class="description"></p>


<!-- more -->

## 最长有效括号 
### 题目
给定一个只包含 '(' 和 ')' 的字符串，找出最长的包含有效括号的子串的长度。

示例 1:

输入: "(()"
输出: 2
解释: 最长有效括号子串为 "()"
示例 2:

输入: ")()())"
输出: 4
解释: 最长有效括号子串为 "()()"

### 思路
使用栈，本题用了栈的三个操作。

要记住，**字符串等价于字符数组**，字符串的每个字符都是可以等价于字符数组，所以可以利用数组的性质。


### java代码
```java
**
 * @description:
 * @author: rhsphere
 * @since: 2019-05-30 18:47 by jdk 1.8
 */
public class LongestValidParentheses {
	public static int longestValidParentheses(String s) {
		Stack<Integer> stack = new Stack<>();
		stack.push(-1);

		int max = 0;

		for (int i = 0; i < s.length(); i++) {
			if (s.charAt(i) == '(') {
				stack.push(i);
			} else {
				if (!stack.isEmpty()) {
					stack.pop();
				}
				if (stack.isEmpty()) {
					stack.push(i);
				} else {
					max = Math.max(max, i - stack.peek());
				}
			}
		}
		return max;
	}

	 public static void main(String[] args) {
        String s = "())((())";
        int len = longestValidParentheses(s);
        System.out.println(len);
    }

}
```

### 总结
写完代码读一下，检查一下错误，这次有两处错误，1）s.charAt(i) == '()' 
2）max = Math.max(max, i - peek());

<hr />