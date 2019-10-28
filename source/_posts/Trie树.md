---
title: Trie树
tags: [String, Tree, Char Match]
date: 2019-10-28 22:04:07
permalink: trie
categories: String
description:
---
<p class="description"></p>


<!-- more -->

# Trie树 

[Trie树](https://time.geekbang.org/column/article/72414)

单模式串匹配有 BF、RK、naive-BM和KMP这四种算法。

本节实现的是一种 naive-Trie 
Trie树适合多模式串公共前缀较多的匹配（O(n*k)）或者 根据公共前缀进行查找 O(k)的经典场景，比如搜索框的自动补全提示。


针对一组字符串中查找字符串的问题，在工程中，更倾向于用散列表或者红黑树。Trie树不适合精确匹配查找。
Trie树比较适合的是查找前缀匹配的字符串。

# Java代码

```java
package com.ludepeng.datastruct.base.datastruct.charMath.trie;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @description:
 * @author: rhsphere
 * @since: 2019-10-28 10:51 by jdk 1.8
 */
public class MyTrie {
    /** 字符a的asc码值 */
    private static final char CHARA = 'a';

    private TrieNode root = new TrieNode('/');


    /** trie 树的基本节点信息 */
    public class TrieNode {
        /** 当前节点的值 */
        public char data;
        /** 子节点的信息 */
        public TrieNode[] children = new TrieNode[26];
        /** 用来标识当前是否被全完匹配 */
        public boolean isEndChar = false;

        public TrieNode(char data) {
            this.data = data;
        }
    }

    /**
     * 向trie树中插入一个字符
     * @param addVal 字符信息
     */
    public void insert(String addVal) {
        char[] charData = addVal.toCharArray();

        TrieNode procNode = root;

        for (int i = 0; i < charData.length; i++) {
            //计算当前字符的asc码值
            int ascVal = charData[i] - CHARA;
            if (procNode.children[ascVal] == null) {
                TrieNode newNode = new TrieNode(charData[i]);
                procNode.children[ascVal] = newNode;
            }
            procNode = procNode.children[ascVal];
        }
        procNode.isEndChar = true;
    }

    /**
     * 查找一个trie树
     *
     * @param pat 字符信息
     * @return 是否能被查找到
     */

    public boolean search(String pat) {
        char[] charsData = pat.toCharArray();

        TrieNode procNode = root;

        for (int i = 0; i < charsData.length; i++) {
            int ascVal = charsData[i] - CHARA;
            if (procNode.children[ascVal].data != charsData[i]) {
                return false;
            }

            procNode = procNode.children[ascVal];
        }

        if (!procNode.isEndChar) {
            return false;
        } else {
            return true;
        }
    }

    public Set<String> search2(String pat) {
        char[] charsData = pat.toCharArray();

        TrieNode proc = root;

        for (int i = 0; i < charsData.length; i++) {
            int index = charsData[i] - CHARA;

            if (proc.children[index] == null) {
                return null;
            }
            proc = proc.children[index];
        }

        List<Character> matchOthers = new ArrayList<>();

        for (int i = 0; i <= charsData.length - 1; i++) {
            matchOthers.add(charsData[i]);
        }

        Set<String> mvalueSet = new HashSet<>();
        addMatches(matchOthers, mvalueSet, proc);

        return mvalueSet;
    }

    public void addMatches(List<Character> matchOthers, Set<String> matchValue, TrieNode node) {
        if (node != null) {
            matchOthers.add(node.data);

            //检查是否是最后一级
            boolean isLast = true;

            for (int i = 0; i < node.children.length; i++) {
                if (node.children[i] != null)
                    isLast = false;
            }

            if (isLast) {
                char[] msgChars = new char[matchOthers.size()];

                for (int i = 0; i < matchOthers.size(); i++) {
                    msgChars[i] = matchOthers.get(i);
                }
                matchValue.add(new String(msgChars));
                return;
            }

        }  else {
            return;
        }

        for (TrieNode nodeItem : node.children) {
            int befSize = matchOthers.size();

            addMatches(matchOthers, matchValue, nodeItem);

            int afterSize = matchOthers.size();

            if (afterSize > befSize) {
                // 完成后需要移除最后一次添加的内容，数据，防止数据重复
                matchOthers.remove(matchOthers.size() - 1);
            }
        }
    }
}

```

<hr />