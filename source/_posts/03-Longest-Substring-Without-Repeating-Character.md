---
title: 03. Longest Substring Without Repeating Character
tags: [String]
date: 2019-10-29 12:29:57
permalink: longest-substring-without-repeating-characters
categories: Medium
description:
---
<p class="description"></p>


<!-- more -->

# 无重复字符的最长子串

剑指offer中的实现，[最长不含重复字符的子字符串](https://blogs.rhsphere.com/leetcode/2019/07/30/longest-substring-without-duplicate.html)，采用的是动态规划。

这里用另一种思路，哈希表存储最后出现的字符的下标。
用ascii码值来当做key。

开始使用 长度为26的数组当做哈希表，但是发现这里还有空格，所以使用了 长度为256的数组。

# Java代码--动态规划


```java

/**
 * @description:
 * @author: rhsphere
 * @since: 2019-10-29 12:36 by jdk 1.8
 */
public class LongestSubString {

    public static int maxLength(String s) {
        if (s == null || s.length() <= 0)  //总是会把字符串的长度写错
            return 0;

        int[] hash = new int[256];
        for (int i = 0; i < 256; i++)
            hash[i] = -1;

        int pre = 0;
        int cur = 0;
        int max = 0;

        for (int i = 0; i < s.length(); i ++) {
            char ch = s.charAt(i);
            if (hash[ch] < 0 || i - hash[ch] > pre) {
                cur = pre + 1;
            } else {
                cur = i - hash[ch];
            }
            hash[ch] = i;
            if (cur > max)
                max = cur;
            pre = cur;
        }
        return max;
    }
}

```

# Java代码

```java

/**
 * @description:
 * @author: rhsphere
 * @since: 2019-10-29 15:13 by jdk 1.8
 */
public class LongestSubString2 {
    public int lengthOfLongestSubstring(String s) {
        if(s == null || s.length() <= 0)
            return 0;

        int[] hash = new int[256];
        for(int i = 0;i < 256; i++)
            hash[i] = -1;

        int max = 0;
        int start=0;

        for(int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);

            if(hash[ch] >= start)
                start = hash[ch] + 1;

            max = Math.max(i - start + 1, max);
            hash[ch] = i;
        }
        return max;
    }
}


```

<hr />