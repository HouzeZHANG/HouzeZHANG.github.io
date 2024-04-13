---
title: "Python Cheat List"
date: 2024-04-10T22:26:43+02:00
draft: true
tags: ["default"]
---

## Grammar

### List Comprehension

```python
freq = [[] for i in range(len(nums) + 1)]
```

### Slicing

#### 按顺序取出

拷贝且按照步长为`-1`取出

```python
return (new == new[::-1])
```

### range(beg, end, step)

```python
for i in range(len(freq) - 1, 0, -1):
    ...
```

### Integer Division

`//`实现整数除法

```python
if (board[i][j] in rows[i] or 
    board[i][j] in cols[j] or 
    board[i][j] in squares[(i // 3, j // 3)]):
    return False
```

### 布尔表达式

可以使用括号提升运算优先级

#### 容器是否为空

很多时候不需要使用`len()`来判断容器是否为空

- https://leetcode.com/problems/valid-parentheses/description/

```python
return not stack
```

### 负数怎么写？

## Generic Algorithms

### sorted()

### reversed()

### enumerate()

在for循环中同时取到index和元素值 

```python
for i, a in enumerate(nums):
    if i > 0 and a == nums[i - 1]:
        ...
```

## Containers

### list

#### list.sort(key, reverse=False)

Amortized O(NlogN)

默认升序排序，排序顺序通过`reverse`参数进行调整，可以传入predicate以自定义排序规则。

```python
>>> a
[(-1, 3), (1, 2)]
>>> a.sort(reverse=True)
>>> a
[(1, 2), (-1, 3)]
>>> def getKey(x):
...     return x[1]
...
>>> a.sort(key=getKey, reverse=False)
>>> a
[(1, 2), (-1, 3)]
```

在传入谓语的时候需要添加`key`参数名，否则会出现如下报错：

```python
>>> a.sort(getKey, reverse=False)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: sort() takes no positional arguments
```

#### list.append(element)

Always O(1)

#### list.pop(index), list.pop()

Amortized O(N)

该方法返回被删去的对象

如果不传任何参数，则默认`pop`末尾元素

```python
>>> a.pop(0)
(1, 2)
>>> a
[(-1, 3)]
```

#### list.insert(index, element)

Amortized O(N)

```python
>>> a.insert(0, 100)
>>> a
[100, (-1, 3)]
```

#### in, list.index(element)

Amortized O(N)

一般对于可迭代的序列化容器都会隐式调用顺序扫描，除非自己定义`__getItem()__`魔术方法；个人不推荐使用`index()`，因为它需要处理异常

```python
>>> a
[100, (-1, 3)]
>>> a.index(100)
0
>>> a.index(101)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: 101 is not in list
>>> 100 in a
True
>>> 101 in a
False
```

### str

#### str.append(element)

Always O(1)

#### str.find(pattern, beg, end)

Not so confident with this conclusion:

>O((n-m)*m) where n is the size of the string in which you search, and m is the size of the string which you search.

```python
>>> s = "Hello world!"
>>> s.find("He")
0
>>> s.find("e")
1
>>> s.find(">")
-1
>>> s.find("wor", 6)
6
>>> s.find("wor", 7)
-1
```

#### str.lower(), str.upper()

大小写转换

```python
>>> s
'Hello world!'
>>> s.upper()
'HELLO WORLD!'
>>> s
'Hello world!'
>>> s.lower()
'hello world!'
```

- https://leetcode.com/problems/valid-palindrome/

#### str.isdigit(), str.isalpha()

```python
>>> "abc".isdigit()
False
>>> "abc123".isdigit()
False
>>> "abc".isalpha()
True
```

- https://leetcode.com/problems/valid-palindrome/

#### str.split("sep"), str.join(iter)

注意`join`方法的调用对象和参数类型

```python
>>> s
'Hello world!'
>>> s.split(" ")
['Hello', 'world!']
>>> res = s.split(" ")
>>> res.join("-")
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: 'list' object has no attribute 'join'
>>> "-".join(res)
'Hello-world!'
```

#### str.replace(pattern, target)

将`str`字符串中的`pattern`替换成`target`

- 也许你会在<https://leetcode.com/problems/valid-palindrome/>这题尝试这个方法，但请别这么用

#### ord(), chr()

比较字符串大小，通过数字转化为对应的字符

### dict

字典的key必须为immutable objects，不可以为列表等mutable对象。可以使用数字，字符串，元组或者`None`

使用`tuple()`来将可变对象转换为不可变对象以作为key的例子：

```python
class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        k2v = collections.defaultdict(list)
        for s in strs:
            k = tuple(sorted(s))
            k2v[k].append(s)
        return k2v.values()
```

TODO: 使用`None`作为key的例子：

#### dict.get(key, value)

```python
>>> a = dict()
>>> a[-1]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
KeyError: -1
>>> a.get(-1, 100)
100
```

经常用于对空字典进行操作

```python
for n in nums:
    count[n] = 1 + count.get(n, 0)
```

#### collections.defaultdict(type)

给字典的value设置默认类型，可以传入`set`或者`list`以便于`add`和`append`

```python
>>> sd = collections.defaultdict(set)
>>> sd[x].add(100)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'x' is not defined
>>> sd[13].add(100)
>>> sd[13]
{100}
```

#### dict.values(), dict.items()

```python
for x in nums:
    frequency[x] = frequency.get(x, 0) + 1
for value, freq in frequency.items():
    ls.append((freq, value))
```

#### del dict[key]

从字典中移除一个元素

#### dict == dict

判断两个字典是否相等

#### key in dict

检查`key`是否在字典中

- https://leetcode.com/problems/valid-parentheses/description/

```python
if c not in Map:
    stack.append(c)
    continue
    ...
```

### set

#### set(iter)

`set`构造器

```python
numSet = set(nums)
```

#### set.add(element)

插入元素

#### set.remove(element)

移除元素，建议配合`in`使用。`remove`不存在的

#### set.pop()

随机取出一个元素，如果集合为空则抛异常

### collections.deque

这个数据结构在单调栈的题目中用的很多

#### append, appendleft

#### pop, popleft

### heapq

#### heapq.heapify

#### heapq.heappush

#### heapq.heappop



## References