---
title: KMP算法
tags: [String, Char Match]
date: 2019-10-28 16:39:51
permalink: kmp
categories: String
description:
---
<p class="description"></p>


<!-- more -->

# KMP算法


[KMP算法](https://time.geekbang.org/column/article/71845) 文章讲的比较系统了。

[next函数](https://www.zhihu.com/question/21923021)，这个文章有助于看懂next函数是怎么一回事。

适合所有场景，整体实现起来也比BM简单，O(n+m)，仅需要一个next数组的O(n)额外空间；但统计意义下似乎BM更快，原因不明。

1. 匹配失败时，总能够让pat回退到某个位置，而不是全部回退，而src不用回退。
2. 在字符串比较时，pat提供的信息越多，计算复杂度越低。


最难理解的地方是
k = next[k]
因为前一个的最长串的下一个字符不与最后一个相等，需要找前一个的次长串，问题就变成了求0到next[k]的最长串，如果下个字符与最后一个不等，也就是下一个next[k]，直到找到，或者完全没有。


# Java代码

```java
package com.ludepeng.datastruct.base.datastruct.charMath.diffculty.kmp;


/**
 * @description: kmp算法
 * @author: rhsphere
 * @since: 2019-10-28 10:31 by jdk 1.8
 */
public class Kmp {
    /**
     * 使用kmp算法进行字符串的查找
     * @param src 主串
     * @param pat 模式串
     * @return 模式串在主串中的下标
     */
    public int kmp(String src, String pat) {
    	char[] srcCharArr = src.toCharArray();
    	char[] patCharArr = pat.toCharArray();

    	int n = srcCharArr.length;
    	int m = patCharArr.length;
    	int location = -1;

    	//通过模式串构建next数组
    	int[] nexts = this.getNext(patCharArr);

    	int j = 0;

    	for (int i = 0; i < n; i++) {

	    	//从前向后匹配，当发生不匹配的时候，将模式串回退到合适的位置
	    	//模式串不是回退到0，而是回退到 次最长可匹配前缀子串
    		whlie (j > 0 && srcCharArr[i] != patCharArr[j]) {
    			j = nexts[j-1] + 1;
    		}

    		if (srcCharArr[i] == patCharArr[j])
    			j++;

    		if (j == m)
    			return i - m + 1;
    	}
    	return location;
    }

    
    /**
     * 对模式串预处理，获得一个存储模式串中每个前缀的最长可匹配前缀子串的结尾字符的下标
     * @param patCharArr 模式串
     * @return next数组，或失效函数
     */
    public int[] getNext(char[] patCharArr) {
    	int m = patCharArr.length;
    	int[] next = new int[m];

    	next[0] = -1;
    	int k = -1;

    	for (int i = 1; i < m; i++) {
    		while (k >= 0 && patCharArr[k+1] != patCharArr[i]) {
    			k = next[k];   //找到次最长可匹配前缀子串
    		}

    		if (patCharArr[i] == patCharArr[k+1])
    			k++;

    		next[k] = k;
    	}
    	return next;
    	
    }

}
```



# 总结
1. getNext的代码并不难理解，但是由于 文字描述比较绕口，所以看文字很难一下子体会到，仍然建议使用单元测试来debug 调试跟踪内存，多打断点就能体会到妙处。

放上单元测试的代码

```java
package com.ludepeng.datastruct.base.datastruct.charMath.diffculty.kmp.demo;

/**
 * @description: 测试getnext函数
 * @author: rhsphere
 * @since: 2019-10-28 17:37 by jdk 1.8
 */
public class GetNext {

    public int[] getNext(char[] patCharArr) {
        int m = patCharArr.length;

        int[] next = new int[m];
        next[0] = -1;

        int k = -1;  //k为前缀最长可匹配前缀子串的结尾字符下标
        for (int i = 1; i < m; i++) {
            while (k >= 0 && patCharArr[k+1] != patCharArr[i]) {
                k = next[k];
            }

            if (patCharArr[i] == patCharArr[k+1]) {
                k++;  //找到次最长可匹配前缀子串
            }
            next[i] = k;
        }
        return next;
    }
}

```


```java
package com.ludepeng.datastruct.base.datastruct.charMath.diffculty.kmp.demo;


import org.junit.Test;

import java.util.Arrays;

/**
 * @description: 测试next函数
 * @author: rhsphere
 * @since: 2019-10-28 17:45 by jdk 1.8
 */
public class TestGetNext {

    @Test
    public void testGetNext() {
        GetNext instance = new GetNext();

        String pat1 = "ababacd";
        char[] patCharArr1 = pat1.toCharArray();

        int[] next1 = instance.getNext(patCharArr1);
        System.out.println(Arrays.toString(next1));

        String pat2 = "abababzabababa";
        char[] patCharArr2 = pat2.toCharArray();

        int[] next2 = instance.getNext(patCharArr2);
        System.out.println(Arrays.toString(next2));
    }
}

```

<hr />