---
title: 剑指Offer(5) 替换空格
tags: [String]
date: 2019-03-24 00:37:04
permalink: replace-spaces
categories: 剑指Offer
description:
---
<p class="description">本文有两道题。第一道题，请实现一个函数，把字符串中的每个空格替换成"%20"。例如输入“We are happy.”，则输出“We%20are%20happy.”。 第二道题，实现对一组无序的字母进行从小到大排序（区分大小写），当两个字母相同时，小写字母放在大写字母前。要求时间复杂度为O(n)。</p>


<!-- more -->

## 替换空格
### 题目
请实现一个函数，把字符串中的每个空格替换成"%20"。例如输入“We are happy.”，则输出“We%20are%20happy.”。

**思路:**

首先要询问面试官是新建一个字符串还是在原有的字符串上修改，本题要求在原字符串上进行修改。

若从前往后依次替换，在每次遇到空格字符时，都需要移动后面O(n)个字符，对于含有O(n)个空格字符的字符串而言，总的时间效率为O(n^2)。

转变思路：先计算需要的总长度，然后从后往前进行复制和替换，则每个字符只需要复制一次即可。时间效率为O(n)。

**测试用例：**
1. 字符串中无空格
2. 字符串中含有空格（连续空格，空格在首尾等）
3. 字符串为空字符串或者为null

### 完整代码
根据牛客网的编程练习参考，方法的输入为StringBuffer（String无法改变长度，所以采用StringBuffer），输出为String。

``` java  剑指Offer5 替换空格
public class ReplaceSpaces {
	public String replaceSpaces(StringBuffer) {
	if (str == null) {
		System.out.println("输入错误")；
		return null;
	}

	int length = str.length();
	int indexOfOriginal = length - 1;
	for (int i = 0; i < str.length(); i++) {
		if (str.charAt(i) == ' ') {
			length += 2;
		}
	}

	str.setLength(length);
	int indexOfNew = length - 1;

	while (indexOfNew > indexOfOriginal) {
		if (str.charAt(indexOfOriginal) != ' ') {
			str.setCharAt(indexOfNew--, str.charAt(indexOfOriginal));
		} else {
			str.setCharAt(indexOfNew--, '0');
			str.setCharAt(indexOfNew--, '2');
			str.setCharAt(indexOfNew--, '%');
		}
		indexOfOriginal--;
	}
	return str.toString();
	}
	// ==================================测试代码==================================
 
    /**
     * 输入为null
     */
    public void test1() {
        System.out.print("Test1：");
        StringBuffer sBuffer = null;
        String s = replaceSpace(sBuffer);
        System.out.println(s);
    }
     
    /**
     * 输入为空字符串
     */
    public void test2() {
        System.out.print("Test2：");
        StringBuffer sBuffer = new StringBuffer("");
        String s = replaceSpace(sBuffer);
        System.out.println(s);
    }
     
    /**
     * 输入字符串无空格
     */
    public void test3() {
        System.out.print("Test3：");
        StringBuffer sBuffer = new StringBuffer("abc");
        String s = replaceSpace(sBuffer);
        System.out.println(s);
    }
     
    /**
     * 输入字符串为首尾空格，中间连续空格
     */
    public void test4() {
        System.out.print("Test4：");
        StringBuffer sBuffer = new StringBuffer(" a b  c  ");
        String s = replaceSpace(sBuffer);
        System.out.println(s);
    }
     
    public static void main(String[] args) {
        ReplaceSpaces rs = new ReplaceSpaces();
        rs.test1();
        rs.test2();
        rs.test3();
        rs.test4();
    }
}

```

## 无序字母排序

### 题目
实现对一组无序的字母进行从小到大排序（区分大小写），当两个字母相同时，小写字母放在大写字母前。要求时间复杂度为O(n)。

**思路：**
使用排序算法在最好的情况下的时间复杂度都在O(nlogn)，不满足题目要求。
通常字母为26个，当区分大小写后，变成26*2=52个，所以申请长度为52的int型数组，按照aAbB...zZ(小写字母保存在下标为偶数的位置，大写字母保存在下标为奇数的位置)的顺序一次记录各个字母出现的次数，当记录完成后，就可以遍历这个数组按照各个字母出现的次数来重组排序后的数组。

### 实现
```java  无序字母排序
public class SortCharacters {

	public static void main(String[] args) {
		String s = "HappyBirthdayzLinkeRuIlikeyouazz";
		char[] src = s.toCharArray();
		sort(src);
		for (char ch : src) {
			System.out.print(ch + " ");
		}
	}

	private static void sort(char[] src) {
		if (src == null) {
			System.out.println("参数不合法");
			return;
		}
		// 用于保存52个字符出现的次数，小写字母保存在下标为偶数的位置，大写字母保存在奇数位置

		int[] charCount = new int[52];

		for (int i = 0; i < src.length; i++) {
			//
			if (src[i] >= 'a' && src[i] <= 'z') {
				charCount[(src[i] - 'a') * 2]++;
			} else if (src[i] >= 'A' && src[i] <= 'Z') {
				charCount[(src[i] - 'A') * 2 + 1]++;
			}

		}

		int index = 0;

		for (int i = 0; i < charCount.length; i++) {
			if (charCount[i] != 0) {
				if (i % 2 == 0) { // 小写字母
					for (int j = 0; j < charCount[i]; j++)
						src[index++] = (char) (i / 2 + 'a');
				} else { // 大写字母
					for (int j = 0; j < charCount[i]; j++)
						src[index++] = (char) ((i - 1) / 2 + 'A');
				}
			}
		}
	}
}
```

<hr />