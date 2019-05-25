---
title: 412. Fizz Buzz
tags: [String, Array]
date: 2019-05-25 20:45:57
permalink: 412
categories: Easy
description:
---
<p class="description"></p>


<!-- more -->

## 3和5的倍数
### 题目
写一个程序，输出从 1 到 n 数字的字符串表示。

如果 n 是3的倍数，输出“Fizz”；

如果 n 是5的倍数，输出“Buzz”；

3.如果 n 同时是3和5的倍数，输出 “FizzBuzz”。

示例：

n = 15,

返回:
[
    "1",
    "2",
    "Fizz",
    "4",
    "Buzz",
    "Fizz",
    "7",
    "8",
    "Fizz",
    "Buzz",
    "11",
    "Fizz",
    "13",
    "14",
    "FizzBuzz"
]

### java实现
```java
/**
 * @description: 比较简单，分别判断3和5的倍数标志
 * @author: rhsphere
 * @since: 2019-05-25 20:51 by jdk 1.8
 */
public class FizzBuzz {
	/*
	public List<String> fizzBuzz(int n) {
		List<String> list = new ArrayList<>();
		if (n <= 0) 
			return list;
		int i = 0;
		while (i <= n) {
			String out = "";
			boolean t = false, f = false;
			if (i % 3 == 0) t = true;
			if (i % 5 == 0) f = true;
			if (t & f) {
				out = "FizzBuzz";
			} else if (t) {
				out = "Fizz";
			} else if (f) {
				out = "Buzz";
			} else {
				out = Integer.toString(i);
			}
			list.add(out);
			i++;
		}
		return list;
	}
	*/

	public List<String> fizzBuzz(int n) {
		List<String> list = new ArrayList<>();
		for (int i = 1; i <= n; i++) {
			list.add(isMultiple(i));
		}
		return ans;
	}
	private String isMultiple(int n) {
		if (n % 3 == 0 && n % 5 != 0) {
			return "Fizz";
		} else if (n % 3 != 0 && n % 5 == 0) {
			return "Buzz";
		} else if (n % 15 == 0) {
			return "FizzBuzz";
		} else {
			return String.valueOf(n);
		}
	}

}
```

### 总结
1. 几个方法 String.valueOf(int n)、 Integer.toString(int n)、 list.add()
2. 注释的方法也有可取之处，比如 ** t & f **

<hr />