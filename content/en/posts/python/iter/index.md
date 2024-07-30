---
title: "Iterators and Generators"
date: 2024-07-30T21:00:09+02:00
slug: 2024-07-30-iter
type: posts
draft: false
categories: ["Python Grammar"]
tags: ["Python", "Iter"]
---

## 迭代器（Iterator）和可迭代对象（Iterable）

### 可迭代对象

实现了`__iter__`方法的对象，在迭代协议中，这个方法应该返回一个**新的**迭代器。

### 迭代器

实现了`__next__`和`__iter__`方法的对象。`__next__()`方法理应返回当前迭代器指向的元素，并将迭代器指向下一个元素。当迭代器没有元素时，抛出`StopIteration`异常。

**一般上下文会保存在类中，作为私有变量，在`__iter__`方法中对该上下文进行初始化，`__next__`方法中对上下文进行更新。（思路和IOCP的context类似）**

```python
class FibonacciIterator:
    def __init__(self, max_count=None):
        self.a = 0
        self.b = 1
        self.count = 0
        self.max_count = max_count  # 可选的最大数目限制

    def __iter__(self):
        return self

    def __next__(self):
        if self.max_count is not None and self.count >= self.max_count:
            raise StopIteration

        current = self.a
        self.a, self.b = self.b, self.a + self.b
        self.count += 1
        return current


# 使用自定义迭代器生成前十个斐波那契数
fib_iter = FibonacciIterator(max_count=10)
for number in fib_iter:
    print(number)
```

---

## 生成器（Generator）

### 使用场景

- 惰性计算，只在需要的时候才计算
- 大数据量的处理，不需要一次性加载到内存中
- 流数据处理，逐行处理数据

机制：

生成器是一个包含`yield`关键字的函数，每次调用`next`方法时，执行到`yield`关键字时暂停，返回`yield`后的值。当再次调用`next`方法时，从上次暂停的位置继续执行。

生成器是一种特殊的迭代器。

```python
def fibonacci_generator():
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b


# 使用生成器生成前十个斐波那契数
fib_gen = fibonacci_generator()
for _ in range(10):
    print(next(fib_gen))
```

### 使用生成器替换列表推导式 （List Comprehension）

```python
# 使用列表推导式
squared = [x ** 2 for x in range(10)]

# 使用生成器
squared_gen = (x ** 2 for x in range(10))

# 生成器只有在需要时才计算
print(squared_gen)
print(next(squared_gen))
print(list(squared_gen))
```

在生成器生成的数据被消费完后，再次调用`next`方法会抛出`StopIteration`异常。使用`list`函数可以将生成器转换为列表，生成器的数据会被消费。

```bash
>>> # 使用列表推导式
>>> squared = [x ** 2 for x in range(10)]
>>> 
>>> # 使用生成器
>>> squared_gen = (x ** 2 for x in range(10))
>>> 
>>> # 生成器只有在需要时才计算
>>> print(squared_gen)
<generator object <genexpr> at 0x100c6b510>
>>> print(next(squared_gen))
0
>>> print(list(squared_gen))
[1, 4, 9, 16, 25, 36, 49, 64, 81]
>>> print(squared_gen)
<generator object <genexpr> at 0x100c6b510>
>>> print(next(squared_gen))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration
>>> 
```
