---
title: 剑指Offer(9) 用两个栈实现队列
tags: [Queue]
date: 2019-03-29 23:18:53
permalink: queue-with-two-stacks
categories: 剑指Offer
description:
---
<p class="description">用两个栈实现一个队列。队列的声明如下，请实现它的两个函数appendTail和deleteHead，分别完成在队列尾部插入结点和在队列头部删除结点的功能。</p>


<!-- more -->

## 实现法一 
**思路：**
插入删除的过程（在草稿纸上动手画一下）：插入肯定是往一个栈stack1中一直插入；删除时，直接出栈无法实现队列的先进先出规则，这时需要将元素从stack1出栈，压到另一个栈stack2中，然后再从stack2中出栈就OK了。 需要稍微注意的是：当stack2中还有元素，stack1中的元素不能压进来；当stack2中没元素时，stack1中的所有元素都必须压入stack2中。否则顺序就会被打乱。

**测试用例：**
1. 往空队列添加、删除元素
2. 往非空队列里添加、删除元素
3. 连续删除元素至队列为空

### 完整代码

```java 用两个栈实现队列
import java.util.Stack;

public class QueueWithStacks {
    class Queue {
        Stack<Integer> stack1 = new Stack<>();
        Stack<Integer> stack2 = new Stack<>();

        /**
         * 插入节点
         */
        public void push(int node) {
            stack1.push(node);
        }

        /**
         * 删除节点
         */
        public int pop() {
            if (stack2.empty()) {
                if (stack1.empty()) {
                    throw new RuntimeException("队列为空");
                } else {
                    while (!stack1.empty())
                        stack2.push(stack1.pop());
                }
            }
            return stack2.pop();
        }
    }

    // =======测试代码==========
    public void test1() {
        Queue queue = new Queue();
        queue.push(1);
        queue.push(2);
        System.out.println(queue.pop());
        queue.push(3);
        System.out.println(queue.pop());
        System.out.println(queue.pop());
    }

    /**
     * 往空队列删除元素
     */
    public void test2() {
        Queue queue = new Queue();
        System.out.println(queue.pop());
    }

    public static void main(String[] args) {
        QueueWithStacks demo = new QueueWithStacks();
        demo.test1();
        // demo.test2();
    }
}
```


## 实现法二
**思路：**
队列和栈的主要区别在于元素进出顺序，因此，需要修改peek()和pop()，以相反的顺序执行。
利用第二个栈反转元素的次序（弹出s1的元素，压入s2）。在这种实现中，每当执行peek()和pop()操作时，就要将s1的所有元素弹出，压入s2中，然后执行peek()和pop()操作，再将元素压入s1.

但是若连续执行两次peek()和pop()操作，那么，所有元素移来移去，重复移动。 可以延迟元素的移动，即让元素一直留在s2中，只有必须反转元素次序是才移动元素。

stackNewest顶端为最新元素，stackOldest顶端为最旧元素。在将一个元素出列是，我们希望先移除最旧元素，因此先将元素从stackOldest将元素出列。若stackOldest为空，在将stackNewest中所有元素以相反的顺序移到stackOldest中。如果要插入元素，就将其压入stackNewest，因为最新元素位于它的顶端。

```java 用两个栈实现一个队列
import java.util.Stack;

public class MyQueue<T> {
    Stack<T> stackNewest, stackOldest;

    public MyQueue() {
        stackNewest = new Stack<>();
        stackOldest = new Stack<>();
    }
    public int size() {
        return stackNewest.size() + stackOldest.size();
    }

    public void add(T val) {
        stackNewest.push(val);
    }

    private void shiftStacks() {
        if (stackOldest.isEmpty()) {
            while (!stackNewest.isEmpty()) {
                stackOldest.push(stackNewest.pop());
            }
        }
    }

    public T peek() {
        shiftStacks();
        return stackOldest.peek();
    }

    public T remove() {
        shiftStacks();
        return stackOldest.pop();
    }
}
```


<hr />