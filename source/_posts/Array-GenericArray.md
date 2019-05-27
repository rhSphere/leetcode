---
title: Array&&GenericArray
tags: [GenericArray, Array]
date: 2019-05-27 11:02:51
permalink: array-and-genericarray
categories: Sum-up
description:
---
<p class="description"></p>


<!-- more -->
自己实现动态数组：
1. 实现一个大小固定的有序数组，支持动态增删改操作
2. 实现一个支持动态扩容的泛型数组
3. 
## 大小固定的有序数组，支持动态增删改操作
```java
/**
 * @description: 实现一个大小国定的有序数组，支持动态增删改操作。
 * 1)数组的插入、删除、按照下标随机访问操作；
 * 2）数组中的数据是int类型的。
 * @author: rhsphere
 * @since: 2019-05-27 10:21 by jdk 1.8
 */
public class Array {
    //定义整型数据data保存数据
    public int data[];
    //定义数组长度
    private int n;
    //定义实际中的个数
    private int count;

    //构造方法，定义数组大小
    public Array(int capacity) {
        this.data = new int[capacity];
        this.n = capacity;
        this.count = 0; //初始化后没有存数
    }
    //根据索引找到数据中的元素并返回
    public int find(int index) {
        if (index < 0 || index >= count)
            return -1;
        return data[index];
    }
    //插入元素，尾部插入
    public boolean insert(int index, int value) {
        // 数组空间已满
        if (count == n) {
            System.out.println("没有可插入的位置");
            return false;
        }
        // 如果count还没满，那么就可以插入数据到数组中
        // 位置不合法
        if (index < 0 || index > count) {
            System.out.println("位置不合法");
            return false;
        }
        //位置合法
        for (int i = count; i > index; --i) {
            data[i] = data[i - 1];
        }
        data[index] = value;
        ++count;
        return true;
    }
    //根据索引，删除数组中元素
    public boolean delete(int index) {
        if (index < 0 || index >= count)
            return false;
        //从删除位置开始，将后面的元素向前移动一位
        for (int i = index + 1; i < count; i++) {
            data[i - 1] = data[i];
        }
        count--;
        return true;
    }
    public void printAll() {
        for (int i = 0; i < count; i++) {
            System.out.print(data[i] + " ");
        }
        System.out.println();
    }
    public static void main(String[] args) {
        Array arr = new Array(5);
        arr.printAll();
        arr.insert(0, 3);
        arr.insert(0, 4);
        arr.insert(1, 5);
        arr.insert(3, 9);
        arr.insert(3, 10);
        arr.printAll();
    }
}
```


## 支持动态扩容的泛型数组
```java
/**
 * @description: 实现一个支持动态扩容的泛型数组
 * @author: rhsphere
 * @since: 2019-05-27 10:43 by jdk 1.8
 */
public class GenericArray<T> {
    private T[] data;
    private int size;

    // 根据传入容量，构造Array
    public GenericArray(int capacity) {
        data = (T[]) new Object[capacity];
        size = 0;
    }

    // 无参构造方法，默认数组容量为10
    public GenericArray() {
        this(10);
    }

    // 获取数组容量
    public int getCapacity() {
        return data.length;
    }

    // 获取当前元素个数
    public int count() {
        return size;
    }

    // 判断数组是否为空
    public boolean isEmpty() {
        return size == 0;
    }

    // 修改 index 位置的元素
    public void set(int index, T e) {
        checkIndex(index);
        data[index] = e;
    }

    // 获取对应 index 位置的元素
    public T get(int index) {
        checkIndex(index);
        return data[index];
    }

    // 查看数组是否包含元素e
    public boolean contains(T e) {
        for (int i = 0; i < size; i++) {
            if (data[i].equals(e)) {
                return true;
            }
        }
        return false;
    }

    // 获取对应元素的下标, 未找到，返回 -1
    public int find(T e) {
        for ( int i = 0; i < size; i++) {
            if (data[i].equals(e)) {
                return i;
            }
        }
        return -1;
    }


    // 在 index 位置，插入元素e, 时间复杂度 O(m+n)
    public void add(int index, T e) {
        checkIndex(index);
        // 如果当前元素个数等于数组容量，则将数组扩容为原来的2倍
        if (size == data.length) {
            resize(2 * data.length);
        }

        for (int i = size - 1; i >= index; i--) {
            data[i + 1] = data[i];
        }
        data[index] = e;
        size++;
    }

    // 向数组头插入元素
    public void addFirst(T e) {
        add(0, e);
    }

    // 向数组尾插入元素
    public void addLast(T e) {
        add(size, e);
    }

    // 删除 index 位置的元素，并返回
    public T remove(int index) {
        checkIndexForRemove(index);

        T ret = data[index];
        for (int i = index + 1; i < size; i++) {
            data[i - 1] = data[i];
        }
        size --;
        data[size] = null;

        // 缩容
        if (size == data.length / 4 && data.length / 2 != 0) {
            resize(data.length / 2);
        }

        return ret;
    }

    // 删除第一个元素
    public T removeFirst() {
        return remove(0);
    }

    // 删除末尾元素
    public T removeLast() {
        return remove(size - 1);
    }

    // 从数组中删除指定元素
    public void removeElement(T e) {
        int index = find(e);
        if (index != -1) {
            remove(index);
        }
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(String.format("Array size = %d, capacity = %d \n", size, data.length));
        builder.append('[');
        for (int i = 0; i < size; i++) {
            builder.append(data[i]);
            if (i != size - 1) {
                builder.append(", ");
            }
        }
        builder.append(']');
        return builder.toString();
    }


    // 扩容方法，时间复杂度 O(n)
    private void resize(int capacity) {
        T[] newData = (T[]) new Object[capacity];

        for (int i = 0; i < size; i++) {
            newData[i] = data[i];
        }
        data = newData;
    }

    private void checkIndex(int index) {
        if (index < 0 || index > size) {
            throw new IllegalArgumentException("Add failed! Require index >=0 and index <= size.");
        }
    }

    private void checkIndexForRemove(int index) {
        if(index < 0 || index >= size) {
            throw new IllegalArgumentException("remove failed! Require index >=0 and index < size.");
        }
    }
}
```

<hr />