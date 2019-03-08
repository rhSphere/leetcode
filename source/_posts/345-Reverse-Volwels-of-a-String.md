---
title: 345. Reverse Volwels of a String
tags: [String, Two Pointers]
date: 2019-03-08 10:40:16
permalink: 345
categories: Easy
description:
---
<p class="description">编写一个函数，以字符串作为输入，反转该字符串中的元音字母。</p>


<!-- more -->
- 错误点有两处，看代码注释

```java 345. 反转字符串中的元音字母
class Solution {
    public String reverseVowels(String s) {
        char[] res = s.toCharArray();
        int start = 0;
        int end = res.length - 1;
        while (start < end) {
            if (isVowels(res[start]) && isVowels(res[end])) {
                char tmp = res[start];
                res[start] = res[end];
                res[end] = tmp;
                start++;
                end--;
            } else if (!isVowels(res[start])) {
                start++;
            } else if(!isVowels(res[end])) {
                end--;
            }
        }
        //这里return一个字符串的方法要注意
        return new String(res);
    }
    
    public static boolean isVowels(char ch) {
        //犯错的地方
        //前面忘了写 ch=  ch+32 和 ch+=32的区别
        ch = ch >= 'A' && ch <= 'Z' ? ch += 32 : ch;

        return ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u';
    }
}
```


<hr />