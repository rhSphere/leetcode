---
title: 剑指Offer(12) 矩阵中的路径
tags: [Backtracking]
date: 2019-04-18 09:23:17
permalink: string-path-in-matrix
categories: 剑指Offer
description:
---
<p class="description">递归回溯本质上是一种枚举法，可以看成蛮力法的升级版。回溯法用于多个步骤，内个步骤都有多个选项的问题：若当前步骤满足条件，给定一个标记，当发现之后的步骤不满足条件时，去除标记。</p>


<!-- more -->

## 矩阵中的路径
### 题目
请设计一个函数，用来判断在一个矩阵中是否存在一条包含某字符串所有字符的路径。路径可以从矩阵中任意一格开始，每一步可以在矩阵中向左、右、上、下移动一格。如果一条路径经过了矩阵的某一格，那么该路径不能再次进入该格子。例如在下面的3×4的矩阵中包含一条字符串“bfce”的路径（路径中的字母用下划线标出）。但矩阵中不包含字符串“abfb”的路径，因为字符串的第一个字符b占据了矩阵中的第一行第二个格子之后，路径不能再次进入这个格子。
 A B T G
 C F C S
 J D E H

### 思路
首先对整个矩阵遍历，找到第一个字符，然后向上下左右查找下一个字符，由于每个字符都是相同的判断方法（先判断当前字符是否相等，再向四周查找），因此采用 **递归回溯**。由于字符查找过后不能重复进入，所有还要定义一个字符矩阵相同大小的 **布尔值矩阵**，进入过的格子标记为true。如果不满足的情况下，需要进行 **回溯**，此时，要将当前位置的布尔值标记回false。（**所谓的回溯无非就是对使用过的字符进行标记和对处理后的字符去标记**）

### 测试用例
1.功能测试（多行多列矩阵中存在或者不存在路径）

2.边界值测试（矩阵只有一行；矩阵与路径的所有字符都相同）

3.特殊输入测试（null）


## java代码
测试代码太长，未上传。

```java 面试题12：矩阵中的路径
public class StringPathInMatrix {
    public boolean hasPath(char[] matrix, int rows, int cols, char[] str) {
        if (matrix == null || rows < 1 || cols < 1 || str == null) {
            return false;
        }
        boolean[] isVisited = new boolean[rows * cols];
        for (boolean v : isVisited) {
            v = false;
        }
        int pathLength = 0;
        for (int row = 0; row < rows; row++) {
            for (int col = 0; col < cols; col++) {
                if (hasPathCore(matrix, rows, cols, row, col, str, pathLength, isVisited))
                    return true;
            }
        }
        return false;
    }

    private boolean hasPathCore(char[] matrix, int rows, int cols, int row, int col, char[] str, int pathLength,
            boolean[] isVisited) {
        if (row < 0 || col < 0 || row >= rows || col >= cols || isVisited[row * cols + col] == true
                || str[pathLength] != matrix[row * cols + col])
            return false;

        if (pathLength == str.length - 1)
            return true;
        boolean hasPath = false;

        isVisited[row * cols + col] = true;

        hasPath = hasPathCore(matrix, rows, cols, row - 1, col, str, pathLength + 1, isVisited)
                || hasPathCore(matrix, rows, cols, row + 1, col, str, pathLength + 1, isVisited)
                || hasPathCore(matrix, rows, cols, row, col - 1, str, pathLength + 1, isVisited)
                || hasPathCore(matrix, rows, cols, row, col + 1, str, pathLength + 1, isVisited);
        if (!hasPath) {
            isVisited[row * cols + col] = false;
        }
        return hasPath;
    }
}
```

## 总结
1. **回溯法用于多个步骤，内个步骤都有多个选项的问题：若当前步骤满足条件，给定一个标记，当发现之后的步骤不满足条件时，去除标记。**
2. 字符串转化为以为字符数组，使用toCharArray()方法。
3. 二维数组下标在一维数组中的计算： row · cols + col。

<hr />