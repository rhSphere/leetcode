---
title: 20. Valid Parentheses
tags: [String, Stack]
date: 2019-05-29 09:16:30
permalink: 20
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 有效的括号 
### 题目
给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。

有效字符串需满足：

左括号必须用相同类型的右括号闭合。 左括号必须以正确的顺序闭合。 注意空字符串可被认为是有效字符串。

示例 1:

输入: "()"
输出: true
示例 2:

输入: "()[]{}"
输出: true
示例 3:

输入: "(]"
输出: false
示例 4:

输入: "([)]"
输出: false
示例 5:

输入: "{[]}"
输出: true



### java代码

```java
/**
 * @description: 有效括号
 * @author: rhsphere
 * @since: 2019-05-29 09:16 by jdk 1.8
 */
public class ValidParentheses {
	static Map<Character, Character> map = new HahsMap<>();
	static {
		map.put('(', ')');
		map.put('[', ']');
		map.put('{', '}');		
	}

	public static boolean isValid(String s) {
		Stack<Character> stack = new Stack<>();
		for (int i = 0; i < s.lengt(); i++) {
			char c = s.charAt(i);
			if (map.containsKey(c)) {
				stack.push(map.get(c));
			} else if (map.containsValue(c)) {
				if (stack.isEmpty() || stack.pop() != c) {
					return false;
				}
			}
		}
		return stack.isEmpty();
	}
	
	public static void main(String[] args) {
        String s = "()[]{}";
        boolean b = isValid(s);
        System.out.println(b);
    }

}


```

<hr />