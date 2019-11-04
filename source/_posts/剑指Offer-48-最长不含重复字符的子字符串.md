---
title: 剑指Offer(48) 最长不含重字符的子字符串
tags: [String, Dynamic Programming]
date: 2019-07-30 18:31:32
permalink: longest-substring-without-duplicate
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

# 最长不含重复字符的子字符串 

## 题目
请从字符串中找出一个最长的不包含重复字符的子字符串，计算该最长子字符串的长度。假设字符串中只包含从'a'到'z'的字符。

## 思路
动态规划法：定义函数f(i)为：以第i个字符为结尾的不含重复字符的子字符串的最大长度。

　　（1）当第i个字符之前未出现过，则有：f(i)=f(i-1)+1

　　（2）当第i个字符之前出现过，记该字符与上次出现的位置距离为d

　　　　1）如果d<=f(i-1)，则有f(i)=d；

　　　　2）如果d>f(i-1)，则有f(i)=f(i-1)+1；

　　我们从第一个字符开始遍历，定义两个int变量preLength和curLength来分别代表f(i-1)和f(i)，再创建一个长度为26的pos数组来存放26个字母上次出现的位置，即可根据上述说明进行求解。

　　注意：每次最大长度和字母出现位置要记得更新。

　　另一种思路：遍历每个字符，把当前字符看成子字符串的末尾结点，同时更新开头结点，代码见leetcode03中。

**这道题有一个很大的限制条件，字符串的取值为 a~z，所以用一个数组当 hash表足够，但是如果有空格就不行了。**
**所以可以采用一个更大的哈希表存储，最后一次出现的字符的位置 new int[256]; **


## 测试用例

1. 功能测试（一个或者多个字符，全部字符不同/相同）

2. 特殊测试（null，空字符串）


# java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-07-30 18:39 by jdk 1.8
 */
public class LongestSubstringWithoutDup {
	public static int maxLength(String str) {
		if (str == null || str.length() <= 0)
			return 0;

		int pre = 0;
		int cur = 0;
		int max = 0;

		int[] pos = new int[26];
		for (int i = 0; i < pos.length; i++)
			pos[i] = -1;

		for (int i = 0; i < str.length(); i++) {
			int letterNum = str.charAt(i) - 'a';
			if (pos[letterNum] < 0 || i - pos[letterNum] > pre) {
				cur = pre + 1;
			} else {
				cur = i - pos[letterNum];
			}
			pos[letterNum] = i;
			if (cur > max)
				max = cur;
			pre = cur;
		}
		return max;
	}

	 public static void main(String[] args) {
        System.out.println(maxLength("arabcacfr")==4);
        System.out.println(maxLength("a")==1);
        System.out.println(maxLength("aaa")==1);
        System.out.println(maxLength("abcdef")==6);
        System.out.println(maxLength("")==0);
        System.out.println(maxLength(null)==0);
    }
}
```


# 总结

1. 函数f(i)为：以第i个字符为结尾的不含重复字符的子字符串的最大长度。而不是以第i个字符作为开头。第i个字符作为结尾可以方便与下一个字符进行联系。

2. 学会用长度为26的数组来存放26个字母所在的位置下标。 即哈希表。


<hr />