---
title: 剑指Offer(10) 斐波那契数列及青蛙跳台阶问题
tags: [fibonacci]
date: 2019-04-16 14:46:10
permalink: fibonacci
categories: 剑指Offer
description:
---
<p class="description"></p>


<!-- more -->

# 递归和循环
如果我们需要重复地多次计算相同的问题，则通常可以选择用递归或循环两种不同的方法。 递归就是把问题层层分解，直到程序出口处。而循环则是通过设置计算的初始值及终止条件，在一个范围内重复运算。


递归虽然有简洁的优点，但它同时也有显著的缺点。递归由于是函数调用自身，而函数调用是有时间和空间的消耗的：每一次函数调用，都需要在内存栈中分配空间以保存参数、返回地址及临时变量，而且往栈里压入数据和弹出数据都需要时间。
另外，递归中有可能很多计算都是重复的，从而对性能带来很大的负面影响。递归的本质是把一个问题分解成两个或者多个小问题。如果多个小问题存在相互重叠的部分，就存在重复的计算。

通常应用动态规划解决问题时，我们都是用递归的思路分析问题，但由于递归分解的子问题中存在大量的重复，因此我们总是用自上而下的循环来实现代码。

除了效率，递归还有可能引起更严重的问题：调用栈溢出。每一次函数调用在内存栈中分配空间，而每个进程的栈的容量是有限的。当递归调用层级太多时，就会超出栈的容量，从而导致调用栈溢出。


# 斐波那契数列

## 思路
如果直接写递归函数，由于会出现很多重复计算，效率非常底，不采用。

要避免重复计算，采用从下往上计算，可以把计算过了的保存起来，下次要计算时就不必重复计算了：先由f(0)和f(1)计算f(2)，再由f(1)和f(2)计算f(3)……以此类推就行了，计算第n个时，只要保存第n-1和第n-2项就可以了。

## 测试用例

1. 功能测试（3，5，8等）
2. 边界值测试（0，1，2等）
3. 性能测试（50，100等）
4. 特殊（负数）

### Java代码

时间复杂度为O(n)

```java
public class Fibonacci {
	public long Fib(long n) {
		if (n < 0)
			throw new RuntimeException("下标错误，应从0开始！");
		if (n == 0)
			return 0;
		if (n == 1)
			return 1;
		long prePre = 0;
		long pre = 1;
		long result = 1;
		for (long i = 2; i <= n; i++) {
			result = prePre + pre;
			prePre = pre;
			pre = result;
		}
		return result;
	}

	// 附：缩略版（考虑到代码的可读性，其实还是上面的方法比较好）

	public long Fib2(long n) {
		if (n < 0)
			throw new RuntimeException("下标错误，应从0开始！");
		if (n == 0)
			return 0;
		if (n == 1)
			return 1;
		long pre = 0;
		long result = 1;
		for (long i = 2; i <= n; i++) {
			result += pre;
			pre = result - pre;
		}
		return result;
	}

	public static void main(String[] args) {
		Fibonacci demo = new Fibonacci();
		System.out.println(demo.Fib(0));
		System.out.println(demo.Fib(1));
		System.out.println(demo.Fib(2));
		System.out.println(demo.Fib(8));
		System.out.println(demo.Fib(50));
		System.out.println(demo.Fib(100));
		System.out.println(demo.Fib(-5));
	}
}
```


## 牛客网提交
``` java  
public class Solution {
    public int Fibonacci(int n) {
        int[] result = {0, 1};
        if (n < 2)
            return result[n];
        int fib1 = 0;
        int fib2 = 1;
        int fibN = 0;
        for (int i = 2; i <=n; i++) {
            fibN = fib1 + fib2;
            fib1 = fib2;
            fib2 = fibN;
        }
        return fibN;
    }
}
```


# 青蛙跳台阶问题

## 题目1
一只青蛙一次可以跳上1级台阶，也可以跳上2级。求该青蛙跳上一个n级的台阶总共有多少种跳法。

　　将跳法总数记为f(n)，可以知道f(1)=1，f(2)=2。
当n>2时，第一次跳1级的话，还有f(n-1)种跳法；第一次跳2级的话，还有f(n-2)种跳法，所以可以推得f(n)=f(n-1)+f(n-2)，即为斐波那契数列。


## 题目2
一只青蛙一次可以跳上1级台阶，也可以跳上2级……它也可以跳上n级。求该青蛙跳上一个n级的台阶总共有多少种跳法。

解法1：

　　当n=1时，f(1)=1。

　　当n大于1时，归纳总结可知：跳上n级台阶，第一次跳1级的话，有f(n-1)种方法；第一次跳2级的话，有f(n-2)种方法……第一次跳n-1级的话，有f(1)种方法；直接跳n级的话，有1种方法，所以可以得到如下公式：

　　f(n) = f(n-1)+f(n-2)+......f(1)+1　　（n≥2）

　　f(n-1) = f(n-2)+f(n-3)+.....f(1)+1　　（n>2）

　　由上面两式相减可得，f(n)-f(n-1)=f(n-1)，即f(n) = 2*f(n-1)  (n>2)

　　最终结合f(1)和f(2)，可以推得：f(n)=2^(n-1)

解法2：

　　假设跳到第n级总共需要k次，说明要在中间n-1级台阶中选出任意k-1个台阶，即C(n-1,k-1)种方法。

　　所以：跳1次就跳上n级台阶，需要C(n-1,0)种方法；跳2次需要C(n-1,1)种方法……跳n次需要C(n-1,n-1)种方法

　　总共需要跳C(n-1,0)+C(n-1,1)+C(n-1,2)+……C(n-1,n-1)=2^(n-1)种方法。

解法3：

　　除了必须到达最后一级台阶，第1级到第n-1级台阶都可以有选择的跳，也就是说对于这n-1个台阶来说，每个台阶都有跳上和不跳上2种情况，所以一共有2^(n-1)种方法。


# 矩形覆盖问题
## 题目
用n个2 · 1的小矩形无重叠地覆盖一个2 · n的大矩形，总共有多少种方法？

当n = 1时，有一种方法。

当n = 2时，有两种方法。

当n >= 3时，和斐波那契数列类似。第一步竖着放，有f(n-1)种方法；第一步横着放，有f(n-2)种方法。所以f(n)=f(n-1)+f(n-2)。


## 总结

1. 求n次方时，可以利用递归来降低时间复杂度

2. 当遇到涉及n的问题时（类似青蛙跳台阶问题），不要紧张，可以进行归纳分析，特别注意f(n)与f(n-1)、f(n-2)等的关联，从而找出规律，进行合理建模。

3. return (int)Math.pow(2,target-1);

　　1) 转int类型



<hr />