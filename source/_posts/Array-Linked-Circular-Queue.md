---
title: Array && Linked && Circular Queue
tags: [ArrayQueue, LinkedQueue, CircularQueue, Queue]
date: 2019-05-31 07:51:06
permalink: array-linked-circular-queue
categories: Sum-up
description:
---
<p class="description"></p>


<!-- more -->

## 队列

队列跟栈一样，也是操作受限的线性表结构。 队列最基本的操作也是两个：**入队enqueue()，放一个数据到队列尾部；**出队dequeue()，从队列头部取一个元素。**

队列的应用非常广泛，特别是一些具有某些额外特性的队列，比如循环队列、阻塞队列、并发队列。他们在很多偏底层系统、框架、中间件的开发中，骑着关键性的作用。比如高性能队列Disruptor、Linux环形缓存，都用到了循环并发队列；Java concurrent并发包利用ArrayBlockingQueue来实现公平锁等。


实际的项目，不可能从零实现一个队列，甚至都不会直接用到。而具有特殊特性的队列应用却比较广泛，比如阻塞队列和并发队列。

**阻塞队列**其实就是在队列基础上增加了阻塞操作。简单来说，就是在队列为空的时候，从队头取数据会被阻塞。因为此时还没有数据可取，直到队列中有了数据才能返回；如果队列已经满了，那么插入数据的操作就会被阻塞，知道队列中有空闲位置后再插入数据，然后再返回。

线程安全的队列叫做 **并发队列**，对简单直接的实现方式就是直接在enqueue()、dequeue()方法上加锁，但是锁粒度大并发度会比较低，同一时刻仅允许一个存或者取操所。实际上，基于数组的循环队列，利用CAS原子操作，可以实现非常高效的并发队列。

这也是循环队列比链式队列应用更加广泛的原因。

### 线程池队列的策略
线程池没有空闲线程时，新的任务请求线程资源是，线程池该如何处理?这种处理策略又是如何实现的呢？

一半有两种处理策略。第一种是非阻塞的处理方式，直接拒绝任务请求；另一种是阻塞的处理方式，将请求排队，等到有空闲线程时，去除排队的请求继续处理。

基于链表的实现方式，可以实现一个支持无限排队的无界队列，但是可能会导致过多的请求队列等待，请求处理的相应时间过长。所以，针对响应时间比较敏感的系统，基于链表实现的无限排队的线程池是不合适的。

而基于数组实现的有界队列，队列的大小有限，所以线程池中排队的请求超过队列大小时，接下来的请求就会被拒绝，这种方式对响应时间敏感的系统来说，就像对更加合理。

分布式应用中的消息队列，也是一种队列结构。
考虑使用CAS实现无锁队列，在入队前，获取tail位置，入队是比较tail是否发生变化，如果否，则允许入队，反之，本次入队失败，出队则是获取head位置，进行cas。



##  顺序队列
对于队列，需要两个指针：一个是head指针，指向对头；一个是tail指针，指向队尾。随着不停地进行入队、出队操作，head和tail都会持续往后移动。当tail移动到最右边，即使数组中还有空闲空间，也无法继续往队列中添加数据了。
一种方法是，对于入队enqueue()，进行判断队列末尾是否有空间，然后将数据整体搬移一次。

```java
public boolean enqueue(String item) {
	if (tail == n) {
		if (head == 0)
			return false;
		for (int i = head; i < tail; i++) {
			items[i - head] = items[i];
		}
		tail -= head;
		head = 0;
	}
	items[tail] = item;
	tail++;
	return true;
}
```


### 顺序队列实现

```java
/**
 * @description: 用数组实现的动态扩容顺序队列
 * @author: rhsphere
 * @since: 2019-05-30 20:53 by jdk 1.8
 */

public class ArrayQueue<E> implements Iterable<E> {
	private E[] q;
	private int n;
	private int head;
	private int tail;

	public ArrayQueu() {
		q = (E[]) new Object[2];
		n = 0;
		head = 0;
		tail = 0;
	}

	public boolean isEmpty() {
		return n == 0;
	}

	public int size() {
		return n;
	}

	public void resize(int capacity) {
		assert capacity > 0;
		E[] tmp = (E[]) new Object[capacity];
		for (int i = 0; i < n; i++)
			tmp[i] = q[(head + i) % q.length];
		q = tmp;
		head = 0;
		tail = n;
	}

	public void enqueue(E e) {
		if (n == q.length) 
			resize(2 * q.length);
		q[tail++] = e;
		if (tail == q.length)
			tail = 0;
		n++;
	}

	public E dequeue() {
		if (isEmpty()) {
			throw new NoSuchElementException("Queue underflow");
		}
		E e = q[head];
		q[head] = null;
		n--;
		head++;
		if (head == q.length)
			head = 0;
		if (n > 0 && n == q.length / 4)
			resize(q.length / 2);
		return e;
	}

	public E peek() {
		if (isEmpty())
			throw new NoSuchElementException("Queue underflow");
		return q[head];
	}

	public Iterator<E> iterator() {
		return new ArrayIterator();
	}

	private class ArrayIterator implements Iterator<E> {
		private int i = 0;
		public boolean hasNext() {
			return i < n;
		}
		public void remove() {
			throw new UnsupportedOperationException();
		}
		public E next() {
			if (!hasNext())
				throw new NoSuchElementException();

			E e = q[(i + head) % q.length];
			i++;
			return e;
		}
	}
}

```





## 链式队列
基于链表的实现，同样需要两个指针：head指针和tail指针。分别指向链表的第一个节点和最后一个节点。入队时，tail.next = newNode, tail = tail.next; 出队时，head = head.next;

```java
/**
 * @description: 链式队列
 * @author: rhsphere
 * @since: 2019-05-30 22:11 by jdk 1.8
 */

pubilc class LinkedQueue<E> implements Iterable<E> {
	private Node<E> head;
	private Node<E> tail;
	private int n;

	private static class Node<E> {
		private E e;
		private Node<E> next;
	}

	public LinkedQueue() {
		head = null;
		tail = null;
		n = 0;
	}
	public boolean isEmpty() {
		return head == null;
	}
	public int size() {
		return n;
	}
	public E peek() {
		if (isEmpty())
			throw new NoSuchElementException("Queue underfolw");
		return head.e;
	}

	public void enqueue(E e) {
		Node<E> oldtail = tail;
		tail = new Node<E>();
		tail.e = e;
		tail.next = null;
		if (isEmpty()) {
			head = tail;
		} else {
			oldtail.next = tail;
		}
		n++;
	}

	public E dequeue() {
		if (isEmpty()) {
			throw new NoSuchElementException("Queue underflow");
		}
		E e = head.e;
		head = head.next;
		n--;
		if (isEmpty())
			tail = null;
		return e;
	}

	pulbic String toString() {
		StringBuilder sb = new StringBuilder();
		for (E e : this) {
			sb.append(e);
			sb.append(' ');
		}
		return sb.toString();
	}

	public Iterator<E> iterator() {
		return new ListIterator<E>(head);
	}

	private class ListIterator<E> implements Iterator<E> {
		private Node<E> cur;

		public ListIterator(Node<E> head) {
			this.cur = head;
		}
		public boolean hasNext() {
			return cur != null;
		}
		public E remove() {
			throw new UnsupportedOperationException();
		}
		public E next() {
			if (!hasNext())
				throw new NoSuchElementException();
			E e = cur.e;
			cur = cur.next;
			return e;
		}
	}
}
```



## 循环队列
在用数组实现队列的时候，在tail=n时，会有数据搬移，这样入队操作性能就会受到影响。

循环队列最关键的是，确定好队空和队满的判定条件。 

对于数组实现的非循环队列中，队满的判断条件是tail == n，队空的判断条件时head == tail。
针对循环队列，队空的判断条件是head == tail。但是队满的判断条件是 ** （tail + 1) % n == head **。

队满时tail指向的位置实际上是没有存储数据的，所有，循环队列会浪费一个数组空间。

```java
/**
 * @description: 循环队列
 * @author: rhsphere
 * @since: 2019-05-30 22:42 by jdk 1.8
 */
public class CircularQueue<E> {
	private E[] q;
	private int n = 0;
	private int head = 0;
	private int tail = 0;

	public CircularQueue(int capacity) {
		q = (E[]) new Object[capacity];
		n = capacity;
	}

	public boolean enqueue(E e) {
		if ((tail + 1) % n == head)
			return false;
		q[tail] = e;
		tail = (tail + 1) % n;
		return true;
	}

	public E dequeu() {
		if (head == tail)
			return null;
		E res = q[head];
		head = (head + 1) % n;
		return res;
	}
}


```


## 测试LinkedQueue和ArrayQueue

```java
package Queue;

/**
 * @description: 测试顺序队列和链式队列
 * @author: rhsphere
 * @since: 2019-05-30 22:02 by jdk 1.8
 */
public class TestQueue {
    public static void main(String[] args) {
        System.out.println("==========测试ArrayQueue===============");
        ArrayQueue<String> arrayQueue = new ArrayQueue<>();
        arrayQueue.enqueue("Hello, ");
        arrayQueue.enqueue("world! ");
        arrayQueue.enqueue("You, ");
        arrayQueue.enqueue("there.");
        for (String s : arrayQueue)
            System.out.print(s);
        System.out.println();

        while (!arrayQueue.isEmpty()) {
            System.out.print(arrayQueue.dequeue());
        }

        System.out.println("\n(" + arrayQueue.size() + " left on array queue) ");
        System.out.println("=========结束测试============");

        System.out.println("==========测试LinkedQueue==============");
       LinkedQueue<Integer> linkedQueue = new LinkedQueue<>();

       linkedQueue.enqueue(1);
       linkedQueue.enqueue(3);
       linkedQueue.enqueue(5);
       linkedQueue.enqueue(7);
       linkedQueue.enqueue(9);
        for (Integer i : linkedQueue)
            System.out.print(i + " ");
        System.out.println();

        while (!linkedQueue.isEmpty()) {
            System.out.print(linkedQueue.dequeue() + " ");
        }

        System.out.println("\n(" + linkedQueue.size() + " left on linked queue) ");
        System.out.println("=========结束测试============");
    }
}
```


<hr />