---
title: "SDF P1"
date: 2024-04-09T17:01:38Z
draft: true
tags: ["default"]
---

编码测试侧重考察的是程序员解决问题的能力，而系统设计需要求职者有足够的基础知识。Design foundamental类似数据结构，对于系统设计是非常重要的。

系统设计面试往往Very intentionally vague。问题只有几个字，但是你却需要将其转化为一个45分钟的对话。系统设计面试和coding面试的第二个区别是系统设计面试没有绝对的对错。

## Four catagories of the Concepts

### 1. Fundational knowledges

Client-server model
Network protocols

### 2. Key Characteristics of Systems

Throughput
Availability

### 3. Components of Systems

Bread and butter

Loadbalancers
Cache

### 4. Actual tech

Achieve the characteristics of System

ZooKeeper
s3

## 1. Client-server Model

Question: What happens when I type the URL and type enter in the browser?

*Client* is something a machine speak to server. *Server* is some machines listening to the clients. Browser is a client. Client doesn't know what the server is. It can only deduce by the response message.

### DNS Query

*DNS query* is used to find out the IP address. *DNS servers* are predetermined set of servers which act as a distributed database system. DNS also represents a protocol about how to query the IP address by domain name.

```bash
root@IVT-WKS-000223:~# dig algoexpert.io

; <<>> DiG 9.18.18-0ubuntu0.22.04.2-Ubuntu <<>> algoexpert.io
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 25720
;; flags: qr rd ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;algoexpert.io.                 IN      A

;; ANSWER SECTION:
algoexpert.io.          0       IN      A       35.202.194.70

;; Query time: 30 msec
;; SERVER: 172.24.64.1#53(172.24.64.1) (UDP)
;; WHEN: Tue Apr 09 19:29:09 CEST 2024
;; MSG SIZE  rcvd: 60
```

*IP address* is a **logically** unqiue identifier for a machine.

### HTTP Request

*Source address* of the request. Server use that address as sender address.
*Ports*, each machine has 16,000 ports. Which port should be use depends on the protocols we use. HTTP always use port 80. HTTPS uses 443.

---

Netcat example:

Server side

```bash
root@IVT-WKS-000223:~# nc -l 8081
Hi
this is an example for system design
```

Client side

```bash
root@IVT-WKS-000223:~# nc 127.0.0.1 8081
Hi
this is an example for system design
```

> If I use the mailbox analogy.

## 2. Network Protocols

*Protocol* is a set of **rules** for interactions between two pairs(Two machines). Format of these messages are defined in the protocols.

### IP

*Internet Protocol*: Modern internet mainly works on IP. IP packet is the fundamental unit(bytes).
*Segmentation*: IP packet is small.

Two main sections of IP packet (2^16 bytes)
- Header (20-60bytes)
  - Source add
  - Destination add
  - Total size of the packet
  - Version of the IP (IPv4, IPv6)
- Data

### TCP

Transmission control protocol.
Reliable way and ordered way to send IP packets.
TCP has handshakes. Timeout. In a nutshell.

### HTTP

Introduce a higher layer of abstraction for business logic. Only focus on request-response paradigm.

If you're building a large-scale system...

#### HTTP Request

HTTP method: POST, GET, ... describe the purpose of the request.
GET: retrieve data from server
POST: providing data for the server

with different methods and different path, different business logics occur.
`/` is called *slash*

Headers: key-value pairs for meta-data
Body: data part

#### HTTP Response

*StatusCode*: which is part of standard API standards...
404, 403

set endpoint on the server side: path+request_methode

```bash
curl localhost:3000/hello
```

use `curl` to send data to destination

```bash
curl --header 'content-type: application/json' localhost:3000/hello --data '{"foo": "bar"}'
``` 

... are just guidlines, 我们可以违反标准

## 3. Storage

To store data and retrieve data. Set/get, record/query, read/write, ...

opaque box, ...

Db is just a server. Different between process and service?

Distribued storage is useful when we don't want our system goes down when our database goes down.

Hundreds of database products, ... Some db provides you, gurantee you certain properties but there also exist trade-offs.

### Persistency

User assume the data will persist through any outage or issues that might occur in your system.

Power outage, crashes, core dump. Once everything is booted back up the data will still be there.

#### Disk

Non-voltaile storage.

#### Memory

Array, hash-table decleared in the code.

### Consistency

Crucial for distribued systems.  Stale data or most up-to-date version of data?

## 4. Latency and Throughput

Two mesures of the performance of a system.

Latency, how long it takes for a data to traverse a system. From one point in the system to another point in the system.

In client-server model, how long it take to send a request from client to server and getting the request from server.

When reading data from some storage devices(memory, disk, NFS...), the time used to read.

*Orders of the magnitude*: 数量级
Microsecond: 微秒
1 MB from cache, 250 microseconds

||||
|---|---|---|
|1 MB|memory|250 microsecond|
|1 MB|SSD|1,000 microsecond|
|1 MB|1 Gbps network|10,000 microsecond|
|1 MB|HDD|20,000 microsecond|

packet from CA --> Ne 150, 000 microsecond

electricity has to travel.
it just takes a while...

系统设计中系统延迟是很重要的参考因素。
requires instantaneous actions or things to happen. bad user experiences.
accuracy or uptime...

Video game, competing with people, lag in those types of video games.

---

Throughput: how much work a machine can perform in a given period of time. How much data can be transfered from on point in a system to another point of system. in a given amount of time. 

Like how many requests can the server handle in a given time? (多个客户端和服务器同时连接)

Latency and throughput are not correlated stuffs.   

What I am trying to say here is ... 

pay for more throughput

 GB/s

 How we mesure the throughput?

 ## 5. Availability

 How resistent a system is to the failures? How do you mesure it?

 The percentage of a system's uptime in a given year. 50% availability.

 Survive in the market.

 DB fails

= fault tolerance.

*operational* enough such that all of its primary functions are satisfied.

websites are down for a few hours, it would be upsetting for customers.

outage, GCP 

User hopes the website to be fully operational.

Any amount of complete downtime in the system would be unaccpectable.

### Nines

X nine(s) availability.

Ubi is 2 nines
deal with life and death scenarios.

5 nines is a gold standard.

### SLA/SLO

Service level agreement, service provider should tell the customers, we gurantee you this amount of availability.

Service level objective. 这些指标是很重要的，对于购买服务的客户来说。

Monthly uptime percentage

## References