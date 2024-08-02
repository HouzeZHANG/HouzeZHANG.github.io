---
title: "Decorator and Closure"
date: 2024-07-30T21:55:28+02:00
slug: 2024-07-30-deco
type: posts
draft: false
categories: ["Python Grammar"]
tags: ["Python", "Functional Programming"]
---

## Closure

闭包是指函数内部定义的函数，可以访问外部函数的变量。闭包的作用是保存外部函数的状态，使得外部函数的变量信息得以保存。

闭包的闭字代表了封闭性，言下之意是函数被封闭在函数上下文中，可以访问函数上下文中的变量。

```python
def outer():
    x = 1
    def inner():
        print(x)
    return inner

f = outer()

f()  # 1
```

---

## Decorator

装饰器的目的是在不改变原函数的情况下，增加新的功能。装饰器是一个函数，接受一个函数作为参数，返回一个函数。装饰器运用了闭包的特性。

```python
def decorator(func):
    print("<<< Decorator is called >>>")
    def wrapper():
        print('Before')
        func()
        print('After')
    return wrapper

@decorator
def say_hello():
    print('Hello')
```

下面这个例子展示了带有参数的装饰器是如何工作的。牢记装饰器的本质是一个函数，接受一个函数作为参数，返回一个函数。如果需要给装饰器传参，则在装饰器外层再包裹一层函数，这个函数接受装饰器的参数，返回装饰器。

```python
def print_args(msg):
    def decorator(func):
        def wrapper(*args, **kwargs):
            print(msg)
            return func(*args, **kwargs)
        return wrapper
    return decorator

@print_args('Before')
def say_hello(name):
    print(f'Hello {name}')

say_hello('World')
```

以上代码的执行结果为：

```bash
>>> say_hello("abc")
Before
Hello abc
```

## Real World Example

```plaintext
def decorator(func):
    def func(*args, **kwargs):
        print('Before')
        func(*args, **kwargs)
        print('After')
    return func

@decorator
def say_hello(name):
    print(f'Hello {name}')

say_hello('World')

In the above code, how many times will the decorator be called?
Answer: 1
```

需要记住，装饰器是闭包函数的上下文，所以装饰器只会被调用一次，不会被多次调用。
