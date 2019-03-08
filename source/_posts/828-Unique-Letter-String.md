---
title: 828. Unique Letter String
tags: Math
date: 2019-03-07 15:59:33
permalink: 828
categories: Hard
description:
---
<p class="description">如果一个字符在字符串S中有且仅有出现一次，那么我们称其为独特字符。对于给定字符串S，计算其所有非空子串的独特字符的个数，即 UNIQ(substring)。如果出现两个或者多个相同的子串，将其认为是不同的两个子串。</p>


<!-- more -->
In each loop, We caculate cur[i], which represent the sum of Uniq() for all substrings whose last char is S.charAt(i).

For example,
S = 'ABCBD'
When i = 2, cur[2] = Uniq('ABC') + Uniq('BC') + Uniq('C')
When i = 3, cur[3] = Uniq('ABCB') + Uniq('BCB') + Uniq('CB') + Uniq('B')

Notice, we append char 'B' into each previous substrings. Only in substrings 'CB' and 'B', the char 'B' can be identified as uniq. The contribution of 'B' from cur[2] to cur[3] is i - showLastPosition['B']. At the same time, in substrings 'ABCB', 'BCB', the char 'B' can‘t’ be identified as uniq any more, the previous contribution of 'B' should be removed.

So we have'cur[i] = cur[i - 1] - contribution[S.charAt(i)] + (i - showLastPosition[S.charAt(i)])
Then the new contribution[S.charAt(i)] = i - showLastPosition[S.charAt(i)]

The final result is the sum of all cur[i].


```java 828. 独特字符串
class Solution {
    public int uniqueLetterString(String S) {             
        int res = 0;
        if (S == null || S.length() == 0)
            return res;    
        int[] showLastPosition = new int[128];
        int[] contribution = new int[128];
        int cur = 0;
        for (int i = 0; i < S.length(); i++) {
            char x = S.charAt(i);
            cur -= contribution[x]; 
            contribution[x] = (i - (showLastPosition[x] - 1));
            cur += contribution[x]; 
            showLastPosition[x] = i + 1;
            res += cur;
        }   
        return res;    
    }
}

```


<hr />