---
title: 剑指Offer(3) 数组中重复的数字
tags: [Array, BinarySearch]
date: 2019-03-21 22:56:44
permalink: duplication-in-array
categories: 剑指Offer
description:
---
<p class="description">本文参考《剑指Offer》一书，代码采用Java实现。题目一：在一个长度为n的数组里的所有数字都在0到n-1的范围内。数组中某些数字是重复的，但不知道有几个数字重复了，也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。 题目二：在一个长度为n+1的数组里的所有数字都在1到n的范围内，所以数组中至少有一个数字是重复的。请找出数组中任意一个重复的数字，但不能修改输入的数组。 本文的两道题解题思路是不一样的，具体事项见正文。</p>


<!-- more -->

# 找出数组中重复数字

## 题目一
在一个长度为n的数组里的所有数字都在0到n-1的范围内。数组中某些数字是重复的，但不知道有几个数字重复了，也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。例如，如果输入长度为7的数组 {2, 3, 1, 0, 2, 5, 3} ，那么对应的输出是重复的数字2或者3。

### 思路
从哈希表的思路拓展，重排数组：把扫描的每个数字（如数字m）放到其对应下标（m下标）的位置上，若同一位置有重复，则说明该数字重复。

（在动手写代码前应该先想好测试用例）

### 测试用例：
1. 数组中带有一个或多个重复数字
2. 数组中不包含重复数字
3. 无效输入测试用例（空数组、数组数字越界等）


## Java代码及复杂度

复杂度：
时间复杂度： O(n)
空间复杂度： O(1)

尽管有两重循环，但是每个数字最多只要交换两次就能找到属于它的位置，因此钟的时间按复杂度是O(n)。
另外所有操作时在输入数组上进行的，不需要分配内存，空间复杂度是O(1)。

### 含测试代码

```java
public class FindDuplicateNumber1 {
	public int getDuplicate(int[] arr) {
		if (arr == null || arr.length <= 0) {
			System.out.println("数组输入无效");
			return -1;
		}
		for (int a : arr) {
			if (a < 0 || a > arr.length - 1) {
				System.out.println("数字大小超出范围");
				return -1;
			}
		}

		int tmp = 0;
		for (int i = 0; i < arr.length; i++) {
			while (arr[i] != i) {
				if (arr[arr[i]] = arr[i]) {
					return arr[i];
				}
				tmp = arr[i];
				arr[i] = arr[tmp];
				arr[tmp] = tmp;
			}
		}
		System.out.println("数组中无重复数字");
		return -1;
	}
}
```

在同一个类中，与上面的函数拆开的测试代码，为了函数更加简洁。

```java
public class FindDuplicateNumber1 {
	 /**
     *数组为null
     */
	public void test1() {
	System.out.print("test1：");
	int[] a = null;
	int dup = getDuplicate(a);
	if (dup >= 0)
		System.out.println("重复数字为：" + dup);
	}

	/**
	 * 数组无重复数字
	 */
	public void test2() {
		System.out.print("test2：");
		int[] a = { 0, 1, 2, 3 };
		int dup = getDuplicate(a);
		if (dup >= 0)
			System.out.println("重复数字为：" + dup);
	}

	/**
	 * 数组数字越界
	 */
	public void test3() {
		System.out.print("test3：");
		int[] a = { 1, 2, 3, 4 };
		int dup = getDuplicate(a);
		if (dup >= 0)
			System.out.println("重复数字为：" + dup);
	}

	/**
	 * 数组带重复数字
	 */
	public void test4() {
		System.out.print("test4：");
		int[] a = { 1, 2, 3, 2, 4 };
		int dup = getDuplicate(a);
		if (dup >= 0)
			System.out.println("重复数字为：" + dup);
	}

	public static void main(String[] args) {
		FindDuplicateNumber1 f = new FindDuplicateNumber1();
		f.test1();
		f.test2();
		f.test3();
		f.test4();
	}
}
```


### 不含测试代码（牛客网提交）
这里的代码为牛客网上通过的代码，如下：

```java
public class Solution {
	public boolean duplication(int[] numbers, int length, int[] duplication) {
		if (numbers == null || numbers.length <= 0) 
			return false;

		for (int a : numbers) {
			if (a < 0 ||　ａ >= length)
				return false;
		}

		int tmp;
		for (int i = 0 ; i < length; i++) {
			while (numbers[i] != i) {
				if (numbers[numbers[i]] == numbers[i]) {					
					duplication[0] = numbers[i];
					return true;
				}
				tmp = numbers[i];
				numbers[i] = numbers[tmp];
				numbers[tmp] = tmp;
			}
		}
		return false;
	}
}
```

# 不修改数组找出数组中重复数字

## 题目二

在一个长度为n+1的数组里的所有数字都在1到n的范围内，所以数组中至少有一个数字是重复的。请找出数组中任意一个重复的数字，但不能修改输入的数组。例如，如果输入长度为8的数组{2, 3, 5, 4, 3, 2, 6, 7}，那么对应的输出是重复的数字2或者3。

### 思路
数组长度为n+1，而数字只从1到n， ---说明必定有重复数字---。

可以由二分查找法拓展：把1~n的数字从中间数字m分成两部分，若前一半1~m的数字数目超过m个，说明重复数字在前一半区间，否则，在后半区间m+1~n。每次在区间中都一分为二，知道找到重复数字。

更简单的思路：把该数组看作一个链表，下标代表当前结点，值代表next指针。

### 测试用例：
1. 数组中带有一个或多个重复数字
2. ~~数组中不包含重复的数字(题目设置必有重复)~~
3. 无效输入测试用例（空数组、数组数字越界等）


## Java代码

时间复杂度说明：函数countRange()将被调用O(logn)次，每次需要O(n)的时间。

时间复杂度：O(nlogn)  （while循环为O(logn)，coutRange()函数为O(n)）

空间复杂度：O(1)


```java 
public class FindDuplicateNumber2 {
    /**
     * 找到数组中一个重复的数字
     * 返回-1代表无重复数字或者输入无效
     */
    public int getDuplicate(int[] arr) {
        if (arr == null || arr.lenght <= 0) {
             System.out.println("数组输入无效！");
            return -1;
        }

        for (int a : arr) {
            if (a < 1 || a > arr.length - 1) {
                System.out.println("数字大小超出范围！");
                return -1;
            }
        }
        int low = 0;
        int high = arr.length - 1; //为题目中的n

        int mid, count;
        while (low <= high) {
            mid = low + ((high - low) >> 1);
            count = countRange(arr, low, mid);
            if (low == high) {
                if (count > 1)
                    return low;
                else
                    break;
            }
            if (count > mid - low + 1) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return -1;
    }

    /**
     * 返回在[low,high]范围中数字的个数
     */
    public int countRange(int[] arr, int low, int high) {
        if (arr == null)
            return 0;

        int count = 0;
        for (int a : arr) {
            if (a >= low && a <= high) {
                count++;
            }
        }
        return count;
    }
}
```

在同一个类中，与上面的函数拆开的测试代码，为了函数更加简洁。

```java    
public class FindDuplicateNumber2 {
	/**
     *数组为null
     */
    public void test1() {
        System.out.print("test1：");
        int[] a = null;
        int dup = getDuplicate(a);
        if (dup >= 0)
            System.out.println("重复数字为：" + dup);
    }
 
    /**
     *数组数字越界
     */
    public void test2() {
        System.out.print("test2：");
        int[] a = { 1, 2, 3, 4 };
        int dup = getDuplicate(a);
        if (dup >= 0)
            System.out.println("重复数字为：" + dup);
    }
 
    /**
     *数组带重复数字
     */
    public void test3() {
        System.out.print("test3：");
        int[] a = { 1, 2, 3, 2, 4 };
        int dup = getDuplicate(a);
        if (dup >= 0)
            System.out.println("重复数字为：" + dup);
    }
 
    public static void main(String[] args) {
        FindDuplicateNumber2 f2 = new FindDuplicateNumber2();
        f2.test1();
        f2.test2();
        f2.test3();
    }
}
```

<hr />