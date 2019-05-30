---
title: 150. Evalute Reverse Polish Notatio
tags: [Stack]
date: 2019-05-30 19:38:54
permalink: 150
categories: Medium
description:
---
<p class="description"></p>


<!-- more -->

## 逆波兰表达式求值
### 题目

根据[逆波兰表示法](https://baike.baidu.com/item/%E9%80%86%E6%B3%A2%E5%85%B0%E5%BC%8F/128437)，求表达式的值。

有效的运算符包括 +, -, *, / 。每个运算对象可以是整数，也可以是另一个逆波兰表达式。

说明：

整数除法只保留整数部分。 给定逆波兰表达式总是有效的。换句话说，表达式总会得出有效数值且不存在除数为 0 的情况。 示例 1：

输入: ["2", "1", "+", "3", "*"]
输出: 9
解释: ((2 + 1) * 3) = 9
示例 2：

输入: ["4", "13", "5", "/", "+"]
输出: 6
解释: (4 + (13 / 5)) = 6
示例 3：

输入: ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]
输出: 22
解释:
  ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
= ((10 * (6 / (12 * -11))) + 17) + 5
= ((10 * (6 / -132)) + 17) + 5
= ((10 * 0) + 17) + 5
= (0 + 17) + 5
= 17 + 5
= 22

### java代码
```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-05-30 19:52 by jdk 1.8
 */
public class EvaluateReversePolishNotation {
	public int evalRPN(String[] tokens) {
		if (tokens.length == 0) return 0;

		Stack<Integer> stack = new Stack<>();
		for (int i = 0; i < tokens.length; i++) {
			String s = tokens[i];

			if (s.equals("+") || s.equals("-") || s.equals("/") || s.equals("*")) {
				int b = stack.pop();
				int a = stack.pop();
				switch(s) {
					 case "+": stack.push(a+b);break;
                    case "-": stack.push(a-b);break;
                    case "*": stack.push(a*b);break;
                    case "/": stack.push(a/b);break;
				}
			} else {
				satck.push(Integer.valueOf(s));
			}
		}
		return stack.pop();
	}
}
```


<hr />