---
title: 剑指Offer(31) 栈的压入、弹出序列
tags: [Stack]
date: 2019-08-03 20:46:22
permalink: stack-push-pop-order
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 栈的压入、弹出序列 

### 题目
输入两个整数序列，第一个序列表示栈的压入顺序，请判断第二个序列是否为该栈的弹出顺序。假设压入栈的所有数字均不相等。例如序列1、2、3、4、5是某栈的压栈序列，序列4、5、3、2、1是该压栈序列对应的一个弹出序列，但4、3、5、1、2就不可能是该压栈序列的弹出序列。

### 思路
建立一个栈，按照压栈序列依次进行入栈操作，按出栈序列的顺序依次弹出数字。在出栈时，若下一个要出栈的数字与栈顶数字相同则弹出。如果压栈序列中的所有数字都入栈后没有完全出栈成功则代表两个序列不匹配，返回false。

### 测试用例
1. 功能测试（两个数组长度不同；两个数组对应；两个数组不对应）

2. 特殊测试（数组为空；null；一个数字的数组）

## java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-03 21:06 by jdk 1.8
 */
public class StackPushPopOrder {
	public boolean isPopOrder(int[] pushA, int[] popA) {
		if (pushA == null || popA == null)
			return false;
		if (pushA.length != popA.length || popA.length == 0)
			return false;

		Stack<Integer> stack = new Stack<>();
		int popIndex = 0;
		for (int pushIndex = 0; pushIndex < pushA.length; pushIndex++) {
			stack.push(pushA[pushIndex]);
			while (!stack.empty() && stack.peek() == popA[popIndex]) {
				stack.pop();
				popIndex++;
			}
		}
		return stack.empty();
	}

	 public static void main(String[] args) {
        int[] pushA = {1, 2, 3, 4, 5};
        int[] popA = {4, 3, 5, 1, 2};

        StackPushPopOrder demo = new StackPushPopOrder();
        System.out.println(demo.isPopOrder(pushA, popA));
    }
}
```


## 总结
1. 弄清楚栈的出栈逻辑。




<hr />