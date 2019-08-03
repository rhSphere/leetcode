---
title: 剑指Offer(59-2) 队列的最大值
tags: [Deque]
date: 2019-08-03 16:12:37
permalink: queue-with-max
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

## 队列的最大值

### 题目
请定义一个队列并实现函数max得到队列里的最大值，要求函数max、push_back和pop_front的时间复杂度都是O(1)。

### 思路 
与滑动窗口的最大值一题相似，利用一个双端队列来存储当前队列里的最大值以及之后可能的最大值。

　　在定义题目要求功能的队列时，除了定义一个队列data存储数值，还需额外用一个队列maxmium存储可能的最大值；此外，还要定义一个数据结构，用于存放数据以及当前的index值，用于删除操作时确定是否删除maxmium中最大值。

　　

### 测试用例

　尾部插入不同大小数字，删除头部数字。插入删除同时获取最大值。

## java代码

```java
/**
 * @description:
 * @author: rhsphere
 * @since: 2019-08-03 16:52 by jdk 1.8
 */
public class QueueWithMax {
    private ArrayDeque<InternalData> data = new ArrayDeque<>();
    private ArrayDeque<InternalData> maximum = new ArrayDeque<>();

    private class InternalData {
        int number;
        int index;
        public InternalData(int number, int index) {
            this.number = number;
            this.index = index;
        }
    }
    private int curIndex;

    public void pushBack(int number) {
        InternalData curData = new InternalData(number, curIndex);
        data.addLast(curData);

        while (!maximum.isEmpty() && maximum.getLast().number < number)
            maximum.removeLast();
        maximum.addLast(curData);

        curIndex++;
    }

    public void popFront() {
        if (data.isEmpty()) {
            System.out.println("队列为空，无法删除");
            return;
        }

        InternalData curData = data.removeFirst();
        if (curData.index == maximum.getFirst().index)
            maximum.removeFirst();
    }

    public int max() {
        if (maximum == null) {
            System.out.println("队列为空，无法删除");
            return 0;
        }
        return maximum.getFirst().number;
    }
}
```







<hr />