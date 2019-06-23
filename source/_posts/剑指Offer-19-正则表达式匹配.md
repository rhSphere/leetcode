---
title: 剑指Offer(19) 正则表达式匹配
tags: [RegExp, String]
date: 2019-06-23 14:57:00
permalink: regular-expression
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

##  正则表达式匹配

### 题目
实现一个函数用来匹配包含'.'和 '\*' 的正则表达式。模式中的字符'.'表示任意一个字符，而 '\*' 表示塔前面的字符可以出现忍一次（含0次）。在本题中，匹配是指字符穿的所有字符匹配整个模式。例如，字符串"aaa"与模式"a.a"和"ab\*ac\*a"匹配，但与"aa.a"和"ab*a"均不匹配。

### 思路
	使用函数matchCore(char[] str, int indexOfStr, char[] pat, int indexOfPat)来实现每一步的比较（递归）。
1. 当模式中第二个字符不为"\*"时：若当前字符相等，则字符串和模式串都前后移一个字符，继续调用函数进行比较；若不相等，则返回false。
2. 当模式中第二个字符为"\*"时：若当前字符不相等，则模式后移两个字符，继续比较；若当前字符相等，则有三种情况：
	1. 字符串位置不变，模式后移两个字符，继续比较；
	2. 字符串后移一个字符，模式后移两个字符，继续比较；
	3. 字符串后移一个字符，模式字符位置不变，继续比较。
以上三种情况使用"||"进行并列比较。


### 测试用例
1. 功能测试（模式中包含普通字符、 "."、""; 匹配情况；不匹配情况）
2. 特殊测试 （null、空字符串）

## java代码
```java
/**
 * @description: 实现一个函数用来匹配包含‘，’和‘*’的正则表达式。
 * @author: rhsphere
 * @since: 2019-06-23 08:52 by jdk 1.8
 */
public class RegularExpression {
    public boolean match(char[] str, char[] pat) {
        if (str == null || pat == null)
            return false;
        return matchCore(str, 0, pat, 0);
    }

    public boolean matchCore(char[] str, int indexOfStr, char[] pat, int indexOfPat) {
        if (indexOfStr == str.length && indexOfPat == pat.length)
            return true;
        if (indexOfStr < str.length && indexOfPat == pat.length)
            return false;

        if (indexOfPat + 1 < pat.length && pat[indexOfPat + 1] == '*') {
            if ((indexOfStr < str.length && pat[indexOfPat] == '.') 
            	|| (indexOfStr < str.length && pat[indexOfPat] == str[indexOfStr])) {
                return matchCore(str, indexOfStr, pat, indexOfPat + 2)
                        || matchCore(str, indexOfStr + 1, pat, indexOfPat)
                        || matchCore(str, indexOfStr + 1, pat, indexOfPat + 2);
            } else {
                return matchCore(str, indexOfStr, pat, indexOfPat + 2);
            }
        }

        if (indexOfStr < str.length && (pat[indexOfPat] == str[indexOfStr] 
        	|| pat[indexOfPat] == '.')) {
            return matchCore(str, indexOfStr + 1, pat, indexOfPat + 1);
        }
        return false;
    }

    // ==========测试代码=========
    void test(String testName, char[] str, char[] pattern, boolean expected) {
        System.out.print(testName + ":");
        if (match(str, pattern) == expected)
            System.out.println("passed!");
        else
            System.out.println("failed!");
    }

    void test1() {
        char[] str = {};
        char[] pattern = { '.' };
        test("test1", str, pattern, false);
    }

    void test2() {
        char[] str = {};
        char[] pattern = { '.', '*' };
        test("test2", str, pattern, true);
    }

    void test3() {
        char[] str = { 'a' };
        char[] pattern = { '.', '*' };
        test("test3", str, pattern, true);
    }

    void test4() {
        char[] str = {};
        char[] pattern = {};
        test("test4", str, pattern, true);
    }

    void test5() {
        char[] str = null;
        char[] pattern = null;
        test("test5", str, pattern, false);
    }

    void test6() {
        char[] str = { 'a', 'b', 'b' };
        char[] pattern = { 'a', 'b', 'b', '*', 'b' };
        test("test6", str, pattern, true);
    }

    void test7() {
        char[] str = { 'a' };
        char[] pattern = { 'a', 'a', '*' };
        test("test7", str, pattern, true);
    }

    public static void main(String[] args) {
        RegularExpression demo = new RegularExpression();
        demo.test1();
        demo.test2();
        demo.test3();
        demo.test4();
        demo.test5();
        demo.test6();
        demo.test7();
    }
}
```

## 总结
1. 涉及到数组的情况下，一定要时刻注意数组越界的问题！
2. 对于每一步都是采用相同判断方法的题目，可以采用递归函数来实现
3. 思维一定要全面，把握住关键矛盾，将每种情况考虑清楚。例如这道题，关键就在于第二个字符是否为“*”，确定关键问题后，分析清楚每一种情况即可
4. 代码第29行的 indexOfStr < str.length 一定要记得加，否则可能会出现重复执行第32行的情况。

<hr />