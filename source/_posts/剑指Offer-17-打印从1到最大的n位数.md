---
title: 剑指Offer(17) 打印从1到最大的n位数
tags: [HQ Code]
date: 2019-06-19 20:49:27
permalink: print-1-to-n-digits
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 打印1到最大的n位数(需复习)

### 题目
输入数字n，按顺序打印出从1最大的n位十进制数。比如输入1，则打印出1、2、3一直到最大的3位数即999


### 思路
**陷阱**：n过大时是大数问题，不能简单用int或者long数据输出，需要采用字符串或者数组表达大数。

**解决方法**：通过字符数组char[]来进行输出数字。

**方法一**：

1. 在字符串表达的数字上模拟加法；

2. 把字符串表达的数字打印出来。

**方法二**：

1. 采用递归将每一位都从0到9排列出来；

2. 把字符串表达的数字打印出来。


### 测试用例
功能测试（输入1、2、3）
特殊测试（输入0、-1）

## int与char类型之间的相互转换
1. int类型转char类型，将数字加一个'0'，并**强制类型转换成char即可**、
2. char类型转int类型，将字符减去一个‘0’

```java char和int之间的类型转换
public static void main(String[] args) {
	//int类型转char类型
	int number = 9;
	char cNumber = (char)(number + '0');
	System.out.pritnln("Number " + number + "to char is:" + cNumber);

	//char类型装int类型
	char ch = '3';
	int number2 = ch - '0';
}
```


## java代码
### 非递归法
每次加一并打印这个数，直到最大的n位数并终止递增

```java
/**
 * @description: 面试题17：输入数字n，按顺序打印出从1最大的n位十进制数。比如输入3，则打印出1、2、3一直到最大的3位数即999。
 * @author: rhsphere
 * @since: 2019-06-13 22:18 by jdk 1.8
 */
public class Print1ToMaxOfNDigit {
	// 方法一

    /**
     * 采取模拟加一的方法
     */
	public void print1ToMaxOfNDigits(int n) {
		if (n <= 0) 
			return;
		char[] number = new char[n];
		//不能用foreach对number赋值
		for (int k = 0; k < number.length; k++) {
			number[k] = '0';
		}
		while (!increment(number)) {
			printCharNumber(number);
		}
	}

	/**
     * 对字符串进行加一操作，number达到最大值后返回true
     * 最低位加1；所以如果所有位超过10，则进位
    */
	private boolean increment(char[] number) {
		int nTakeOver = 0; //代表进位
		for (int i = number.length - 1; i >= 0; i--) {
			int nSum = (number[i] - ' 0') + nTakeOver; //当前位置数字
			// number[i] - '0' 是把char转成int，nTakeOver代表进位
			if (i == number.length - 1)
				nSum++;
			if (nSum >= 10) {
				if (i == 0)
					return true;
				nTakeOver = 1;
				nSum -= 10;
				number[i] = (char) (nSum + '0');
			} else {
				number[i] = (char) (nSum + '0');
				break; //高位不变，可以直接跳出循环
			}
		}
		return false;
	}
	/**
     * 打印字符数组形成的数字
     * 书中方法：利用布尔变量isBeginning0来从第一个非零字符打印
     */
	private void printCharNumber(char[] number) {
		boolean isBeginning0 = true;
		for (int i = 0; i < number.length; i++) {
			if (isBeginning0 && (number[i] - '0') != 0) {
				isBeginning0 = false;
			}
			if (!isBeginning0) {
				System.out.print(number[i]);
			}
		}
		System.out.println();
	}
	/**
     * 打印字符数组形成的数字
     * 自己的方法：找出第一个非零字符位置，往后进行打印
     */
	private void printCharNumber2(char[] number) {
		int beginner = number.length; //不写成number.llength - 1，以防写出0
		for (int i = 0; i < number.length - 1; i++) {
			if ((number[i] - '0') != 0){
				beginner = i;
				break;
			}
		}
		for (int i = beginner; i <= number.length - 1; i++) {
			System.out.print(number[i]);
		}
		if (beginner != number.length)
			System.out.println();
	}
}
```


### 递归方法
如果在数字前面补0.就会发现n位所有十进制其实就是n个从0到9的全排列。也就是说，我们把数字的每一位都从0到9排列一遍，就得到了所有的十进制数。
只是在打印的时候，排在前面的0不打印出来。
全排列用递归很容易表达，数字的每一位都可能是0~9中的一个数，然后设置下一位。
递归终止条件是我们已经设置了数字的最后一位。

```java
public class Print1ToMaxOfNDigit {
	//方法二
	/**
	*采用递归算法
	*/
	public void print1ToMaxOfNDigits(int n) {
		if (n <= 0)
			return;
		char[] number = new char[n];
		for (int k = 0; k < number.length; k++)
			number[k] = '0';
		for (int i = 0; i <= 9; i++) 
			makeNumber(n, number, i, 0);
	}
	//生成数字
	private void makeNumber(int n, char[] number, int nNumber, int index) {
		if (index == number.length - 1) {
			number[index] = (char)(nNumber + '0');
			printCharNumber(number);
			return;
		} else {
			number[index] = (char)(nNumber + '0');
			for (int i = 0; i <=9; i++) {
				makeNumber(n, number, i, index + 1);
			}
		}
	}
	private void printCharNumber(char[] number) {
		int beginner = number.length;
		for (int i = 0; i <= number.length - 1; i++) {
			if ((number[i] - '0') != 0) {
				beginner = i;
				break;
			}
		}
		for (int i = beginner; i <= number.length - 1; i++) {
			System.out.print(number[i]);
		}
		if (beginner != number.length)
			System.out.pritnln();
	}

}
```

## 清晰、简洁版本的java代码
```java
public class Print1ToMaxOfNDigit {

	public void print1ToMaxOfNDigits(int n) {
		if (n <= 0)
			return;
		char[] digit = new char[n];
		for (int i = 0; i < n; i++) 
			digit[i] = '0';
		for (int i = n - 1; i >= 0; i--) {
			while (digit[i] != '9') {
				int m = 0;
				digit[m]++;
				while (m < n-1 && digit[m] > '9') {
					digit[m] = '0';
					digit[m+1]++;
					m++;
				}
				printDigits(digit);
			}
		}
	}

	private void printDigits(char[] digit) {
		int m = digit.length - 1;
		while (digit[m] == '0')
			m--;
		for (int i = m; i >= 0; i--)
			System.out.print(digit[i]);
		Sytem.out.println();
	}

}
```

## 总结
1. 打印字符串镖师的数组，从第一个非零数字打印。
2. 关注大数问题

<hr />