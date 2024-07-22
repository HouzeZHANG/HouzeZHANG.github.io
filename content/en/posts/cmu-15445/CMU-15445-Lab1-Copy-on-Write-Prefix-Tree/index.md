---
title: "CMU 15445 Lab1 Copy on Write Prefix Tree"
date: 2024-06-29T08:24:28+02:00
draft: true
---

## C++11/17 New Features

- `std::optional`
- `std::string_view`
- 

有测试无法测到的情况，类的root成员是private，删除最后一个键值对，树需要清空，测试样例没覆盖到，把成员访问修饰符改成public后才能测到。算是一个小bug。

ValueGuard的设计思想充分体现了C++的RAII
