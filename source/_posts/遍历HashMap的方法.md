---
title: 遍历HashMap的方法
tags: [HashMap]
date: 2019-10-23 14:12:58
permalink: tranverse-hashmap
categories: HashMap
description:
---
<p class="description"></p>


<!-- more -->

## 遍历HashMap

最近看源码比较多，从源码中收获很多。 其中Iterator 的方法建议忘记了再跟一些源码，看看是怎么来的。

不废话，直接上代码。

## Java代码

```java
package algo09.hashmap;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * @description: 遍历hashMap的方法
 * @author: rhsphere
 * @since: 2019-10-23 13:52 by jdk 1.8
 */
public class TraverseHashMap {
    /**1.遍历键值对，使用Map.Entry map.entrySet() public Set<Map.Entry<K,V>> entrySet()  */
    public static void tranverse1(Map<String, Integer> map) {
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            System.out.println("Key:" + entry.getKey());
            System.out.println("Value:" + entry.getValue());
        }
    }

    /** 2.显示调用 map.entrySet() 的集合迭代器 EntrySet的 iterator */
    public static void tranverse2(Map<String, Integer> map) {
        Iterator<Map.Entry<String, Integer>> iterator = map.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<String, Integer> entry = iterator.next();
            System.out.println("Key:" + entry.getKey());
            System.out.println("Value:" + entry.getValue());
        }
    }

    /** 3.遍历Key,使用map.keySet() */
    public static void tranverse3(Map<String, Integer> map) {
        for (String key : map.keySet()) {
            System.out.println("Key:" + key);
            System.out.println("Value:" + map.get(key));
        }
    }
    /** 4.遍历Value,使用map.values() */
    public static void tranverse4(Map<String, Integer> map) {
        for (int v : map.values())
            System.out.println("Value:" + v);
    }




    public static void main(String[] args) {
        HashMap<String, Integer> map = new HashMap<String, Integer>();
        map.put("一", 1);
        map.put("二", 2);
        map.put("三", 3);
        System.out.println("=====遍历键值对=====");
        tranverse1(map);
        System.out.println("=====遍历键值对=====");
        tranverse2(map);
        System.out.println("=====遍历键值对=====");
        tranverse3(map);
        System.out.println("=====遍历键值对=====");
        tranverse4(map);
    }
}

```




<hr />