---
title: "X Compile"
date: 2024-05-05T13:20:33+02:00
draft: false
---

中文在下面👇

## Introduction

For the past few weeks, I've been diving into cross-compilation. It's been a great learning experience as I get to understand the differences between various operating systems and compilers. Here, I'm documenting some of the things I've learned.

The idea behind cross-compilation is to compile programs on a *host machine* that can run natively on a *target machine*. This technique is quite common in the gaming industry, where game clients often need to run in different environments, yet for development management purposes, the development environment tends to remain consistent.

## Clang, a Native Cross-compiler

Thanks to LLVM-Clang's excellent frontend-backend separation, Clang naturally serves as a cross-compiler. By passing the necessary compilation and linking information to Clang through options, it can easily generate code for the target platform. So, what information does the compiler/linker need to successfully cross-compile? Firstly, the compiler needs to know the architecture information of the target platform, which we call the *target triplet*. This information helps Clang initiate the correct compiler backend and a series of specific target platform configurations (such as dynamic linker paths, file extensions for generated programs, etc.). Secondly, the compiler needs to know the *root path* of the compilation environment, where the necessary compilation environment for generating programs (like a customized C++ standard library for the target platform) is installed. In some cases, you may also need to control the linker, such as specifying the linker (e.g., lld instead of ld) or informing the linker of library file search paths, and so on. All of these operations can be configured through Clang's options.

## Setting up the Compilation Environment

When there are no vendor-provided packages for cross-compilation environments, setting up a Linux compilation environment on Windows can be quite challenging. I've tried copying library files from the WSL2 filesystem to the Windows platform, which is not a good idea, especially if your WSL2 volume is large, as you'll find many unnecessary files like drivers there. It's also not advisable to directly pass the WSL2 root directory's address in the Windows host file system because Linux symbolic links cannot be recognized by the Windows file system and compilers on Windows. This not only complicates environment setup but also increases the coupling between the WSL2 environment and the compilation environment on the host machine. Trying environments like Cygwin or MSYS2 is counterproductive because they are designed to help compile native Windows software, not cross-compile to Linux.

When dealing with a small dependency tree for the software to be compiled, using a Docker image to set up the compilation environment is a good choice. A Docker image provides a clean Linux environment where you can install a set of packages to configure the minimal compilation environment. After setting up, using `docker cp` makes it easy to copy files between the host machine and the container. For a large number of files, maintaining the environment might benefit from more efficient commands like `rsync`, which supports incremental copying. The files copied to the Windows host machine are not directly usable due to broken symbolic links, which are widely used in Linux for library management. One workaround is to manually update these broken symbolic link files by identifying the underlying real library files with the help of linker error messages. If you're skilled enough, you can automate this process using PowerShell scripts, which can also be accomplished in a Docker container through a bash shell script.

## An Interlude on Dynamic Linkers

During debugging, I noticed that Clang's output logs also include linker invocation logs. In the linker's `-dynamic linker` option, you can see that after the compiler knows your target triplet, it informs the linker program about the dynamic linker path needed at runtime. I don't know the specific implementation details of the linker, but this path seems to be hardcoded into the packaged program. Initially, I thought this was abnormal; I believed that runtime dynamic linker information would be provided by the target environment's runtime after the program is loaded into memory, as this design would offer more flexibility. However, it seems that the dynamic linker's address is indeed specified during the linking phase, which is an interesting discovery. To analyze this issue further, I even posted a thread on the Stack Overflow forum.

## Cross-Compiling with CMake

Introducing build systems like CMake aims to systemize and formalize the compilation and linking process, making it easier for system programmers to maintain. The first step is to translate the aforementioned options into CMake commands. CMake has its own toolchain test detection mechanism. When executing, CMake performs a series of environment checks and compilation tests before actual compilation. A tricky aspect is that in CMake, the linker configuration used in this step is isolated from Clang's linker configuration, which can cause CMake to still choose ld as the linker even if you've configured Clang to use lld. No matter what attempts you make, you may not pass CMake's toolchain test. The solution is to set the global linker configuration in CMake to lld so that CMake passes the toolchain test. A more brute-force approach is to force CMake to perform the actual compilation task even if it fails the toolchain test.

## Verification

To verify that the generated program is indeed specific to the target platform, a rigorous method is to use the `file` command in Linux to analyze the executable. Don't assume that executable files in WSL2 can run successfully as an indication of successful cross-compilation because WSL2 can execute Windows `.exe` files (this can be quite tricky).

## Conclusion

Cross-compilation is full of challenges. There isn't much information available online; true understanding comes from a combination of thinking and practical experience. Along the way, my understanding of C++ compilation and linking has elevated.

## 简介

过去几周，我一直在尝试交叉编译。这是一个很好的学习机会，因为我可以了解到不同的操作系统和编译器之间的差异。我在这里记录一些我学到的东西。

交叉编译技术的思想是在*host machine*上编译能直接在*target machine*上原生运行的程序。这种技术在游戏产业中非常常见，因为游戏的客户端往往需要在不同的环境中运行，而为了便于开发管理，开发环境往往是一样的。

## Clang，一个native Cross Compiler

得益于LLVM-Clang优秀的前后端分离设计，Clang是天然的交叉编译器。只需在option中传入Clang所需要的编译链接信息，Clang便能轻松生成目标平台代码。那么，编译器/链接器需要哪些信息才能顺利完成交叉编译呢？首先，编译器需要知道目标平台的架构信息，我们称之为*target triplet*。关于目标平台架构的信息将帮助Clang启动正确的编译器后端，以及一系列特定的目标平台配置（比如dynamic linker路径，生成程序的扩展名。。。）。其次，编译器还需要知道编译环境的*root path*，这里安装了生成程序所需要的编译环境（比如目标平台定制的C++标准库文件）。在特殊情况下，你还需要控制链接器，比如指定链接器（lld而不是ld），告诉链接器库文件的搜索路径等等。这些操作均可以通过Clang的option进行设置。

## 编译环境配置

在没有供应商提供交叉编译环境安装包时，自己在Windows下配置Linux的编译环境是一个不小的挑战。我尝试过从WSL2文件系统中拷贝库文件至Windows平台。这不是一个好主意，尤其是在你的WSL2体积过大的情况，你会在其中发现很多没用的多余文件，比如driver。最好也不要直接传递WSL2根目录在Windows宿主机文件系统中的地址，因为Linux的符号链接无法被Windows文件系统以及Windows下的编译器成功识别，这不但不会简化环境配置，还会加重WSL2环境和宿主机上编译环境的耦合度。尝试使用*Cygwin*，*MSYS2*等环境更是南辕北辙，因为这些平台的目的设计初衷是帮助编译原生的Windows软件，而不是交叉编译至Linux。

在需要编译的软件的依赖树不大的时候，使用*docker image*来配置编译环境是一个不错的选择。docker image给了我们一个简洁的Linux环境，在其上安装一系列pkg以配置最小编译环境后，使用`docker cp`指令可以方便地在宿主机和容器之间拷贝文件。在文件数量庞大时，维护环境也许可以选择`rsync`等支持增量复制的效率更高的指令。拷贝至Windows宿主机的文件是不可用的，因为其中的符号链接文件均被破坏了，我们知道符号链接被广泛用于Linux下的库文件管理。一个解决方法是手动拷贝更新这些被破坏的库文件符号链接，在链接器报错信息帮助下，耐心地替换这些符号链接为underlying的真实库文件。如果你技高一筹，你可以尝试使用ps脚本自动化这个操作，这步操作也可以在docker container中通过bash shell脚本完成。

## 动态链接器小插曲

在debug的时候，我发现Clang的输出日志中也会包含链接器的调用日志。在链接器的`-dynamic linker`选项中，你可以看见编译器在得知你的target triplet是什么后，会告知链接器程序在运行时所需要的链接器路径。我不知道链接器的具体实现细节，这个路径似乎会被写死在打包好的程序中。我一开始认为这是不正常的，我以为运行时动态链接器的信息会在程序被加载到内存中后由target环境的runtime告知，因为这么设计会提供更多的灵活性。事实来看，似乎动态链接器的地址在链接阶段就被指定了，这是一个有趣的发现。为了分析这个bug，我甚至专门在stack overflow论坛上post了一个帖子。

## CMake交叉编译

引入CMake等Build system的目的是将编译链接过程系统化和体系化，让系统程序员更加易于维护。你所要做的第一步是将前述options翻译成为CMake指令。CMake有独有的toolchain test检测机制。CMake在执行的时候，会在实际编译前执行一系列环境检测和编译测试。比较tricky的是在CMake中，这一步所使用的链接器配置和Clang的链接器配置是隔离的，这会造成即使你给Clang配置的链接器为lld，CMake在做toolchain检测时依然会选择ld作为链接器。无论你做什么样的尝试，你始终无法通过CMake的toolchain test。解决方法是在CMake中设置全局链接器配置为lld，只有这样才能让CMake通过toolchain test。更加粗鲁的方式是通过设置参数来让CMake强制执行实际的编译任务，就算CMake无法通过toolchain test。

## 验证

验证生成程序是否确实为目标平台所独有，一个严谨的方法是使用Linux下的`file`指令对可执行程序进行解析。切勿武断地认为在WSL2中可执行文件能成功运行就可以认为交叉编译成功，因为WSL2可以执行Windows`.exe`程序（这点相当tricky）。

## 总结

交叉编译技术充满挑战。网上资料不多，思考结合实践方能出真知。一路走来，自己对C++编译链接的理解上升了一个档次。
