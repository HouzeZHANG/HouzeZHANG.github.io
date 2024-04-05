---
title: "First Step to Be Pythonic"
date: 2024-04-05T14:09:11Z
draft: false
tags: ["python"]
---

Real pythonic always takes advantage of native collection manipulations by using magic methods (which are also called dunder method). *Dunder methods* are a series of methods which have double underscore before and after the function name. Implementation of those dunder methods make Python interpreter implicitly call them when we use methods such as `operator[]` or `in` on those ADTs.

Implement `__len__()` lets interpreter call this method when we use `len()` on this ADT object. `__getitem__(position)` will be called when using any slicing syntax`[:]`. `__getitem()` is pretty like C++'s `operator[]`, which can always be seen in STL container definition, especially for those supporting random access.

`__getitem__(position)` makes ADT *iterable*. It makes sense because if it supports random access, do iteration is a piece of cake. Without `__contains__()`, applying `in` will trigger *sequential scan* on that object. Because ADT is iterable, you can also apply `sorted(ADT, predicate)` to sort it without modifying the original position (`sorted` will return a new obj, not do in-place sorting), use `reversed()` to reverse the original object and do `random.choice()` on it as you wish.

Interpreter will visit native C structure to read the built-in type collections' attributes. That will make instructions like `len(list(...))` fast enough. However for user-buit types, interpreter will call magic methods(In most cases pythonic doesn't need to worry about speed). Here we see a good combination between interpreted language and compiled language.

Anyway, the first step to be pythonic is to implement `__len__()` and `__getitem()__` when you're try to design your own data structure :).

## References

“Fluent Python, the Lizard Book.” Accessed April 5, 2024. https://www.fluentpython.com/.
