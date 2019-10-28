---
title: BM算法
tags: [String, Char Match]
date: 2019-10-28 14:04:44
permalink: boyer-moore
categories: String
description:
---
<p class="description"></p>


<!-- more -->

# BM算法 

[native-BM](https://time.geekbang.org/column/article/71525)

模式串最好不要太长（因为预处理较重），比如IDE编辑器里的查找场景；预处理O(m*m)，匹配O(n)，实现较复杂，需要较多额外空间。

## 坏字符规则

从后往前逐位比较模式串与主串的字符，当找到不匹配的坏字符时，记录模式串的下标值 si ，并找到坏字符在模式串中，位于下标 si前的最近位置 xi （若无则记为-1），si - xi 即为向后滑动距离。 但是坏字符规则向后滑动的步幅还不够大，于是需要好后缀规则。

将模式串中的每个字符及其下标都存在 哈希表中，这样可以快速找到坏字符在模式串的位置下标。相同的模式串字符，仅记录最后的位置。

## 好后缀规则

从后往前逐位比较模式串和主串的字符，当出现坏字符时停止。 若已经存在匹配成功的子串 {u}, 那么模式串的 {u} 前面找到最近的 {u}，记为 {u'}。 再将模式串后裔，是的模式串的 {u’} 与主串的 {u} 重叠。
若不存在 {u'}，则直接把模式串移到主串的 {u} 后面。
为了没有遗漏，还需要找到最长的、能够跟模式串的最长前缀子串匹配的，好后缀的后缀子串（同时也是模式串的后缀子串）。然后把模式串向后移动到其左边界，与这个好后缀个后缀子串在主串的中的左边界对齐。

好后缀的处理规则中最核心的内容：
1. 在模式串中，查找跟好后缀匹配的另一个子串；
2. 在好后缀的后缀子串中，查找最长的、能跟模式串前缀子串匹配的后缀子串。


技巧：

每次执行好后缀原则时，都会计算多次能够与模式串前缀子串相匹配的好后缀的最长后缀子串。为了提高效率，可以预先计算模式串的所有后缀子串，在模式串与之匹配的另一个子串的位置。同时预计算模式串中（同长度）后缀子串与前缀子串是否匹配并记录。在具体操作中直接使用，大大提高效率。

如何快速记录模式串后缀子串匹配的另一个子串位置，以及模式串（相同长度）前缀与后缀子串是否匹配呢？ 先用一个suffix数组，下标值k为后缀子串的长度，从模式串下标为 
i （0 ~ m-2）的字符为最后一个字符，查找这个子串是否与后缀子串匹配，若匹配则将子串起始位置的下标值j赋给suffix[k]。 若j为0，说明这个匹配子串的起始位置为模式串的起始位置，则用一个数组prefix，将prefix[k]设为true，否则设为false。k从0到m（模式串的长度）于是就得到了模式串所有前缀与后缀子串的匹配情况。

# Java代码

```java
package com.ludepeng.datastruct.base.datastruct.charMath.diffculty.bm;


/**
 * @description: bm 算法，用来进行高效的字符串查找
 * @author: rhsphere
 * @since: 2019-10-28 09:41 by jdk 1.8
 */
public class BoyerMoore {

	private static final int BYTE_SIZE = 256；

	public int bm(String src, String pat) {
		int location = -1;

		char[] srcCharArr = src.toCharArray();
		char[] patCharArr = pat.toCharArray();

		int n = srcCharArr.length;
		int m = patCharArr.length;
		//构建模式串哈希，记录每一个字符最后出现的位置
		int[] bcCodes = this.generateCode(patCharArr);

		//tag. 填充suffix和preffix数组
		int[] suffix = new int[m];
		boolean[] prefix = new boolean[m];

		//进行前缀数组和后缀数组所需的运算
		this.generateGS(patCharArr, suffix, prefix);


		// 主串与模式串对齐的第一个字符
		int i = 0;
		while (i <= n - m) {
			int j;

			for (j = m - 1; j >= 0; j--) {
				if (srcCharArr[i + j] != patCharArr[j])
					break;
			}
			if (j < 0)
				return i;
			// 1.srcCharArr[i+j] 标识当前1坏字符的位置
			// 2.把坏字符串在模式串的起始位置记为 si，当前使用j标识
			// 3. 然后去模式串查找坏字符串最后出现的位置 xi，当前为bcCodes[srcCharArr[i+j]]
			// 4.命名用 si - xi，即为需要移动的位数，所以 j - bcCodes[srcCharArr[i+j]]

			// 计算向后滑动的位数，先不考虑为负的情况
			int badCount = j - bcCodes[srcCharArr[i+j]];

			int y = 0;
			if (j < m-1) {
				y = moveGS(j, m, suffix, prefix);  //在tag。处预处理pat串得到 suffix和prefix数组
			}
			i = i + Math.max(badCount, y);
		}
		return location;
	}



    /**
     * 生成哈希表，记录模式串每一个字符最后出现的位置
     * @param patCharArr pat串
     * @return 生成的模式串所对应的hashcode表
     */
	private int[] generateCode(Char[] patCharArr) {
		int[] bcCode = new  int[BYTE_SIZE];
		for (int i = 0; i < BYTE_SIZE; i++) {
			bcCode[i] = -1;
		}

		for (int i = 0; i < patCharArr.length; i++)
			bcCode[patCharArr[i]] = i;

		return bcCode;
	}


    /**
     * 用来计算suffix 结合 prefix数组的信息
     * 在模式串 中，查找跟好后缀匹配的另一个子串
     * 在好后缀中，查找最长的，能跟模式串前缀子串匹配的后缀子串
     * @param patCharArr  模式串信息
     * @param suffix 后缀子串在前缀子串中的起始下标
     * @param prefix 后缀子串是否能匹配前缀子串
     */
	private void generateGS(char[] patCharArr, int[] suffix, boolean[] prefix) {
		// 初始化两个数组
		int len = patCharArr.length;
		for (int i = 0; i < len; i++) {
			suffix[i] = -1;
			prefix[i] = false;
		}

		// 计算填充两个模式串中的信息
		for (int i = 0; i < len - 1; i++) {  //patCharArr[0 ... i]
			int j = i;
			int k = 0;
			while (j >= 0 && patCharArr[j] == patCharArr[len - k - 1]) {
				j--;
				k++;
			}

			if (k != 0) {
				// j+1表示公共后缀子串在 patCharArr[0,i]中的起始下标
				suffix[k] = j + 1;
			}

			//如果是公共后缀子串，也是模式后缀串的前缀子串
			if (j == -1)
				prefix[k] = true;
		}

	}


    /**
     * @param j 坏字符在模式串的位置
     * @param m 模式串的长度
     * @param suffix 好后缀长度对应的起始索引
     * @param prefix 是否与前缀字符匹配
     * @return 移动的长度
     */
	private int moveGS(int j, int m, int[] suffix, int[] prefix) {
		//好后缀的长度
		int k = m - 1 -j;
		//规则1. 在模式串中，查找跟好后缀匹配的另一个子串
		if (suffix[k] != -1)
			return j - suffix[k] + 1;

		//规则2. 在好后缀的后缀子串中，查找最长的、能跟模式串前缀子串匹配的后缀子串
		// j 为坏字符串的位置 j+1为好后缀的位置 j+2为好后缀的子串开始位置
		for (int i = j + 2; i < m-1; i++) {
			if (prefix[m-i+1]) {
				return i;
			}
		}
		return j+1;
	}

}


```


```java
package com.ludepeng.datastruct.base.datastruct.charMath.diffculty.bm;

import org.junit.Test;


/**
 * @description:
 * @author: rhsphere
 * @since: 2019-10-28 10:23 by jdk 1.8
 */
public class TestBoyerMoore {

    @Test
    public void testBm() {
        String src = "this ludepeng";
        String find = "ludepeng";
        BoyerMoore instance = new BoyerMoore();
        int index = instance.bm(src, find);
        System.out.println(index);
        if (index != -1) {
            System.out.println("截取后:" + src.substring(index, index + find.length()));
        }
    }

}
```



# 总结

1. 对于一段代码不理解，可以使用Test进行debug，看看如何执行的，极大提高对这段代码执行流程的理解！！！！

比如生成suffix和prefix数组的这段代码的测试

```java
package com.ludepeng.datastruct.base.datastruct.charMath.diffculty.bm.demo;


/**
 * @description: 生成suffix和prefix字符串的代码
 * @author: rhsphere
 * @since: 2019-10-28 14:51 by jdk 1.8
 */
public class GenerateGS {

    // b表示模式串，m表示长度，suffix，prefix数组事先申请好了
    public void generateGS(char[] b, int m, int[] suffix, boolean[] prefix) {
        for (int i = 0; i < m; i++) {
            suffix[i] = -1;
            prefix[i] = false;
        }

        for (int i = 0; i < m - 1; i++) { //b[0 i]
            int j = i;
            int k = 0;
            while (j >= 0 && b[j] == b[m - 1 -k]) { //与b[0, m-1] 求公共子串
                j--;
                k++;
            }

            if (k != 0) suffix[k] = j + 1;  // j+1 表示公共后缀子串在 b[0, i] 中的起始下标
            if (j == -1) prefix[k] = true;  // 如果公共后缀子串也是模式串的前缀子串
        }
    }
}

```


```java
package com.ludepeng.datastruct.base.datastruct.charMath.diffculty.bm.demo;


import org.junit.Test;

import java.util.Arrays;

/**
 * @description: 测试生成 suffix和prefix数组
 * @author: rhsphere
 * @since: 2019-10-28 15:17 by jdk 1.8
 */
public class TestGenerateGS {

    @Test
    public void testGenerateGs() {

        GenerateGS instance = new GenerateGS();

        String find = "feife";
        int length = find.length();

        int[] suffix = new int[length];
        boolean[] prefix = new boolean[length];

        //这里单步调试 看suffix和prefix是如何生成的
        instance.generateGS(find.toCharArray(), length, suffix, prefix);

        System.out.println(Arrays.toString(suffix));
        System.out.println(Arrays.toString(prefix));
    }

}
```




<hr />