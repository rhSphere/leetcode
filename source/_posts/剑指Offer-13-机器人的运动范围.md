---
title: 剑指Offer(13) 机器人的运动范围
tags: [Backtracking]
date: 2019-04-19 08:43:37
permalink: robot-move
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

# 机器人的移动范围
## 题目
地上有一个m行n列的方格。一个机器人从坐标(0, 0)的格子开始移动，它每一次可以向左、右、上、下移动一格，但不能进入行坐标和列坐标的数位之和大于k的格子。
例如，当k为18时，机器人能够进入方格(35, 37)，因为3+5+3+7=18。但它不能进入方格(35, 38)，因为3+5+3+8=19。请问该机器人能够到达多少个格子？

### 思路
与[剑指offer(12) 矩阵中的路径](https://blogs.rhsphere.com/leetcode/2019/04/18/string-path-in-matrix.html)类似，也采用回溯法，先判断机器人能否进入(i,j)，再判断周围4个格子。
不同的是，这题返回的是int值。

递归回溯本质上是一种枚举法，可以看成蛮力法的升级版。回溯法用于多个步骤，每个步骤都有多个选项的问题：若当前步骤满足条件，给定一个标记，当发现之后的步骤不满足条件时，去除标记。

### 测试用例
1. 功能测试（多行多列矩阵，k为正数）
2. 边界值测试（矩阵只有一行或一列；k=0）
3. 特殊输入测试（k为负数）

## Java代码
已验证代码正确性，测试部分去除。

```java 
public class RobotMove {
    public int movingCount(int threshold, int rows, int cols) {
        if (rows <= 0 || cols <= 0 || threshold < 0) {
            return 0;
        }
        boolean[] isVisited = new boolean[rows * cols];
        int count = movingCountCore(threshold, rows, cols, 0, 0, isVisited);
        return count;
    }

    private int movingCountCore(int threshold, int rows, int cols, int row, int col, boolean[] isVisited) {
        if (row < 0 || col < 0 || row >= rows || col >= cols || isVisited[row * cols + col]
                || cal(row) + cal(col) > threshold)
            return 0;

        isVisited[row * cols + col] = true;
        return 1 + movingCountCore(threshold, rows, cols, row - 1, col, isVisited)
                + movingCountCore(threshold, rows, cols, row + 1, col, isVisited)
                + movingCountCore(threshold, rows, cols, row, col - 1, isVisited)
                + movingCountCore(threshold, rows, cols, row, col + 1, isVisited);
    }

    private int cal(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }
}
```

## 总结
1. 计算数位之和时，要注意数字不一定是十位数，可能是百位、千位甚至更多，所以cal()函数别写成计算十位数的方法了。
2.  row >= rows || col >= cols  这里的等号。
3.  return 0; 而不是 return false;

<hr />