---
title: "Universality of Unix I/O: File Descriptor, Four Basic System Calls, lseek and File Hole"
date: 2024-03-21T16:27:53Z
draft: false
tags: ["System Programming"]
---

>"Files are a good place to start, since they are central to the UNIX philosophy." ([Kerrisk, 2010, p. 69](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=113&annotation=2G869CHC))

*File descriptor* are used by processes and threads for performing I/O operations, with processes opened by the *shell* inheriting *standard input*, *standard output*, and *standard error* by default. `open()`, `read()`, `write()`, and `close()` are key operations for files, with the kernel ensuring the portability and generality of these four system calls.

File access permissions not only depend on the *flags* passed to the `open()` system call but also on the *process umask* and the *default access control list* of the *parent directory*. The file descriptor returned by `open()` is the smallest available descriptor, crucial for implementing I/O redirection. If the opening fails, the return value is -1, and `errno` is set to the error code.

The `read()` and `write()` system calls do not allocate buffers for users nor do they append `'\0'` at the end of read strings. This is done to provide flexibility, generality, and speed.

The return of the `write()` system call does not guarantee that the data has been written to the disk. The kernel provides buffers to the disk to reduce disk activity and the number of disk writes, as disk I/O is significantly slower than the execution speed of write instructions.

After the program execution ends, file descriptors are automatically released. File descriptors are consumable resources, and long-lived programs such as servers or shells must close opened files after use.

`lseek()` is used to modify the *file offset* associated with the file descriptor, which is used to describe the starting position for the next read or write operation on the file. This system call does not generate actual I/O. The `l` in `lseek()` indicates that the return type is `long`.

*File hole* refers to the space between `EOF` and newly written bytes, where for a process, the file hole is occupied by bytes, and reading the file hole will return null bytes. Interestingly, the kernel does not allocate any `disk blocks` for file holes until actual data is written. The existence of file holes may cause the logical size of a file to be larger than its actual size, and writing to a file hole does not increase the file's logical size.

---

>“Files are a good place to start, since they are central to the UNIX philosophy.” ([Kerrisk, 2010, p. 69](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=113&annotation=2G869CHC))

*File descriptor*被进程和线程用于执行I/O操作，由*shell*打开的进程默认打开（继承）*standard input*，*standard output*和*standard error*。`open()`, `read()`, `write()`和`close()`是操作文件的关键，内核保证了这四个系统调用良好的移植性和泛用性。

打开文件的权限不仅取决于`open()`系统调用的*flag*，还取决于*process umask*和*parent directory*的*default access control list*。`open()`返回的文件描述符是可获取的最小文件描述符，这是I/O重定向得以实现的关键。如果打开失败，返回值为-1，且`errno`被设为错误码。

`read()`和`write()`系统调用不会为用户分配*buffer*，也不会在读到的字符串结尾添加`'\0'`，其目的是为了提供灵活性，泛用性和速度。

`write()`系统调用的返回不意味着数据真的被写入磁盘了，内核会给磁盘提供buffer以减少disk的activity和磁盘写的次数，磁盘的I/O显著地慢于写指令的执行速度。

程序结束执行后，file descriptor会被自动释放。File descriptor是consumable resource，常驻内存的程序（long-lived programs），比如服务器或shell必须在文件使用完毕后关闭打开的文件。

`lseek()`被用于修改文件描述符对应的*file offset*，该值被用于描述下一次对文件的读写的起始位置。该系统调用不会产生实际的I/O。`lseek()`的`l`表示返回值的类型是`long`。

*File hole*指`EOF`到新写入byte之间的space，对于进程来说，file hole由byte所占据，读file hole将返回null byte。有趣的是，kernel在有实际数据写之前，并不会为file hole分配任何`disk block`。File hole的存在导致文件的逻辑大小可能会大于实际大小，落在file hole上的文件写操作不会增加文件的逻辑大小。

## References

Kerrisk, Michael. The Linux Programming Interface: A Linux and UNIX System Programming Handbook. San Francisco: No Starch Press, 2010.
