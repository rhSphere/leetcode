---
title: BF算法
tags: [String, Char Match]
date: 2019-10-28 13:33:28
permalink: brute-force
categories: String
description:
---
<p class="description"></p>


<!-- more -->

## BF算法 

[暴力匹配算法/朴素匹配算法](https://time.geekbang.org/column/article/71187)

简单场景，主串和模式串都不太长，O(m*n)

## Java代码

```java
/**
 * @description: BF字符串匹配算法，也叫暴力匹配算法 时间复杂度为 O(m*N) m为pat串长度，N为主串长度 *
 * @author: rhsphere
 * @since: 2019-10-26 21:59 by jdk 1.8
 */
public class BructForce {
    /**
     * 使用bf算法进进行字符串匹配搜索，
     *
     * @param src 源字符串，主串
     * @param pat 匹配的字符串，模式字符串
     * @return 返回查找字符串开始的下标，如果未找到返回-1
     */
    public int search(String src, String pat) {
    	int location = -1;
    	if (src == null || pat == null)
    		return location;

    	char[] srcCharArr = src.toCharArray();
    	char[] patCharArr = pat.toCharArray();

    	int srcStartIdx = 0;

        // 遍历主串
    	while (srcStartIdx < srcCharArr.length) {
            //如果遍历到尾部都没有找到，则结束返回    		
    		if (srcStartIdx + patCharArr.length > srcCharArr.length)
    			break;

            //模式串的匹配
    		for (int i = 0; i < patCharArr.length; i++) {
    			if (srcCharArr[i +srcStartIdx] == patCharArr[i]) {
    				if (location == -1)
    					location = i;
    				continue;
    			} else {
    				location = -1;
    				break;
    			}
    		}

            //如果索引被找到则直接返回
    		if (location != -1)
    			return location;

            // 跟踪主串的指针指向本次匹配开始位置的下一个字符   		
    		srcStartIdx++;
    	}

    	return location;
    }
}

```


```java
package com.ludepeng.datastruct.base.datastruct.charMath.simple.bf;

import org.junit.Test;

/**
 * @description: 测试BF算法
 * @author: rhsphere
 * @since: 2019-10-26 22:20 by jdk 1.8
 */
public class TestBructForce {

    @Test
    public void testBructForce() {
        BructForce instance = new BructForce();
        String src = "my first test class ever";
        String pat = "class";

        int location = instance.search(src, pat);
        System.out.println("查找的位置索引为: " + location);

        String sub = src.substring(location);
        System.out.println("截取后的字符串为: " + sub);
    }
    
    @Test
    public void testBructForceNot() {
        BructForce instance = new BructForce();
        String src = "my first test class ever";
        String pat = "clazz";

        int location = instance.search(src, pat);
        System.out.println("查找的位置索引为: " + location);
    }
}

```

<hr />