---
title: 剑指Offer(57) 和为s的数字
tags: [Two Pointers]
date: 2019-08-03 09:51:32
permalink: two-number-with-sum
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->
# 和为s的两个数字 

## 题目一
　　输入一个递增排序的数组和一个数字s，在数组中查找两个数，使得它们的和正好是s。如果有多对数字的和等于s，输出任意一对即可。

### 思路

从头开始遍历数字，确定一个数字后，对后面的数字遍历，判断和是否为s，这种方法复杂度为O(n^2)，效率太低。

　　我们考虑到，如果一个数字比较小，那么另一个数字一定比较大，同时数字为递增排列；所以，我们设置两个指针，一个指针small从第一个数字（最小）出发，另一个指针big从最后一个数字（最大）出发：

　　当small加big的和小于s时，只需要将small指向后一个数字（更大），继续判断；

　　当small加big的和大于s时，只需要将big指向前一个数字（更小），继续判断；

　　当small加big的和等于s时，求解完成。

　　由于是从两边往中间移动，所以不会有跳过的情况，时间复杂度为O(n)。

### 测试用例

1. 功能测试（存在/不存在和为s的一对数字）

2. 特殊输入测试（null）


## java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-03 09:54 by jdk 1.8
 */
public class TwoNumberWithSum {
    public ArrayList<Integer> findNumberWithSum(int[] arr, int sum) {
        ArrayList<Integer> list = new ArrayList<>();

        if (arr == null || arr.length <= 0)
            return list;

        int low = 0;
        int high = arr.length - 1;

        while (low < high) {
            if (arr[low] + arr[high] == sum) {
                list.add(arr[low]);
                list.add(arr[high]);
                break;
            }  else if (arr[low] + arr[high] < sum) {
                low++;
            } else {
                high--;
            }
        }
        return list;
    }
}
```


## 总结
1. 利用两个指针从两端向中间扫描，要学会这种技巧。


# 和为s的连续正数序列

## 题目二
输入一个正数s，打印出所有和为s的连续正数序列（至少含有两个数）。例如输入15，由于1+2+3+4+5=4+5+6=7+8=15，所以结果打印出3个连续序列1～5、4～6和7～8。


### 思路
**指针法：**
类似(57-1) 和为s的两个数字的方法，用两个指针small和big分别代表序列的最大值和最小值。令small从1开始，big从2开始。

　　当从small到big的序列的和小于s时，增加big，使序列包含更多数字；（记得更新序列之和）

　　当从small到big的序列的和大于s时，增加small，使序列去掉较小的数字；（记得更新序列之和）

　　当从small到big的序列的和等于s时，此时得到一个满足题目要求的序列，输出，然后继续将small增大，往后面找新的序列。

　　序列最少两个数字，因此，当small到了s/2时，就可以结束判断了。

**数学分析法：**
　参考自牛客网，丁满历险记的答案。

　　对于一个长度为n的连续序列，如果它们的和等于s，有：

　　1）当n为奇数时，s/n恰好是连续序列最中间的数字，即n满足 (n&1)==1 && s%n==0

　　2）当n为偶数时，s/n恰好是连续序列中间两个数字的平均值，小数部分为0.5，即n满足 (s%n)*2==n （判断条件中包含了n为偶数的判断）

　　得到满足条件的n后，相当于得到了序列的中间数字s/n，所以可以得到第一个数字为 (s / n) - (n - 1) / 2，结合长度n可以得到所有数字。

　　此外，在什么范围内找n呢？我们知道n至少等于2，那至多等于多少？n最大时，序列从1开始，根据等差数列的求和公式根据等差数列的求和公式：S = (1 + n) * n / 2，可以得到n应该小于sqrt(2s)，所以只需要从n=2到sqrt(2s)来判断满足条件的n，继而输出序列。



### 测试用例
1. 功能测试（存在/不存在和为s的序列）

2. 边界值测试（s=3）

## java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-03 10:09 by jdk 1.8
 */
public class ContinuousSequenceWithSum {
    //方法一：双指针法
	public ArrrayList<ArrayList<Integer>> findContinuousSeq(int sum) {
		ArrayList<ArrayList<Integer>> seqList = new ArrayList<>();

		if (sum <= 0)
			return seqList;

		int small = 1; 
		int big =2;
		int curSum = small + big;

		while (small <= sum/2) {
			if (curSum == sum) {
				ArrayList<Integer> seq = new ArrayList<>();
				for (int i = small; i <= big; i++)
					seq.add(i);
				seqList.add(seq);
				curSum -= small;
				small++;
			}

			if (curSum < sum) {
				big++;
				curSum += big;
			}
			if (curSum > sum) {
				curSum -= small;
				small--;
			}

		}

		return seqList;
	}
}
```


## 总结 
1. 还是利用两个指针，这个技巧要学会

2. 代码中求连续序列的和，并没有每次遍历计算，而是根据每次操作的情况而在之前的结果上进行加减，可以提高效率，值得学习

3. 题目57-1) 和为s的两个数字中的指针是从两端开始，本题指针从1，2开始，注意指针的初始设置。

4. 方法二中，当s/n的余数为0.5时，s%n的结果是n/2，而不是1。


<hr />