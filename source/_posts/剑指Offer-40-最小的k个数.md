---
title: 剑指Offer(40) 最小的k个数
tags: [Heap]
date: 2019-07-28 20:39:28
permalink: k-least-numbers
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 最小的k个数 

关于堆排序，堆的下沉操作，圆满解决。

### 题目
输入n个整数，找出其中最小的k个数。例如输入4、5、1、6、2、7、3、8这8个数字，则最小的4个数字是1、2、3、4。


### 思路
思路一：同剑指offer(39) 数组中出现次数超过一半的数字中使用partition()方法，基于数组的第k个数字调整，使得更小的k个数字都在数组左边即可。

思路二：依次遍历n个整数，用一个容器存放最小的k个数字，每遇到比容器中最大的数字还小的数字时，将最大值替换为该数字。容器可以使用最大堆或者红黑树来实现。本文根据堆排序的原理来实现。


### 测试用例

1. 功能测试（数组中存在/不存在重复数字）

2. 边界值测试（k=1或者等于数组长度）

3. 特殊测试（null、k<1、k大于数组长度）


## java代码

### 用partition函数修改数组

```java
/**
 * @description: 剑指offer40
 * @author: rhsphere
 * @since: 2019-07-28 20:47 by jdk 1.8
 */
public class KLeastNum {
	public ArrayList<Integer> getLeastNumbers(int[] input, int k) {
		ArrayList<Integer> list = new ArrayList<>(k);
		if (input == null || k <= 0 || k > input.length) {
			return list;
		}
		int start = 0;
		int end = input.length - 1;
		int index = partition(input, start, end);
		while (index != k - 1) {
			if (index < k - 1) {
				start = index + 1;
				index = partition(input, start, end);
			} else {
				end = index - 1;
				index = partition(input, start, end);
			}
		}
		for (int i = 0; i < k; i++) 
			list.add(input[i]);
		return list;
	}

	private int partition(int[] arr, int startIndex, int endIndex) {
		int pivot = arr[startIndex];
		int low = startIndex;
		int high = endIndex;

		while (low != high) {
			while (low < high && arr[high] > pivot)
				high--;
			while (low < high && arr[low] <= pivot) 
				low++;
			if (low < high) {
				int tmp = arr[low];
				arr[low] = arr[high];
				arr[high] = tmp;
			}
		}

		arr[startIndex] = arr[low];
		arr[low] = pivot;
		return low;
	}
}
```

### 基于堆的容器

```java
/**
 * @description: 基于堆的容器
 * @author: rhsphere
 * @since: 2019-07-29 13:25 by jdk 1.8
 */
public class KLeastNum_Heap {
	public ArrayList<Integer> getLeastNum(int[] input, int k) {
		ArrayList<Integer> list = new ArrayList<>();
		if (k <= 0 || k > input.length || input == null) 
			return list;

		int numbers = new int[k];

		for (int i = 0; i < k; i++)
			numbers[i] = input[i];

		for (int i = k/2 - 1; i >= 0; i--)
			downAdjust(numbers, i, k);

		//这两句可以写成
		//buildHeap(numbers);

		for (int i = k; i < input.length; i++) {
			if (input[i] < numbers[0]) {
				numbers[0] = input[i];
				adjustHeap(numbers, 0, k);
			}
		}

		for (int i : numbers)
			list.add(i);
		return list;
	}

	private void downAdjust(int[] arr, int parent, int length) {
		int tmp = arr[parent];
		int child = 2 * parent + 1;
		while (child < length) {
			if (child + 1 < length && arr[child + 1] > arr[child])
				child++;
			if (tmp >= arr[child])
				break;
			arr[parent] = arr[child];
			parent = child;
			child = 2 * child + 1;
		}
		arr[parent] = tmp;
	}
	private void buildHeap(int arr) {
		for (int i = arr.length/2 - 1; i >= 0; i--)
			downAdjust(arr, i, arr.length);
	}
}
```

## 总结

1. 本题就是对快速排序和堆排序的延伸。

2. k小于等于0的情况别忘记了

3. 方法二，只需要在原始数组中进行读入操作，而所有的写操作和判断都是在容器中进行的，不用反复读取原始数组，思想非常好。

4. 记得要弄清楚是否可以改变原始输入的数组。

5. partition函数：即是快速排序的基础，也可以用来查找n个数中第k大的数字。

6. 当涉及到频繁查找和替换最大最小值时，二叉树是非常合适的数据结构，要能想到堆和二叉树。




<hr />