---
title: SampleBrowser
tags: [Stack, SampleBrowser]
date: 2019-05-29 08:03:21
permalink: sample-browser
categories: Stack
description:
---
<p class="description"></p>


<!-- more -->

## 模拟实现浏览器的前进、后退功能 

浏览器的前进、后退功能。
每次一次访问完一串页面a-b-c后，点击浏览器的后退按钮，就可以查看之前浏览过的页面b和a。当你后退到页面a，点击前进按钮，就可以重新查看页面b和c。但是，如果你后退到页面b后，点击了新的页面d，那就无法再通过前进、头腿功能查看页面c了。

现在来实现这个功能，使用链式栈，用backStack、currentPage、forwardStack来存储这些页面。


### java代码
```java
**
 * @description: 使用前后栈实现浏览器的前进后退
 * @author: rhsphere
 * @since: 2019-05-28 19:55 by jdk 1.8
 */
public class SampleBrowser {
	public static void main(String[] args) {
		SampleBrowser browser = new SampleBrowser();
        browser.open("http://www.baidu.com");
        browser.open("http://news.baidu.com/");
        browser.open("http://news.baidu.com/end");
        browser.goBack();
        browser.goBack();
        browser.goForward();
        browser.open("http://www.qq.com");
        browser.goForward();
        browser.goBack();
        browser.goForward();
        browser.goBack();
        browser.goBack();
        browser.goBack();
        browser.goBack();
        browser.checkCurrentPage();
	}

	private String currentPage;
	private LinkedListBasedStack backStack;
	private LinkedListBasedStack forwardStack;

	public SampleBrowser() {
		this.bakcStack = new LinkedListBasedStack();
		this.forwardStack = new LinkedListBasedStack();
	}

	public void open(String url) {
		if (this.currentPage != null) {
			this.backStack.push(this.currentPage);
			this.forwardStack.clear();
		}
		showUrl(url, "Open");
	}
	public boolean canGoBack() {
		return this.backStack.size() > 0;
	}
	public boolean canGOForward() {
		return this.forwardStack.size() > 0;
	}

	public String goBack() {
		if (this.canGoBack()) {
			this.forwardStack.push(this.currentPage);
			String backUrl = this.backStack.pop();
			showUrl(backUrl, "Back");
			return backUrl;
		}
		System.out.println("* Cannot go back, no pages behind.");
		return null;
	}

	public String goForward() {
		if (this.canGoForward()) {
			this.backStack.push(this.currentPage);
			String forwardUrl = this.forwardStack.pop();
			showUrl(forwardUrl, "FOrward");
			return forwardUrl;
		}
		System.out.println("** Cannot go forward, no pages ahead.");
		return null;
	}
	public void showUrl(String url, String prefix) {
		this.currentPage = url;
		System.out.println(prefix + " page == " + url);
	}
	public void checkCurrentPage() {
		System.out.println("current Page is: " + this.currentPage);
	}

	/**
     * 基于链表的栈
     */
	public static class LinkedListBasedStack {
		private int size;
		private Node top;

		static Node createNode(String data, Node next) {
			return new Node(data, next);
		}
		public void clear() {
			this.top = top;
			this.size = 0;
		}
		public void push(String data) {
			Node node = createNode(data, this.top);
			this.top = top;
			this.size++;
		}
		public String pop() {
			Node popNode = this.top;
			if (popNode == null) {
				System.out.println("Stack is empty");
				return null;
			}
			this.top = popNode.next;
			if (this.size > ) 
				this.size--;
			return popNode.data;
		}
		public String getTopData() {
			if (this.top == null)
				return null;
			return this.top.data;
		}
		public int size() {
			return this.size;
		}
		public void print() {
			System.out.println("Print stack:");
			Node cur = this.top;
			while (cur != null) {
				String data = cur.getData();
				Sustem.out.println(data + "\t");
				cur = cur.next;
			}
			System.out.println();
		}



		public static class Node{
			private String data;
			private Node next;
			public Node(String data) {
				this(datam null);
			}
			public Node(String data, Node next) {
				this.data= data;
				this.next = next;
			}
			public void setData(String data) {
				this.data = data;
			}
			public String getData() {
				return this.data;
			}
			public void setNext(Node next) {
				this.next = next;
			}
			public Node getNext() {
				return this.next;
			}
		}
	}
}

```


<hr />