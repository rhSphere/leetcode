---
title: 剑指Offer(41) 数据流中的中位数
tags: [PriorityQueue]
date: 2019-07-29 21:51:57
permalink: stream-median
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 数据流中的中位数

### 题目
如何得到一个数据流中的中位数？如果从数据流中读出奇数个数值，那么中位数就是所有数值排序之后位于中间的数值。如果从数据流中读出偶数个数值，那么中位数就是所有数值排序之后中间两个数的平均值。

### 思路
所谓数据流，就是不会一次性读入所有数据，只能一个一个读取，每一步都要求能计算中位数。

　　将读入的数据分为两部分，一部分数字小，另一部分大。小的一部分采用大顶堆存放，大的一部分采用小顶堆存放。当总个数为偶数时，使两个堆的数目相同，则中位数=大顶堆的最大数字与小顶堆的最小数字的平均值；而总个数为奇数时，使小顶堆的个数比大顶堆多一，则中位数=小顶堆的最小数字。

因此，插入的步骤如下：

　　1. 若已读取的个数为偶数（包括0）时，两个堆的数目已经相同，将新读取的数插入到小顶堆中，从而实现小顶堆的个数多一。但是，如果新读取的数字比大顶堆中最大的数字还小，就不能直接插入到小顶堆中了 ，此时必须将新数字插入到大顶堆中，而将大顶堆中的最大数字插入到小顶堆中，从而实现小顶堆的个数多一。

　　2. 若已读取的个数为奇数时，小顶堆的个数多一，所以要将新读取数字插入到大顶堆中，此时方法与上面类似。

### 测试用例

1. 功能测试（读入奇/偶数个数字）

2. 边界值测试（读入0个、1个、2个数字）


## jav代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-07-29 21:52 by jdk 1.8
 */
public class StreamMedian {
	PriorityQueue<Integer> minHeap = new PriorityQueue<>();  //小顶堆，默认容量11
	PriorityQueue<Integer> maxHeap = new PriorityQueue<>(11, new Comparator<Integer>{
		public int compare(Integer i1, Integer i2) {
			return i2 - i1; 
		}
	});

	public void insert(Integer num) {
		if (((minHeap.size() + maxHeap.size()) & 1) == 0) {
			//偶数个时，下个数字加入小顶堆
			if (!maxHeap.isEmpty() && maxHeap.peek() > num) {
				maxHeap.offer(num);
				num = maxHeap.poll();
			}
			minHeap.offer(num);
		} else {
			//奇数个时，下个数字放入大顶堆
			if (!minHeap.isEmpty() && minHeap.peek() < num) {
				minHeap.offer(num);
				num = minHeap.poll();
			}
			maxHeap.offer(num);
		}
	}

	public Double getMedian() {
		if ((maxHeap.size() + minHeap.size()) == 0)
			throw new RuntimeException();
		double median;
		if (((minHeap.size() + maxHeap.size()) & 1) == 0) {
			median = (maxHeap.peek() + minHeap.peek()) / 2.0;
		} else {
			median = minHeap.peek();
		}
		return median;
	}
}
```


## 总结
1. 最大堆 最小堆其实就是优先队列，这里可以用PriorityQueue实现，PriorityQueue默认是一个小顶堆，通过传入自定义的Comparator函数，可以实现大顶堆：


```java
PriorityQueue<Integer> maxHeap = new PriorityQueue<Integer>(11, new Comparator<Integer>(){
	public int compare(Integer i1, Integer i2) {
		retrurn i2 - i1;  //降序排列
	}
});

```

PriorityQueue的常用方法有： poll()、 offer(Object)、 size()、 peek()等。


2. 平均值定义为double，且 (a+b）/2.0 。
3. 往最大堆中插入数据时间复杂度是O(logn)，获取最大数的时间复杂度是O(1)。
4. 这道题关键在于分成两个平均分配的部分，奇偶时分别插入到最大最小堆中，利用最大最小堆性质的插入方法要掌握。


<hr />