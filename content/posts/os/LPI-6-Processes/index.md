---
title: "Program Layout and Process Memory Layout"
date: 2024-03-25T07:39:29Z
draft: false
tags: ["System Programming"]
---

### Program Layout

The essence of a *program* lies in files containing various information, which instruct the kernel on how to execute the file at *runtime*.
- Consideration: What is runtime? Do languages like Golang, C#.Net, and Java have a runtime? Does C/C++ have a runtime? What are the differences? What impacts does the presence or absence of a runtime have on program execution speed and memory usage?

*Binary format identification*: Metadata of the program guides the kernel in interpreting the program file. Among these, `a.out` and *elf* are commonly used formats. Executables compiled by the `gcc` compiler with the CLT generally default to `a.out`. The term `a.out` stands for assembler output. The latter, *elf*, stands for executable and linking format. If game projects intend to release on Sony platforms, they need to rely on Sony's SDK, and the compiled executable file is in *elf* format. *Elf* format files can be parsed using *readelf*.

*Machine-language instructions*: Machine instructions learned in architecture play a more significant role in expressing the program's algorithms.

*Program entry-point address*: The entry point of the program, determined by the `main` function in C/C++.

*Data*: Used for initializing variables and literals, such as C++ literals. Examples include C++ strings.

*Symbol and relocation tables*: This table contains the names and positions of symbols in the program. Besides being used for *runtime symbol resolution* to achieve dynamic linking, it's also used for debugging.

- Consideration: The Visual Assist (VA) Visual Studio plugin can help us quickly resolve symbols in the source code for querying. It's essential to note that VA doesn't perform searches by parsing the symbol table of executable files.

*Shared-library and dynamic-linking information*: The program file includes fields listing the **shared libraries** that the program needs to use at runtime and the **pathname of the dynamic linker** that should be used to load these libraries ([Kerrisk, 2010, p. 114](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=158&annotation=6TFJR6R4)).

On the Windows platform, we can use [Dependencies](https://github.com/lucasg/Dependencies) and [Dependency Walker](https://www.dependencywalker.com/) to analyze `.exe` or library files. The analyzer works by parsing the contents of this field. Analyzing dependencies and dynamic link libraries is crucial when assessing the feasibility of porting large projects.

### Process Memory Layout

The *memory layout* of a process describes the distribution of data in memory after the process is loaded into memory (usually through a *program loader*) on Unix platforms. We use *segments* or *sections* to describe these different memory layout partitions.

*Text segment*: Generally consists of *read-only instructions*, and to save memory, this data is globally shared by the OS through address mapping.

- Consideration: How does high-level language reflection, such as Java, bypass read-only restrictions? Is it through the runtime (JVM)? Does C++, which relies on kernel runtime, have reflection?

*Initialized data segment*: This segment generally contains **global and static variables** initialized in the program. The values for initialization are typically read from the *executable file* (mentioned earlier as the `data` segment); contrasting this is the *uninitialized data segment* (also known as *bss segment*, standing for block started by symbol). Here, the size and location of uninitialized variables are extracted from the executable file by the *program loader*. The reason for distinguishing between initialized and uninitialized areas is that these two types of variables are stored differently on disk (i.e., in the program file). The latter only needs to store size and location, without concerning values, so they need to be treated differently.

- Speculation: Is the data area used together with the symbol table to initialize the initialized data segment, where the symbol table is responsible for initializing the uninitialized data segment?

```c
int main()
{
    static int a = 3;       // initialized data segment
    static int b[100];      // uninitialized data segment
    // ...
}
```

*Stack*: A dynamically growing and shrinking segment. It is generally contiguous but is also divided into individual *stack frames* (akin to page frames in virtual memory). Typically, a *stack frame* is obtained for each function call. Function parameters, return values, and local variables (also known as automatic variables) are stored in the *stack frame*.

*Heap*: The heap is entirely used for runtime memory allocation, and the top end of the heap is called the *program break*.

On Linux, you can use the `size` command to view the sizes of various *sections* of a program. After reading the Memory layout chapter, it's easy to understand why the kernel is considered the runtime for C/C++. Additionally, some system calls use statically allocated positions, such as the initialized data segment and the uninitialized data segment, to return and record system call return values. Repeatedly calling this function will erase the previous system call return values.

The C compiler provides three global symbols (interfaces) for each program, `etext`, `edata`, and `end`, to help programmers access these data segments in the program.

---

*Program*的本质是含有各种信息的文件，用于告诉内核该如何于*runtime*执行文件。
- 思考：什么是runtime？Golang，C#.Net和Java这些语言有runtime吗，C/C++有runtime吗？有什么区别？有无runtime对程序的运行速度，内存占用有什么影响？

*Binary format identification*：程序的**metadata**，用于指导内核解释该程序文件。其中，`a.out`和*elf*是比较常用的格式。用*gcc*编译器通过CLT编译出来的可执行文件一般默认是`a.out`，`a.out`的含义是assembler output。后者*elf*表示executable and linking format，译为可编译可链接格式，游戏项目如果想要发布到索尼平台，需要依赖索尼的SDK，编译出的可执行文件就是*elf*格式的。*elf*格式的文件可以通过*readelf*进行解析。

*Machine-language instructions*：体系结构中学习的机器指令其作用更多的是对程序的算法表达。

*Program entry-point address*：程序入口，这个位置在C/C++中由main函数确定。

*Data*：用于初始化变量和字面量，比如C++的*literal*。典型的有C++的字符串。

*Symbol and relocation tables*：这张表包含了程序所含符号的名字以及位置，除了被用来*runtime symbol resolution*实现动态链接，**还被用于debug**。

- 思考：VA visual assist这个VS插件能帮助我们在源代码阶段快速解析程序的符号，进行查询。需要注意的是VA并不是通过解析可执行文件的符号表来进行检索的。

*Shared-library and dynamic-linking information*： The program file includes fields listing the **shared libraries** that the program needs to use at run time and the **pathname of the dynamic linker** that should be used to load these libraries.” ([Kerrisk, 2010, p. 114](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=158&annotation=6TFJR6R4))

在Windows平台上，我们可以使用[Dependencies](https://github.com/lucasg/Dependencies)和[Dependency Walker](https://www.dependencywalker.com/)对`.exe`或者库文件进行解析。解析器就是通过解析该字段的内容来工作的。在分析大型项目移植可行性的时候，对依赖和动态链接库的分析至关重要。

---

进程的*memory layout*描述了进程被加载到（一般是通过*program loader*）内存后在Unix平台上数据的分布形式。我们使用*segment*或者*section*来描述这些不同的内存layout分区。

*Text segement*一般为*read-only*的*instructions*，且为了节约内存，该部分数据会被OS通过地址映射的方式全局共享。

- 思考：高级语言的反射比如Java是如何越过只读限制的？是通过runtime（JVM虚拟机）吗？原生依赖内核runtime的C++有反射吗？

*Initialized data segment*：初始化数据区一般包含在程序中被初始化的**全局和静态变量**，用于初始化的值一般从*executable file*中读取（前文提到过的`data`段）；与之相对应的是*uninitialized data segement*（也被称为*bss segment*，意为block started by symbol），在这里未被初始化的变量的*size*与*location*被*program loader*从可执行文件中提取。区分已初始化和未初始化区的原因是这两种变量在磁盘上（也即程序文件中）的存储方式是不同的，后者只需要存储大小和位置，不需要关系值，所以需要区别对待。

- 猜测：Data区和symbol table一起用于初始化initialized data segment，symbol table负责初始化uninitialized data segement？

```c
int main()
{
    static int a = 3;       // initialized data segment
    static int b[100];      // uninitialized data segement
    // ...
}
```

*Stack*：一个动态缩放（*dynamically growing and shrinking segment*）的区。一般来说是连续的，但是也被分为一个一个*stack frame*（联想到虚拟内存的page frame），一般一个函数调用（*function call*）会获得一个*stack frame*。在*stack frame*中存放函数的参数，返回值，局部变量（又被称为自动变量*automatic variables*）。

*Heap*：堆区完全用于运行时的内存分配，堆的*top end*被叫做*program break*。

在Linux下，你可以使用`size`指令来查看程序各个*section*的大小。在读完Memory layout这一章后，不难理解为什么kernel会被认为是C/C++的runtime。此外，有些系统调用会通过initialized data segment和uninitialized data segment分区这些*statically allocated*位置来返回和记录系统调用的返回值。反复调用该函数会造成之前系统调用的返回值被抹去。

C编译器会给每个程序提供三个全局符号（接口），`etext`，`edata`和`end`，用于帮助程序员在程序中对这些数据段进行访问。

## References

Kerrisk, Michael. The Linux Programming Interface: A Linux and UNIX System Programming Handbook. San Francisco: No Starch Press, 2010.