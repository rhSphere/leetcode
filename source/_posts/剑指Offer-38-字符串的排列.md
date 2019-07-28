---
title: 剑指Offer(38) 字符串的排列
tags: [String]
date: 2019-07-26 09:47:20
permalink: string-permutation
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 字符串的排列

### 题目
　输入一个字符串，打印出该字符串中字符的所有排列。例如输入字符串abc，则打印出由字符a、b、c所能排列出来的所有字符串abc、acb、bac、bca、cab和cba。（本文代码采用ArrayList<String>接收返回的字符串，并要求不出现重复字符串）

### 思路
将字符串看成两部分，一部分是第一个字符，另一部分是后面的所有字符。

首先确定第一个字符，该字符可以是字符串中的任意一个；固定第一个字符后，求出后面所有字符的排列（相同步骤，采用递归）。

实现第一个字符的改变，只需要将第一个字符和后面所有字符交换即可。要记得字符串输出后，要将字符交换回来，变成原始的字符串。


使用递归每次处理一个位置，第一个位置有n种选择，第二个位置有n-1种选择

**假设当前位置是index，需要把其他位置的元素放到index上，则可以将该元素和index位置上的元素交换，这样原来index位置上的元素可以作为下一轮递归函数的index候选之一**

再一次循环中，交换完元素，调用递归函数，最后还需要再交换刚才的两个元素，相当于复原了当前递归函数中的str，在下一轮循环中考虑该index位置上的其他可能的选项。


### 测试用例
1. 功能测试（有多个重复字母的字符串、所有字符相同的字符串、一个字符或者多个字符的普通字符串）

2. 特殊测试（字符串为null、“”）


## java代码

```java
/**
 * @description: 剑指offer38 字符串的排列
 * @author: rhsphere
 * @since: 2019-07-26 09:46 by jdk 1.8
 */
public class StringPermutation {
	public ArrayList<String> permutation(String str) {
		ArrayList<String> list = new ArrayList<>();

		if (str == null || str.length == 0) 
			return list;
		permutationCore(str.toCahrArray(), 0, list);
		Collections.sort(list);
		return list;
	}

	private void permutationCore(char[] arr, int index, ArrayList<String> list) {
		if (index == arr.length - 1) {
			if (!list.contains(String.valueOf(arr)))  //判断是否有重复字符
				list.add(String.valueOf(arr));
		} else {
			for (int i = index; i < arr.length; i++) {
				swap(arr, index, i);
				permutationCore(arr, index + 1, list);
				swap(arr, index, i);
			}
		}
	}

	private void swap(char[] arr, int index, int i) {
		char tmp = char[index];
		char[inde] = char[i];
		char[i] = tmp;
	}
}




```


## 总结

1. 要对字符串进行修改，可以将字符串转化为字符数组进行修改，也可以考虑使用StringBuilder类。

2. list.contains()方法可以直接判断是否有重复字符串；Collections.sort(list)可以将list中的字符串进行排序。

3. 字符串和字符数组间的转化：str.toCharArray()     String.valueOf(strArray)

4. 数组在递归过程中进行了交换后，最终要记得交换回来（代码最后几行）


<hr />