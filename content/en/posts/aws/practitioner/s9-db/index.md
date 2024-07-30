---
title: "AWS-CCP Section9: Database Services"
date: 2024-07-29T23:37:28+02:00
slug: 2024-07-29-s9-db
type: posts
draft: false
categories: ["AWS"]
tags: ["AWS", "Database", "Storage"]
---

## Introduction

AWS support two types of storage services: unstructured storage services, such as EFS, EBS, S3, EC2 Instance Store; structured storage services, such as RDS. The latter supports SQL, which provides indexing and query functions.

The characteristics of NoSQL are more flexible, easy to iterate, support **horizontal scaling (scale-out)**, and high performance. The disadvantages are that it does not support transactions, joins, complex queries, and ACID. Typical examples are DynamoDB and various KV databases.

This blog serves as a summary of the database services provided by AWS.

---

## RDS (Relational Database Service)

- Support MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, Aurora
- Cannot SSH into RDS instances

### Aurora

- Proprietary database
- Cheaper but faster

### Aurora Serverless

- Auto-scaling based on load
- Access through Proxy Fleet
- Shared Volume
- No management overhead

### Snapshot

- A backup of the database
- Restore, rollback, copy

### Replication

#### Read Replication

- Separate read and write traffic
- **High availability**

#### Multi-AZ Replication

- **High availability**
- Only one standby(failover)
- Only master is read/write

#### Cross-Region Replication

- **Disaster Recovery**
- Reduce Latency
- Extra cost

---

## ElastiCache

- A cache layer supporting any database

---

## DynamoDB

- Serverless
- Millisecond latency
- Million QPS
- IA (Infrequent Access)

### DynamoDB Accelerator (DAX)

- DynamoDB's cache service, which can improve read performance
- Reduce latency to microseconds

### Global Table

- Global Table
  - Active-Active replication
  - Any Region write will propagate to all other Regions

---

## DocumentDB

- AWS's MongoDB
- Auto scaling

---

## Redshift

- Based on PostgreSQL
- OLAP Service
- Columnar storage
- Support QuickSight, Tableau
- Support MPP (Massively Parallel Processing)
- Support serverless (Redshift Query Editor)

---

## EMR (Elastic MapReduce)

- Hadoop service managing hundreds of EC2 instances
- Support Spark, HBase, Presto, Flink

---

## Athena

- Use SQL to query S3
- Serverless

---

## Neptune

- Graph database
- Use cases
  - Social networking
  - Knowledge graphs(Wikipedia)
  - Recommendation engines

---

## TimeStream

- Time series database
- 1000 times faster than relational databases
- 1/10th the cost of relational databases
- Built-in analytics

---

## QLDB (Quantum Ledger Database)

- Recording financial transactions
- Serverless
- Immutable: cryptographically verifiable
- Centralized: single source of truth

## Managed Blockchain

- Decentralized ledger
- Compatible with Hyperledger Fabric and Ethereum
- Can join public networks / create private networks

---

## Glue

- ETL service: extract, transform, load
- Serverless

## DMS (Database Migration Service)

- Hot migration: no downtime
- Homogeneous migration: same database
- Heterogeneous migration: different database

## QuickSight

- Serverless BI tool
- Machine learning integration
