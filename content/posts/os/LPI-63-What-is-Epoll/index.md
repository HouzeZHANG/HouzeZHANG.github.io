---
title: "What is Epoll"
date: 2024-03-29T13:51:21Z
draft: true
tags: ["System Programming", "select/poll/epoll"]
---

https://mp.weixin.qq.com/s/GoYDsfy9m0wRoXi_NCfCmg

从性能上来说`epoll`和信号驱动I/O是类似的，但`epoll`的特点是省去了繁杂的信号编程，且同时支持边沿触发和层级触发机制。和`select`，`poll`相比，`epoll`的scalability要远好于前两者，且额外支持边沿触发。

内核在程序执行期间会维护一套数据结构，被称为*epoll instance*，包含两张列表，*interest list*与*ready list*，前者记录了所有被检控的文件描述符，后者维护准备好I/O的文件描述符。对于每一个文件描述符，我们都可以指定不同的*bit mask*来进行监控。$$ Ready\_list \in Interest\_list $$



## References