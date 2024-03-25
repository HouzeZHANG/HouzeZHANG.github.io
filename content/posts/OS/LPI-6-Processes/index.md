---
title: "LPI 6 Processes"
date: 2024-03-25T07:39:29Z
draft: true
tags: ["default"]
---

### Programs Information

*Program*的本质是含有各种信息的文件，用于告诉内核该如何于*runtime*执行文件。

*Binary format identification*：程序的metadata，用于告诉内核该如何解释这个文件。其中`a.out`和*elf*都是比较著名的格式。用*gcc*编译器通过CLT编译出来的可执行文件一般默认就是`a.out`，其含义是assembler output。后者*elf*表示executable and linking format，译为可编译可链接格式，项目通过索尼SDK编译出的可执行文件就是*elf*格式的。*elf*格式的文件可以通过*readelf*进行解析。

*Machine-language instructions*：体系结构中学习的机器指令其作用更多的是对程序的算法表达。

*Program entry-point address*：程序入口，这个位置在C/C++中由main函数确定

### Process Memory Layout

进程的*memory layout*是一个有趣的主题，它描述了进程被加载到（一般是通过*program loader*）内存后其数据的分布形式。

*Text segement*一般为*read-only*的*instructions*，且为了节约内存，该部分数据会被OS通过地址映射的方式全局共享。

*Initialized data segment*初始化数据区一般包含在程序中被初始化的全局和静态变量，用于初始化的值一般从*executable file*中读取；与之相对应的是*uninitialized data segement*（也被称为*bss segment*，意为block started by symbol），在这里未被初始化的变量的*size*与*location*被*program loader*从可执行文件中提取。区分已初始化和未初始化区的原因是这两种变量在磁盘上的存储方式是不同的，后者只需要存储大小和位置，不需要关系值，所以需要区别对待。

*Stack*是一个动态缩放（*dynamically growing and shrinking segment*）的区。一般来说是连续的，但是也被分为一个一个*stack frame*，一般一个函数调用（*function call*）会获得一个*stack frame*。在*stack frame*中存放函数的参数，返回值，局部变量（又被称为自动变量*automatic variables*）。

*Heap*堆区完全用于运行时的内存分配，堆的*top end*被叫做*program break*。

在Linux下，你可以使用`size`指令来查看程序各个*section*的大小。
## References