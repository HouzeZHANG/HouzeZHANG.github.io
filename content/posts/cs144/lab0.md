---
title: "CS144 Check0"
date: 2023-08-31T15:24:50+02:00
draft: true
tags: ["C++", "CS144"]
---

## Lab0

### Using `telnet` to request

#### What's Telnet?

> A client program that makes outgoing connections to programs running on other computers

#### Fetch a web page with http

telnet建立http链接时可能超时
```shell
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>408 Request Timeout</title>
</head><body>
<h1>Request Timeout</h1>
<p>Server timeout waiting for the HTTP request from the client.</p>
</body></html>
```

正确的返回结果
```shell
HTTP/1.1 200 OK
Date: Wed, 30 Aug 2023 03:15:48 GMT
Server: Apache
Last-Modified: Thu, 13 Dec 2018 15:45:29 GMT
ETag: "e-57ce93446cb64"
Accept-Ranges: bytes
Content-Length: 14
Connection: close
Content-Type: text/plain

Hello, CS144!
```

#### Send an email

[https://www.samlogic.net/articles/smtp-commands-reference.htm](https://www.samlogic.net/articles/smtp-commands-reference.htm)

确保能`ping`通学校邮箱的发件服务器
```shell
cs144@vm:~/lab0$ ping smtps.utc.fr
PING smtps.utc.fr (195.83.155.8) 56(84) bytes of data.
64 bytes from smtps.utc.fr (195.83.155.8): icmp_seq=1 ttl=46 time=70.8 ms
64 bytes from smtps.utc.fr (195.83.155.8): icmp_seq=2 ttl=46 time=66.8 ms
64 bytes from smtps.utc.fr (195.83.155.8): icmp_seq=3 ttl=46 time=54.4 ms
```

我们学校的邮件服务器只能用`smtps`
```shell
cs144@vm:~/lab0$ telnet 195.83.155.8 smtps
Trying 195.83.155.8...
Connected to 195.83.155.8.
Escape character is '^]'.
```

发现`HELO`该服务器，链接直接断开
```shell
cs144@vm:~/lab0$ telnet 195.83.155.8 smtps
Trying 195.83.155.8...
Connected to 195.83.155.8.
Escape character is '^]'.
HELO mydomain.fr 
Connection closed by foreign host.
```

[https://unix.stackexchange.com/questions/213364/telnet-connection-closed-by-foreign-host](https://unix.stackexchange.com/questions/213364/telnet-connection-closed-by-foreign-host)
查了一下原因，是服务器配置拒绝访问
> The process that is listening for connections on port 7077 is accepting the connection and then immediately closing the connection. The problem lies somewhere in that application's code or configuration, not in the system itself.

换成qq邮箱试一下（一般smtps和smtp共享同一个域名）
```shell
cs144@vm:~/lab0$ ping smtp.qq.com
PING smtp.qq.com (43.129.255.54) 56(84) bytes of data.
64 bytes from 43.129.255.54 (43.129.255.54): icmp_seq=1 ttl=47 time=294 ms
64 bytes from 43.129.255.54 (43.129.255.54): icmp_seq=2 ttl=47 time=280 ms
64 bytes from 43.129.255.54 (43.129.255.54): icmp_seq=3 ttl=47 time=289 ms
```

发现成功了，qq服务器`smtp`和`smtps`都是支持的
```shell
cs144@vm:~/lab0$ telnet 43.129.255.54 smtp
Trying 43.129.255.54...
Connected to 43.129.255.54.
Escape character is '^]'.
220 newxmesmtplogicsvrszb6-0.qq.com XMail Esmtp QQ Mail Server.
^]
telnet> close
Connection closed.
cs144@vm:~/lab0$ telnet 43.129.255.54 smtps
Trying 43.129.255.54...
Connected to 43.129.255.54.
Escape character is '^]'.
^]
telnet> close
Connection closed.
```
但是只能`HELO`通`smtp`，为什么`smtps`不行呢？
```shell
cs144@vm:~/lab0$ telnet 43.129.255.54 smtp
Trying 43.129.255.54...
Connected to 43.129.255.54.
Escape character is '^]'.
220 newxmesmtplogicsvrszb6-0.qq.com XMail Esmtp QQ Mail Server.
HELO mydomain.cn
250-newxmesmtplogicsvrszb6-0.qq.com-11.149.94.213-32291726
250-SIZE 73400320
250 OK
```

### Using `netcat` to listen

server side
注解：`-l`的效果是监听，`-v`代表希望显示更多信息
`-l`: Listen for an incoming connection rather than initiating a connection to a remote host.
`-v`: produce more verbose output
```shell
cs144@vm:~/lab0$ netcat -v -l -p 9090      
Listening on 0.0.0.0 9090
Connection received on localhost 50852
aaa
bbb
^C
```

client side，我们发现服务端断开链接（使用`Ctl+C`）后客户端看见的效果是`Connection closed by foreign host`，和之前`smtps``HELO`学校邮箱服务器的结果一致
```shell
cs144@vm:~$ telnet localhost 9090
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
aaa
bbb
Connection closed by foreign host.
```

### Using `stream socket` to writing network program

Why we should make each line end with `"\r\n"`, because Windows platform

#### Hint: 在编译的时候，需要进入build目录`make`

在看到minnow/apps下有CMakeLists.txt的时候会迫不及待地
```shell
cmake .
```
企图在当前目录下修改`CMakeLists.txt`，配置编译项。比如这里的`CMakeLists.txt`没有将`includePath`配置，出现如下错误：
```bash
cs144@vm:~/minnow/apps$ make
[ 50%] Building CXX object CMakeFiles/webget.dir/webget.o
/home/cs144/minnow/apps/webget.cc:1:10: fatal error: socket.hh: No such file or directory
    1 | #include "socket.hh"
      |          ^~~~~~~~~~~
compilation terminated.
make[2]: *** [CMakeFiles/webget.dir/build.make:76: CMakeFiles/webget.dir/webget.o] Error 1
make[1]: *** [CMakeFiles/Makefile2:83: CMakeFiles/webget.dir/all] Error 2
make: *** [Makefile:91: all] Error 2
```

正确的做法是`cd`进`build`目录，然后`make`，自己写`CMakeLists.txt`多此一举。

咔咔咔写完，这里有一个坑。请求报文的最后一行需要加**两组**换行符，只加一组是不行的
```C++
const string request = "GET " + path + " HTTP/1.1\r\n" + 
    "Host: " + host + "\r\n" + 
    "Connection: close\r\n\r\n";
```

此外，使用`string_view`来存储请求字符串会造成**乱码**，会导致服务端无法解析请求，返回`400 BAD REQUEST`
```shell
cs144@vm:~/minnow/build$ ./apps/webget cs144.keithw.org /hello
Function called: get_URL(cs144.keithw.org, /hello)
HTTP/1.1 400 Bad Request
Date: Wed, 30 Aug 2023 07:52:40 GMT
Server: Apache
Content-Length: 226
Connection: close
Content-Type: text/html; charset=iso-8859-1

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>400 Bad Request</title>
</head><body>
<h1>Bad Request</h1>
<p>Your browser sent a request that this server could not understand.<br />
</p>
</body></html>
```

正确的运行结果如下，拿到的是`200 OK`。请不要在`cout`中再额外添加`\n`，这会使测试无法通过。
```shell
cs144@vm:~/minnow/build$ ./apps/webget cs144.keithw.org /hello
Function called: get_URL(cs144.keithw.org, /hello)
HTTP/1.1 200 OK
Date: Wed, 30 Aug 2023 08:40:51 GMT
Server: Apache
Last-Modified: Thu, 13 Dec 2018 15:45:29 GMT
ETag: "e-57ce93446cb64"
Accept-Ranges: bytes
Content-Length: 14
Connection: close
Content-Type: text/plain

Hello, CS144!
```

测试结果
```shell
cs144@vm:~/minnow$ cmake --build build --target check_webget
Test project /home/cs144/minnow/build
    Start 1: compile with bug-checkers
1/2 Test #1: compile with bug-checkers ........   Passed    0.44 sec
    Start 2: t_webget
2/2 Test #2: t_webget .........................   Passed    1.73 sec

100% tests passed, 0 tests failed out of 2

Total Test time (real) =   2.17 sec
Built target check_webget
```

### Implement an in-memory reliable byte stream

#### 并发

```c++
Your byte stream is for use in a single thread—you don’t have to worry about concurrent writers/readers, locking, or race conditions.
```

#### 构造器

不在构造器里面显式地初始化`std::queue`会报如下的错误
```c++
/home/cs144/minnow/src/byte_stream.cc: In constructor ‘ByteStream::ByteStream(uint64_t)’:
/home/cs144/minnow/src/byte_stream.cc:7:1: error: ‘ByteStream::buffer’ should be initialized in the member initialization list [-Werror=effc++]
    7 | ByteStream::ByteStream( uint64_t capacity ) : capacity_( capacity ) {}
```
得这么写
```c++
ByteStream::ByteStream( uint64_t capacity ) : capacity_( capacity ), buffer() {}
```

关于`string_view`，如果绑定的字符串在离开作用域的时候被销毁，则会导致未定义行为
```c++
string_view Reader::peek() const
{
  // Your code here.
  return string_view(&(buffer.front()));
}
```

```c++
bool Reader::is_finished() const
{
  // Your code here.
  if (!close_ && count_pushed == 0) {
    // nothing has been push
    return false;
  }
  return close_ || (buffer.size() == 0);
}
```

`peek()`其实挺难的，只能使用`deque`实现，有坑。。。
```c++
string_view Reader::peek() const
{
  // Your code here.
  if (buffer.size() == 0 || buffer.front() == EOF) {
    return {};
  }
  string next_str;
  for (size_t i = 1; i < buffer.size(); ++i) {
    next_str += string(1, buffer[i]);
  }
  return string_view(next_str);
}
```

`size_t`溢出问题
```c++
for (size_t i = 0; i < buffer.size() - 1; ++i) {
```

读和写均非阻塞，string长度大于可用长度，只写入能写入的部分，其余部分丢弃。

迭代器构造字符串比字符拼接快了近十倍
```c++
string_view Reader::peek() const
{
  if (buffer.empty()) {
    return {};
  }

  if (buffer.back() == EOF) {
    next_str = string(buffer.begin(), buffer.end() - 1);
  }
  else {
    next_str = string(buffer.begin(), buffer.end());
  }

  return string_view(next_str);
}

```
benchmark结果
```shell
cs144@vm:~/minnow$ cmake --build build --target check0
Test project /home/cs144/minnow/build
      Start  1: compile with bug-checkers
 1/10 Test  #1: compile with bug-checkers ........   Passed    0.58 sec
      Start  2: t_webget
 2/10 Test  #2: t_webget .........................   Passed    1.02 sec
      Start  3: byte_stream_basics
 3/10 Test  #3: byte_stream_basics ...............   Passed    0.01 sec
      Start  4: byte_stream_capacity
 4/10 Test  #4: byte_stream_capacity .............   Passed    0.02 sec
      Start  5: byte_stream_one_write
 5/10 Test  #5: byte_stream_one_write ............   Passed    0.02 sec
      Start  6: byte_stream_two_writes
 6/10 Test  #6: byte_stream_two_writes ...........   Passed    0.02 sec
      Start  7: byte_stream_many_writes
 7/10 Test  #7: byte_stream_many_writes ..........   Passed    0.07 sec
      Start  8: byte_stream_stress_test
 8/10 Test  #8: byte_stream_stress_test ..........   Passed    0.04 sec
      Start 16: compile with optimization
 9/10 Test #16: compile with optimization ........   Passed    0.19 sec
      Start 17: byte_stream_speed_test
10/10 Test #17: byte_stream_speed_test ...........***Timeout  12.47 sec
```

将`char`拼接调整为用迭代器构造字符串，将执行时间从`12.47sec`优化到`1.82sec`

```c++
cs144@vm:~/minnow$ cmake --build build --target check0
Test project /home/cs144/minnow/build
      Start  1: compile with bug-checkers
 1/10 Test  #1: compile with bug-checkers ........   Passed    3.16 sec
      Start  2: t_webget
 2/10 Test  #2: t_webget .........................   Passed    1.04 sec
      Start  3: byte_stream_basics
 3/10 Test  #3: byte_stream_basics ...............   Passed    0.05 sec
      Start  4: byte_stream_capacity
 4/10 Test  #4: byte_stream_capacity .............   Passed    0.03 sec
      Start  5: byte_stream_one_write
 5/10 Test  #5: byte_stream_one_write ............   Passed    0.02 sec
      Start  6: byte_stream_two_writes
 6/10 Test  #6: byte_stream_two_writes ...........   Passed    0.03 sec
      Start  7: byte_stream_many_writes
 7/10 Test  #7: byte_stream_many_writes ..........   Passed    0.07 sec
      Start  8: byte_stream_stress_test
 8/10 Test  #8: byte_stream_stress_test ..........   Passed    0.03 sec
      Start 16: compile with optimization
 9/10 Test #16: compile with optimization ........   Passed    1.24 sec
      Start 17: byte_stream_speed_test
             ByteStream throughput: 0.05 Gbit/s
10/10 Test #17: byte_stream_speed_test ...........***Failed    1.82 sec
ByteStream with capacity=32768, write_size=1500, read_size=128 reached 0.05 Gbit/s.
Exception: ByteStream did not meet minimum speed of 0.1 Gbit/s.
```

`emplace_back()` vs `push_back()`

重新选择底层容器，将执行时间从`1.82sec`进一步优化到`0.29sec`

```shell
cs144@vm:~/minnow$ cmake --build build --target check0
Test project /home/cs144/minnow/build
      Start  1: compile with bug-checkers
 1/10 Test  #1: compile with bug-checkers ........   Passed    4.76 sec
      Start  2: t_webget
 2/10 Test  #2: t_webget .........................   Passed    1.05 sec
      Start  3: byte_stream_basics
 3/10 Test  #3: byte_stream_basics ...............   Passed    0.02 sec
      Start  4: byte_stream_capacity
 4/10 Test  #4: byte_stream_capacity .............   Passed    0.02 sec
      Start  5: byte_stream_one_write
 5/10 Test  #5: byte_stream_one_write ............   Passed    0.02 sec
      Start  6: byte_stream_two_writes
 6/10 Test  #6: byte_stream_two_writes ...........   Passed    0.03 sec
      Start  7: byte_stream_many_writes
 7/10 Test  #7: byte_stream_many_writes ..........   Passed    0.06 sec
      Start  8: byte_stream_stress_test
 8/10 Test  #8: byte_stream_stress_test ..........   Passed    0.03 sec
      Start 16: compile with optimization
 9/10 Test #16: compile with optimization ........   Passed    1.11 sec
      Start 17: byte_stream_speed_test
             ByteStream throughput: 0.86 Gbit/s
10/10 Test #17: byte_stream_speed_test ...........   Passed    0.30 sec

100% tests passed, 0 tests failed out of 10

Total Test time (real) =   7.40 sec
Built target check0
```