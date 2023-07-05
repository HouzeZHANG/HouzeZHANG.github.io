---
title: "Type Conversion"
date: 2023-07-05T15:17:12+02:00
draft: false
tags: ["C++", "C++ Primer"]
---

### Background

This post is excerpted from the 2.1.2 section of C++primer and contains the parts I think are important as well as my comments. The answers to the practice questions in subsection 2.1.2 are included.

### Highlights

> The type of an object defines the data that an object might contain and what operations that object can perform.  Among the operations that many types support is the ability to convert objects of the given type to other, related types.

It is an important idea and provision that the scope of object operations depends on the type of the object. This stipulation contradicts polymorphism.  

> By the same token,when we use a bool in an arithmetic expression, its value always converts to either 0 or 1. As a result, using a bool in an arithmetic expression is almost surely incorrect.

Although `bool` values are converted to 0 and 1 in the calculation of arithmetic expressions, it is still not recommended to include them in arithmetic expressions.

> if we use both unsigned and int values in an arithmetic expression, the int value ordinarily is converted to unsigned. 
> The value “wraps around” as described above.

```c++
unsigned u1 = 42, u2 = 10;
std::cout << u1 - u2 << std::endl; //ok: result is32
std::cout << u2 - u1 << std::endl; //ok: but the result will wrap around
```

```c++
// WRONG: u can never be less than 0; the condition will always succeed
for (unsigned u = 10; u >= 0; --u){
    std::cout << u << std::endl;
}
```

> Expressions that mix signed and unsigned values can yield surprising results when the signed value is negative. 

This is because the program interprets a number of signed type as a number of unsigned type, and subsequently computes with the unsigned number, and the result of the computation is interpreted as unsigned type.

#### Assignment

> Exercise 2.3:What output will the following code produce?

```c++
unsigned u = 10, u2 = 42;
std::cout << u2 - u << std::endl;
std::cout << u - u2 << std::endl;

int i = 10, i2 = 42;
std::cout << i2 - i << std::endl;
std::cout << i - i2 << std::endl;
std::cout << i - u << std::endl;
std::cout << u - i << std::endl;
```

In the first line, there is no implicit conversion before the operation, because both are of type `unsigned int`, and there is no loop overflow because $42-10 = 32 > 0$, and the output is $32$. The arithmetic expression in the second line is also not implicitly converted, but there is a loop overflow because $10-42 = -32 < 0$. At this point we need to interpret the binary representation of $-32$ as `unsigned int`.

```c++
unsigned u = 10, u2 = 42;
std::cout << u2 - u << std::endl;
std::cout << u - u2 << " " << (long long)pow(2, 32) - 32 << std::endl;
```
32
4294967264 4294967264

```c++
int i = 10, i2 = 42;
std::cout << i2 - i << std::endl; // 32
std::cout << i - i2 << std::endl; // -32
std::cout << i - u << std::endl; // 0
std::cout << u - i << std::endl; // 0
```

> Exercise 2.4:Write a program to check whether your predictions were correct. If not,study this section until you understand what the problem is.

Already written above

### References

<div class="csl-entry">Lippman, S. B., Lajoie, J., &#38; Moo, B. E. (n.d.). <i>C++ primer</i>.</div>