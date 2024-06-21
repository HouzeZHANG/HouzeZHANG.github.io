---
title: "From C-Style Array to C++'s std::string"
date: 2024-06-20T22:32:00+02:00
draft: true
---

中文在下面👇

```cpp

#include <vector>

struct MyStructWithCArray {
    char s[20];
    int i;
};

struct MyStructWithString {
    std::string s;
    int i;
};

void foo()
{
    MyStructWithCArray a = {"Hello, World!", 42};
    
    std::vector<MyStructWithCArray> v;
    v.push_back(a);
    v.push_back(std::move(a));
    // ...
}
```

- ANSI C Style Array
- char *s = "Hello, World!"发生了什么？
- C++11 std::array 和 ANSI C Style Array 的区别
- C++ std::string 的问题是什么，为什么要用C-style array？
- 结构体的拷贝构造函数，移动构造函数是什么？

## C/C++下Array的拷贝行为是什么？

思考如下结构体在被拷贝的时候会发生什么？

```cpp
struct MyStruct {
    char s[20];
    int i;
};
```

学习过C++ copy control的同学会眉头一皱，因为这个结构体没有定义拷贝构造函数，那么会发生什么呢？我们是否需要给这个结构体定义拷贝构造函数？如果不定义，`char s[20]`会怎么拷贝？会只拷贝指针`s`吗？

在工作中，我需要使用一个类似的结构体，同时将其`push_back()`到一个`std::vector`中，我们知道`std::vector`会调用拷贝构造函数，或是移动构造函数。
