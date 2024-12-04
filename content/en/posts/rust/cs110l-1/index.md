---
title: Different Safety Analysis Approachs and Their Problems
date: 2024-09-19T16:40:32+02:00
slug: 2024-09-19-cs110l-1
type: posts
draft: true
categories:
  - CS110L
tags:
  - Rust
  - LLVM
---
CS100L is a series of courses focused on secure systems programming, introducing Rust and its benefits. We'll learn that neither dynamic nor static analyzers can detect all potential issues and vulnerabilities in C/C++ programs.

Dynamic analyzers, like Valgrind, monitor programs at runtime by replacing assembly instructions for heap memory operations to detect memory leaks. However, they cannot identify problems in code paths that are never executed. 

A classic use case for dynamic analysis is fuzz testing. Tools like AFL, libfuzzer, and OSS-Fuzz use fuzzing to systematically explore different program inputs and their corresponding control flow graphs.

Static analyzers, such as LLVM Sanitizer, linters, and clang tidy, can't determine the actual inputs and outputs of a program, so they often skip over certain statements (false positives are undesirable and can lead to user frustration). Additionally, for performance reasons, static analyzers typically analyze one file at a time, which can lead to inaccurate results.

Static analyzers are often integrated into Git workflows as commit hooks. Before merging code into a repository, version control systems or hosting platforms automatically run linting on new code.

In conclusion, neither static nor dynamic analysis can guarantee that C/C++ programs are completely bug-free.

---

CS100L是一系列关于安全系统编程的课，介绍了Rust的特性以及为什么我们需要Rust。我们需要知道，无论是动态解析器还是静态解析器，都无法检测出C/C++程序的所有问题以及漏洞。

动态解析器（比如Valgrind）通过替换操作堆内存的汇编指令来观察程序在运行的过程中是否有内存泄漏，动态解析器无法检测未被运行到的逻辑分支。

动态解析过程的经典用例是fuzzing test模糊测试，简单来说测试系统通过观察程序执行的control flow graph来调整不同的程序输入以期待覆盖全部的输入空间以及control flow graph。比较有名的模糊测试框架有AFL，libfuzzer以及OSS-Fuzz

静态解析器（比如LLVM Sanitizer，linter，clang tidy）则由于无法得知真实的输入输出，对于很多语句只能跳过不予评判（false positive是不受欢迎的，过多的虚假报错会让用户厌恶使用该工具）。此外出于性能的考量，静态解析器往往只能读取一个文件，无法同时对多个文件进行全局解析，这会导致解析结果出现偏差。

静态解析器往往被设置在git workflow的commit hook中，当团队成员对代码进行提交合并到代码库之前，VCS或者代码托管平台会对提交的新代码自动执行linting操作。

所以无论使用静态解析器还是动态解析器，均无法完全让C/C++程序bug-free。

