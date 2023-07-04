---
title: "Varying Parameters in C++"
date: 2023-07-04T23:47:17+02:00
draft: false
tags: ["C++"]
---

### Background

There are three methods to implement **varying parameters** in C++. This post will summarize those three methods, and giving my solutions to related exercise in [1].

### initializer_list

Using **for loop** to iterate initializer_list object  
Elements should be the **same type** in initializer_list  
Which is a **template library type**  
Elements are **always const** in initializer_list  
When **copy** initializer_list objects, the **elements** underlayer **will not be copied**. The initializer_list objects will **share** those elements.  

#### Assignment

> Exercise 6.27: Write a function that takes an initializer_list int and produces the sum of the elements in the list. 

```c++
int sum(initializer_list<int> il) {
    int s = 0;
    for (auto &x:il) {
        s += *x;
    }
    return s;
}

int main(int argc, char ** argv)
{
    cout << sum(initializer_list<int>({1, 2, 3, 4})) << endl; // 10
    cout << sum(initializer_list<int>({})) << endl; // 0
    return 0;
}
```

> Exercise 6.28: In the second version of error_msg that has an ErrCode parameter, what is the type of elem in the for loop?

`const string &`

> Exercise 6.29: When you use an initializer_list in a range for would you ever use a reference as the loop control variable? If so, why? If not, why not?

Using reference is faster, especially when copy element costs lots of time.

### References

Lippman, S. B., Lajoie, J., &#38; Moo, B. E. (n.d.). <i>C++ primer</i>.