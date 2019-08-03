---
title: 剑指Offer(30) 包含min函数的栈
tags: [Stack]
date: 2019-08-03 20:31:42
permalink: stack-with-min
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 包含min函数的栈

### 题目
  定义栈的数据结构，请在该类型中实现一个能够得到栈的最小元素的min函数。在该栈中，调用min、push及pop的时间复杂度都是O(1)。


### 思路

最初想法是定义一个成员变量min来存放最小元素，但是当最小元素弹出后，min就需要相应改变，所以必须把每次的最小值都存储下来。考虑采用一个辅助栈来存放最小值：

　　栈  3，4，2，5，1

　   辅助栈 3， 3，2，2，1
（压入时，把每次的最小元素（之前最小元素与新入栈元素的较小值）保存起来放到辅助栈中）

### 测试用例
1. 新压入数字更大
2. 新压入数字最小
3. 弹出数字最小
4. 弹出数字不是最小

## java代码

```java
/**
 * @description: 剑指offer30
 * @author: rhsphere
 * @since: 2019-08-03 20:35 by jdk 1.8
 */
public class StackWithMin {
	Stack<Integer> stack = new Stack<>();
	Stack<Integer> aux = new Stack<>();

	public void push(int node) {
		stack.push(node);
		if (aux.empty() || aux.peek() > node) {
			aux.push(node);
		} else {
			aux.push(stack.peek());
		}
	}

	public void pop() {
		if (!stack.empty()) {
			stack.pop();
			aux.pop();
		}
	}

	public int min() {
		return aux.peek();
	}
}
```

## 总结
1. 构造辅助栈用来装数据。

<hr />