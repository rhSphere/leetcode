---
title: 344. Reverse String
tags: [String, Two Pointers]
date: 2019-03-08 10:26:37
permalink: 344
categories: Easy
description: 

---
<p class="description">编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组char[]的形式给出。不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用O(1)的额外空间解决这一问题。</p>



<!-- more -->

- 头尾两个指针

```java 344. 反转字符串
class Solution {
    public void reverseString(char[] s) {
        int start = 0;
        int end = s.length - 1;
        while (start < end) {
            char tmp = s[start];
            s[start] = s[end];
            s[end] = tmp;
            start++;
            end--;
        }
    }
}

```


<hr />