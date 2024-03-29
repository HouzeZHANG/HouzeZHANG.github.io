---
title: "IO Multiplexing"
date: 2024-03-29T07:45:27Z
draft: true        
tags: ["System Programming", "select/poll/epoll"]
---

对disk file的读写会涉及buffer

两个核心思想
- check without blocking
- check any of them

poll的思想是周期性地扫描table，这一技术的支持基于非阻塞I/O。一方面，poll的性能会因为扫描用时的过长，导致app响应I/O event的latency急剧下降。而过于频繁地进行polling（performing a nonblocking check on the status of a file descriptor）会waste CPU time。

在我们只有阻塞systemIO的时候，我们可以使用**多线程和多进程**来实现所谓的**非阻塞I/O**。现实中我们往往会选择使用线程池（在没有类似于go或者C++协程的情况下）：当客户机尝试连接的时候，主线程创建子进程或者子线程来接管该socket。这么做的缺点是连接数量受限（最大进程数和最大线程数的存在，服务器的资源消耗，这在云服务器时代尤为需要考虑，消耗更多的资源意味着服务器开销越大），而且线程IPC/进程间通信与同步会带来额外的编程复杂度。在某些特殊场景下，并发编程模型可以让子进程或者线程执行额外的阻塞操作。

以上问题的解决方案有四：I/O multiplexing, signal-driven I/O, 大名鼎鼎的epoll，以及异步I/O，AIO。

“In effect, I/O multiplexing, signal-driven I/O, and epoll are all methods of achieving the same result—monitoring one or, commonly, several file descriptors simultaneously to see if they are ready to perform I/O (to be precise, to see whether an I/O system call could be performed without blocking).” ([Kerrisk, 2010, p. 1327](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=1371&annotation=XSVITFRA)) [1] 这段话太经典了。

在2010年的时候，作者认为epoll比信号驱动I/O好用，因为epoll不需要处理信号编程，且epoll支持不同的触发方式。想要完全释放linux平台下的信号驱动I/O性能会让程序高度依赖linux平台，因为信号编程涉及系统调用，这不会让程序的移植性更好。但总之专门为I/O事件的监听编写抽象层是一个好方法，因为这尽可能地解决了软件移植性的问题。

## References

[1] Kerrisk, Michael. The Linux Programming Interface: A Linux and UNIX System Programming Handbook. San Francisco: No Starch Press, 2010.
