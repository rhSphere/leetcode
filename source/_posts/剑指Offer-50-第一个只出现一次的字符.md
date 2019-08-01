---
title: 剑指Offer(50) 第一个只出现一次的字符
tags: []
date: 2019-07-30 23:08:07
permalink:
categories:
description:
---
<p class="description"></p>


<!-- more -->

# 字符串中第一个只出现一次的字符

## 题目一
在字符串中找出第一个只出现一次的字符。如输入"abaccdeff"，则输出'b'。


### 思路
创建哈希表，键值key为字符，值value为出现次数。第一遍扫描：对每个扫描到的字符的次数加一；第二遍扫描：对每个扫描到的字符通过哈希表查询次数，第一个次数为1的字符即为符合要求的输出。

　　由于字符（char）是长度为8的数据类型，共有256中可能，因此哈希表可以用一个长度为256的数组来代替，数组的下标相当于键值key，对应字符的ASCII码值；数组的值相当于哈希表的值value，用于存放对应字符出现的次数。

### 测试用例

1. 功能测试（存在/不存在只出现一次的字符；全部都为只出现一次的字符）

2. 特殊测试（null）

## java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-07-31 08:00 by jdk 1.8
 */
public class FirstNotRepeatingChar {
	public char firstNotRepeatingChar(String str) {
		if (str == null)
			return '\0';
		int[] rep = new int[256];
		for (int i = 0; i < 256; i++)
			rep[i] = 0;

		for (int i = 0; i < str.length(); i++) {
			int loc = (int) str.charAt(i);
			rep[loc] += 1;
		}

		for (int i = 0; i < str.length(); i++) {
			int loc = (int) str.charAt(i);
			if (rep[loc] == 1)
				return (char) loc;
		}
		return '\0';
	}

    public static void main(String[] args) {
        FirstNotRepeatingChar demo =new FirstNotRepeatingChar();
        System.out.println((demo.firstNotRepeatingChar("google")=='l'));
        System.out.println((demo.firstNotRepeatingChar("aabccdbd")=='\0'));
        System.out.println((demo.firstNotRepeatingChar("$abcdefg")=='$'));
        System.out.println((demo.firstNotRepeatingChar(null)=='\0'));
    }
}
```

## 总结
1. 如果需要创建哈希表，键值为 字符，值为 数字时，可以考虑用数组（length=256）来替代，数组下标表示为字符的ASCII码值。

2. 哈希表的时间复杂度为O(1)，要求有较高的查找速度时，可以考虑使用哈希表（Java中可以使用HashMap)

3. 如果需要判断多个字符是否在某个字符串中出现过，或者统计多个字符在某个字符串中出现的次数，可以考虑基于数组创建一个简单的哈希表，这样可以用很小的空间消耗换来时间效率的提升。



# 字符流中第一个只出现一个的字符

## 题目二
请实现一个函数用来找出字符流中第一个只出现一次的字符。例如，当从字符流中只读出前两个字符"go"时，第一个只出现一次的字符是'g'。当从该字符流中读出前六个字符"google"时，第一个只出现一次的字符是'l'。

### 思路
    字符只能一个一个从字符流中读出来，因此要定义一个容器来保存字符以及其在字符流中的位置。

　　为尽可能高效解决问题，要在O(1)时间内往数据容器中插入字符，及其对应的位置，因此这个数据容器可以用哈希表来实现，以字符的ASCII码作为哈希表的键值key，字符对应的位置作为哈希表的值value。

　　开始时，哈希表的值都初始化为-1，当读取到某个字符时，将位置存入value中，如果之前读取过该字符（即value>=0），将value赋值为-2，代表重复出现过。最后对哈希表遍历，在value>=0的键值对中找到最小的value，该value即为第一个只出现一次的字符，ASCII码为key的字符即为所求字符。

### 测试用例

1. 功能测试（读入一个字符；读入多个字符；所有字符都唯一；所有字符重复）

2. 特殊测试（读入0个字符）


## java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-01 18:49 by jdk 1.8
 */
public class FirstCharInStream {
	private int index;
	private int[] occurence;

	pubilc FirstCharInStream() {
		index = 0;
		occurence = new int[256];
		for (int i = 0; i < 256; i++)
			occurence[i] = -1;
	}

	public void insert(char ch) {
		if (occurence[(int)ch] == -1) {
			occurence[(char)ch] == index;  //第一次出现
		} else if (occurence[(int)ch] >= 0) {
			occurence[(int)ch] = -2;
		}
		index++;
	}
	public char getFirst() {
		int minIdx = Integer.MAX_VAULE;
		char ch = '#';
		for (int i = 0; i < 256; i++) {
			if (occurence[i] >= 0 && occurence[i] < minIdx) {
				ch = (char) i;
				minIdx = occurence[i];
			}
		}
		return ch;
	}
}
```


## 总结 

1. 对于数据流、字符流等，需要定义数据容器来保存记录。

　　　　流和串的区别：

　　　　1）串：字符串已经保存下来了，能够读取遍历，因此在字符串中第一个只出现一次的字符中，只需要存下每个字符出现的个数，然后直接在字符串中遍历；

　　　　2）流：字符流没有存下来，无法进行遍历，因此在本题中，只能在数据容器哈希表中遍历，而且哈希表中存放的是对应字符的位置，而不是个数。

2. 记得会用构造函数来初始化参数；

3. Integer.MAX_VALUE=2^31-1，是32位操作系统（4字节）中最大的符号型整型常量。

4. 分清楚：字符与ASCII码的转化，以及 字符形式的数字和整形数字之间的转化。

```java
public static void main(String[] args) {
	//字符转化成ASCII码
	char ch_a = 'a';
	int code_a = (int) char_a;  // =ASCII码97

	//ASCII码转化成字符
	char copyCh_a = (char) code_a;  // =ASCII码97对应的字符'a'

	//字符形式数字转化为整数
	char c1 = '2';
	int n1 = c1 - '0';   //=2, 由'2'和'1'的ASCII码相减得到

	//数字转化为字符形式
	char copyC1 = (char)(n1 + '0');  //='2' ,由'0'的ASCII码加2得到'2'的ASCII码

}
```



<hr />