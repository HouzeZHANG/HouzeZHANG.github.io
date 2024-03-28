---
title: "LPI 6 VM"
date: 2024-03-28T09:46:26Z
draft: true
tags: ["default"]
---
s
### Virtual Memory

*Resident set*：驻扎在memory page frame中的进程页。*Swap area*：未被使用的程序虚存的页，被存储在磁盘的交换区域上。这是一组相对的概念。访问*Swap area*的页会造成*page default*（这是缺页错误的另一种理解）。

通过`sysconf(_SC_PAGESIZE)`进程甚至能改变OS的虚存页的大小。

![alt text](/processVMLayout.png)

## References