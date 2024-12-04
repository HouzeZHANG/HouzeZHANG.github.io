---
title: "Funcparam"
date: 2024-07-31T11:22:06+02:00
slug: 2024-07-31-funcparam
type: posts
draft: true
categories: ["Python Grammar"]
tags: ["OA", "Python"]
---

## Introduction

## Default Parameter

```python
def foo(a=0, b=1, c=2):
    print(a, b, c)

foo()
foo(3)
foo(3, 4)
foo("1 2 3", b=None, c=4)
```

```bash
>>> def foo(a=0, b=1, c=2):
...     print(a, b, c)
... 
>>> foo()
0 1 2
>>> foo(3)
3 1 2
>>> foo(3, 4)
3 4 2
>>> foo("1 2 3", b=None, c=4)
1 2 3 None 4
```

## Print None

What will happen when you print `None`?

```python
def foo():
    print(None)

foo()
```
