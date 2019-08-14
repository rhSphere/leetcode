---
title: Scanner类的几个方法
tags: [java]
date: 2019-08-13 22:49:13
permalink: scanner
categories: Java
description:
---
<p class="description"></p>


<!-- more -->

## Scanner类的几个方法

通过Scanner类可以后去用户输入，创建Scanner对象的基本语法如下：

	Scanner sc = new Scanner(System.in);

System.in代表标准输入，即键盘输入，但这个标准输入流是 InputStream 类的实例，使用不太方便，而且键盘输入内容都是文本内容，所以可以使用 InputStreamReader 将其转换为字符输入流，普通的 Reader 读取输入内容依然不太方便，可以将普通的 Reader 再次包装成BufferedReader，利用 BufferedReader 的 readLine() 方法可以一次读取一行内容。

```java
public class KeyInTest {
    public static void main(String[] args) {
        try (InputStreamReader reader = new InputStreamReader(System.in);
        BufferedReader br = new BufferedReader(reader)) {
            String line = null;
            while ((line = br.readLine()) != null) {
                if (line.equals("exit"))
                    System.exit(1);
                System.out.println("输入内容为：" + line);
            }
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }
}
```

**nextInt()、next()和nextLine():**


nextInt(): it only reads the int value, nextInt() places the cursor（光标） in the same line after reading the input.
	nextInt()只读取数值，剩下”\n”还没有读取，并将cursor放在本行中。

next(): read the input only till the space. It can’t read two words separated by space. Also, next() places the cursor in the same line after reading the input.（next()只读空格之前的数据，并且cursor指向本行） 
　　next() 方法遇见第一个有效字符（非空格，非换行符）时，开始扫描，当遇见第一个分隔符或结束符(空格或换行符)时，结束扫描，获取扫描到的内容，即获得第一个扫描到的不含空格、换行符的单个字符串。

nextLine(): reads input including space between the words (that is, it reads till the end of line \n). Once the input is read, nextLine() positions the cursor in the next line. 
	nextLine()时，则可以扫描到一行内容并作为一个字符串而被获取到。


### 3

<hr />