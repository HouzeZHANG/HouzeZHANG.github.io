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

### HTTP

## References