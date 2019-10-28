---
title: RK算法
tags: [String, Char Match]
date: 2019-10-28 13:44:36
permalink: rabin-karp
categories: String
description:
---
<p class="description"></p>


<!-- more -->

# RK算法 

[RK算法](https://time.geekbang.org/column/article/71187)

通过对主串中 n-m+1 个子串分别求hash值，然后逐个与模式串的哈希值比较大小。 在对主串构建的时候，就对比是不是一样的，一样就不继续计算后面的hash值。

一种简单的hash算法，a~z这26个英文字母，对应的数字相加，得到的和作为hash值，为了解决hash碰撞的问题在，哈希值相等的时候，再对比一下子串和模式串本身。


字符集范围不要太长且模式串不要太长，否则hash值可能冲突，O(n)

# Java代码

```java
package com.ludepeng.datastruct.base.datastruct.charMath.simple.rk;

import java.util.HashMap;
import java.util.Map;

/**
 * @description: rk算法，BF算法的升级版，加入了hash散列计算，使时间复杂度降低到了O(N)
 * @author: rhsphere
 * @since: 2019-10-27 17:22 by jdk 1.8
 */
public class RabinKarp2 {

  private static final char[] RK_STR = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
    'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
    'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' '
  };

  /** 字符串对照表 */

  private static final Map<Character, Integer> CHAR_MAP = new HashMap<>(RK_STR.length);

  static {
  	for (int i = 0; i < RK_STR.length; i++)
  		CHAR_MAP.put(RK_STR[i], i+1);
  }


    /**
     * 进行字符串查找的函数
     * @param src 主串
     * @param pat 模式字符串
     * @return 返回索引的下标位置，-1为未查询到
     */
    public int search(String src, String pat) {
    	int location = -1;
    	if (src == null || pat == null)
    		return location;

    	char[] srcCharArr = src.toCharArray();
    	char[] patCharArr = pat.toCharArray();

    	long pathash = countHash(patCharArr);

    	int srcStartIndex = 0;
    	while (srcStartIndex < srcCharArr.length) {
    		if (srcStartIndex + patCharArr.length > srcCharArr.length)
    			return location;

    		int end = srcStartIndex + patCharArr.length;

    		long hash2 = countHash2(srcCharArr, srcStartIndex, end);

    		if (pathash == hash2) {
    			if (match(patCharArr, srcCharArr, srcStartIndex))
    				return srcStartIndex;
    		}
    		srcStartIndex++;
    	}
    	return location;
    }


    private boolean match(char[] pat, char[] src, int start) {
    	for (int i = 0; i < pat.length; i++) {
    		if (pat[i] != src[i + start])
    			return false;
    	}
    	return true;
    }

    /**
     * 计算hash值2的方法
     *
     * @param arr 原始字符串1
     * @param start 起始位置
     * @param end 结束位置
     * @return 查找到索引位置
     */
    private long countHash2(char[] srcCharArr, int start, int end) {
    	long res = 0L;
    	for (int i = end - 1; i >= start; i--)
    		res += CHAR_MAP.get(arr[i]);
    	return res;
    }



    /**
     * 计算模式串hash值的方法
     * @param arr 模式串
     * @return hash
     */
    private long countHash(char[] arr) {
    	long res = 0L;
    	for (int i = arr.length - 1; i >= 0; i--)
    		res += CHAR_MAP.get(arr[i]);
    	return res;
    }
}
```



```java
package com.ludepeng.datastruct.base.datastruct.charMath.simple.rk;

import org.junit.Test;

/**
 * @description:
 * @author: rhsphere
 * @since: 2019-10-27 18:32 by jdk 1.8
 */
public class TestRabinKarp2 {

    @Test
    public void testFind() {
        String src = "my name is ludepeng THIS NAME IS LKR";
        String pat = "NAME";

        RabinKarp2 findInstance = new RabinKarp2();
        int location = findInstance.search(src, pat);
        System.out.println("查找的索引号为 ：" + location);

        if (-1 != location) {
            System.out.println("截取字符串为:" + src.substring(location, location + pat.length()));
        }
    }

}

```


## Java代码 -- 复杂的hash

```java
package com.ludepeng.datastruct.base.datastruct.charMath.simple.rk;

import org.omg.PortableInterceptor.INACTIVE;

import java.util.HashMap;
import java.util.Map;

/**
 * @description: rk算法，BF算法的升级版，加入了hash散列计算，使时间复杂度降低到了O(N)
 * @author: rhsphere
 * @since: 2019-10-27 17:22 by jdk 1.8
 */
public class RabinKarp {
    private static final char[] RK_STR = {
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
            't', 'u', 'v', 'w', 'x', 'y', 'z', ' '
    };

    private static final int SCALE = RK_STR.length;

    /** 字符串的对照表 */
    private static final Map<Character, Integer> CHAR_MAP = new HashMap<>(RK_STR.length);

    static {
        for (int i = 0; i < RK_STR.length; i++) {
            CHAR_MAP.put(RK_STR[i], i + 1);
        }
    }

    /**
     * 进行字符串查找的函数
     * @param src 主串
     * @param pat 模式字符串
     * @return 返回索引的下标位置，-1为未查询到
     */
    public int search(String src, String pat) {
        int location = -1;
        if (src == null || pat == null)
            return location;

        char[] srcCharArr = src.toCharArray();
        char[] patCharArr = pat.toCharArray();

        int srcStartIndex = 0;
        // 1.计算查找字符串的hash
        long patHash = countHash(patCharArr);

        while (srcStartIndex < srcCharArr.length) {
            if (srcStartIndex + patCharArr.length > src.length())
                return location;

            int end = srcStartIndex + patCharArr.length;
            long hash2 = countHash2(srcCharArr, srcStartIndex, end);

            if (hash2 == patHash)
                return srcStartIndex;

            srcStartIndex++;
        }
        return location;
    }

    /**
     * 计算hash值2的方法
     *
     * @param arr 原始字符串1
     * @param start 起始位置
     * @param end 结束位置
     * @return 查找到索引位置
     */
    private long countHash2(char[] arr, int start, int end) {
        long res = 0L;
        //1.进行模式串的计算
        for (int i = end - 1; i >= start; i--) {
            double val = Math.pow(SCALE, CHAR_MAP.get(arr[i]));
            res += val;
        }
        return res;
    }

    /**
     * 计算模式串hash值的方法
     * @param arr 模式串
     * @return hash
     */
    private long countHash(char[] arr) {
        long res = 0L;

        //1. 进行模式串的CHAR_MAP计算
        for (int i = arr.length - 1; i >= 0; i--) {
            double val = Math.pow(SCALE, CHAR_MAP.get(arr[i]));
            res += val;
        }
        return res;
    }

}

```


<hr />