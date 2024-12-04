---
title: "P1"
date: 2024-07-29T17:20:00+02:00
slug: 2024-07-29-p1
type: posts
draft: true
categories:
  - ["FastAPI"]
tags:
  - ["Python", "Restful", "FastAPI"]
---

## Introduction

对于异步和协程的支持使得Python的性能得到了质的飞跃。FastAPI很像Flask，但是更偏向API，可以理解为是Flask的API强化版本。FastAPI不在意前后端不分离的情况，借鉴了DRF，文档全部自动生成，参数配置方便。

## FastAPI核心组件

- Starlette: 异步Web服务
- Pydantic: 数据，模型相关
  - 支持数据验证：将数据转换为对应的类型，放入模型中

常用SGI：
- WSGI: Web Server Gateway Interface
- ASGI: Asynchronous Server Gateway Interface

## HTTP协议

Hyper Text Transfer Protocol 传输音频，图片，视频，文本等。基于TCP的上层协议。

Socket双方都可以发送数据。但是HTTP是客户端发送请求，服务器端返回响应。WebSocket下服务器端也可以主动发送数据。

有请求必定有响应。

无状态保存，每次请求都是独立的。服务器不做任何记录。

短连接，每次请求都是新的连接。（HTTP/1.1中有长连接）。TCP connection 是一种资源，所以要尽量减少连接的建立和断开。长连接的好处是可以复用TCP连接，减少了连接的建立和断开。可以看到TCP服务器时长需要建立新的链接，或者断开现有链接，这也是为什么高性能IOCP服务器会选择使用链表作为上下文存储的数据结构的原因。

Socket是插头，HTTP是电线。

### HTTP请求

1. 请求首行

- `GET` or `POST`

区别：请求时的数据放在请求的哪里。

- `URL`：统一资源定位符
协议，（IP）域名，端口（一般为80），路径，查询参数（`?`区分），锚点

无论是GET还是POST，都可以在URL中传递参数。

- 请求协议+版本

2. 请求头

给服务器的基本信息。由键值对组成，键值对的个数不限。

`user-agent`：浏览器的信息，基本的反爬措施是检查`user-agent`，如果是爬虫就拒绝访问，是第一层防护。  

`content-type`：请求体的类型  
三种格式：Json，form-data，x-www-form-urlencoded

3. 请求体

GET请求没有请求体（数据只能挂在URL下，所有的数据都会暴露），POST请求有请求体，相对来说更安全。

### HTTP响应

1. 响应首行

- 协议+版本
- 状态码：200，404，500
- 状态码描述

2. 响应头

- `content-type`：响应体的类型，前后端不分离的时候会直接返回一个页面，浏览器会根据`content-type`来解析数据，渲染数据。
- `content-length`：响应体的长度
- `date`：响应的时间

3. 响应体

- 返回的数据

数据位置不同。

### Content-Type

Restful中至关重要的请求头。

一般常用的有：

- `urlencoded`：表单数据
- `application/json`：json数据（JSON格式不允许单引号）
- `text/plain`：纯文本
- `text/html`：html文本

### HTTP实验

```python

import socket

sk = socket.socket()
sk.bind(("127.0.0.1", 8080))
sk.listen(5)

state = True

while True:
    print("The server is listening...")
    conn, addr = sk.accept()    # blocked
    dt = conn.recv(1024)
    print(dt)
    if state:
        conn.send(b"hello world")
        state = False
    else:
        conn.send(b"HTTP/1.1 200 OK\r\nserver:houze\r\n\r\nhello world")
        state = True
    conn.close()

```

```bash

The server is listening...
b'GET / HTTP/1.1\r\nHost: localhost:8080\r\nConnection: keep-alive\r\nCache-Control: max-age=0\r\nsec-ch-ua: "Not/A)Brand";v="8", "Chromium";v="126", "Google Chrome";v="126"\r\nsec-ch-ua-mobile: ?0\r\nsec-ch-ua-platform: "macOS"\r\nUpgrade-Insecure-Requests: 1\r\nUser-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7\r\nSec-Fetch-Site: none\r\nSec-Fetch-Mode: navigate\r\nSec-Fetch-User: ?1\r\nSec-Fetch-Dest: document\r\nAccept-Encoding: gzip, deflate, br, zstd\r\nAccept-Language: zh-CN,zh;q=0.9,fr;q=0.8,en;q=0.7\r\n\r\n'
The server is listening...
b''
The server is listening...
b'GET / HTTP/1.1\r\nHost: localhost:8080\r\nConnection: keep-alive\r\nCache-Control: max-age=0\r\nsec-ch-ua: "Not/A)Brand";v="8", "Chromium";v="126", "Google Chrome";v="126"\r\nsec-ch-ua-mobile: ?0\r\nsec-ch-ua-platform: "macOS"\r\nUpgrade-Insecure-Requests: 1\r\nUser-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7\r\nSec-Fetch-Site: none\r\nSec-Fetch-Mode: navigate\r\nSec-Fetch-User: ?1\r\nSec-Fetch-Dest: document\r\nAccept-Encoding: gzip, deflate, br, zstd\r\nAccept-Language: zh-CN,zh;q=0.9,fr;q=0.8,en;q=0.7\r\n\r\n'
The server is listening...
b''
The server is listening...

```

## API接口开发——前后端分离

常用的接口有两种，Restful和RPC。
RESTFUL Representational State Transfer：面相资源开发。
    URL：资源的地址
    Method：资源的操作

## FastAPI 快速入门

```bash

pip install fastapi
pip install uvicorn

uvicorn <file_name>:<app_name> --reload

```

路径操作装饰器+路径操作函数

FastAPI的注解支持`summary`, `tags`等描述性字段用于生成文档。

`FastAPI.APIRouter()`可以将路由分组，在子包中定义路由，然后在主包中引入。`prefix`参数可以设置路由前缀，不需要在子包中再次设置。

```python

from fastapi import FastAPI
from app1 import router1
from app2 import router2

app = FastAPI()

app.include_router(router1, prefix="/router1", tags=["router1"])
app.include_router(router2, prefix="/router2", tags=["router2"])
```