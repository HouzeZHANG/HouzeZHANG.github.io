---
title: "Database System Concepts Note 1"
date: 2023-07-02T15:38:35+02:00
draft: false
tags: ["Database", "CMU 15-445", "Self learn"]
---

## Remark
This blog series share and document interesting points of knowledge and reflections that I noticed while studying the textbook [Database System Concepts (7th Edition)](https://www.db-book.com). This blog is the first chapter of this blog series.

## Data Abstraction

> View level. The highest level of abstraction describes only part of the entire database. Even though the logical level uses simpler structures, complexity remains because of the variety of information stored in a large database. Many users of the database system do not need all this information; instead, they need to access only a part of the database. The view level of abstraction exists to simplify their interaction with the system. The system may provide many views for the same database.[1]

## Instances and Schemas

> The *collection of information* stored in the database *at a particular moment* is called an *instance of the database*. The *overall design* of the database is called the *database schema*. The concept of database schemas and instances can be understood by analogy to a program written in a programming language. A database schema corresponds to the *variable declarations* (along with associated type definitions) in a program. Each variable *has a particular value at a given instant*. The values of the variables in a program at a point in time correspond to an instance of a database schema.[1]
>
> Database systems have several schemas, partitioned according to the levels of abstraction. The physical schema describes the database design at the physical level, while the logical schema describes the database design at the logical level. A database may also have several schemas at the view level, sometimes called subschemas, that describe different views of the database.[1]


## Database Constraints

> The DDL provides facilities to specify such constraints. The database system checks these constraints every time the database is updated. In general, a constraint can be an arbitrary predicate pertaining to the database. However, arbitrary predicates may be costly to test...[1]
> 
> Referential Integrity. There are cases where we wish to ensure that a value that appears in one relation for a given set of attributes also appears in a certain set of attributes in another relation (referential integrity).[1]

Data integrity is important, and the instructor who taught me database principles emphasized the need to check data integrity at the database level. Checking data by adding the CHECK keyword or foreign key checking is the responsibility of the database administrator and it is the last line of defense for the database. At the same time, database managers need to be aware of the overhead problems caused by adding constraints.

This reveals the relationship between foreign keys and indexes. If there is no index on the foreign key and a suitable data structure to support the insertion of a table containing a foreign key, the data integrity check may result in a full table scan without index support, thus reducing insertion and modification performance.

## DDL and Metadata

> The processing of DDL statements, just like those of any other programming language, generates some output. The output of the DDL is placed in the data dictionary, which contains metadata—that is, data about data. The data dictionary is considered to be a special type of table that can be accessed and updated only by the database sys- tem itself (not a regular user). The database system consults the data dictionary before reading or modifying actual data.

Metadata这个概念在很多地方都被提及，在文件系统中，无论是传统的文件系统，还是像Ceph一样的软件定义存储，都有metadata的身影。而DDL语句则生成了metadata

## Two Types of DML

> There are basically two types of data-manipulation language: Procedural DMLs require a user to specify what data are needed and how to get those data. Declarative DMLs(also referred to as non procedural DMLs) require a user to specify what data are needed without specifying how to get those data.

## Parsing and execution

> The levels of abstraction that we discussed in Section 1.3 apply not only to defining or structuring data, but also to manipulating data. At the physical level, we must define algorithms that allow efficient access to data. At higher levels of abstraction, we emphasize ease of use. The goal is to allow humans to interact efficiently with the system. The query processor component of the database system (which we study in Chapter 15 and Chapter 16) translates DML queries into sequences of actions at the physical level of the database system. In Chapter 22, we study the processing of queries in the increasingly common parallel and distributed settings.

## ODBC and JDBC

> SQL also does not support actions such as input from users, output to displays, or communication over the network. Such computations and actions must be written in a host language, such as C/C++, Java, or Python, with embedded SQL queries that access the data in the database. Application programs are programs that are used to interact with the database in this fashion.
>
> To access the database, DML statements need to be sent from the host to the database where they will be executed. This is most commonly done by using an application-program interface (set of procedures) that can be used to send DML and DDL statements to the database and retrieve the results. The Open Database Connectivity (ODBC) standard defines application program interfaces for use with C and several other languages. The Java Database Connectivity (JDBC) standard defines a corresponding interface for the Java language.

## Modules of DB!

> A database system is partitioned into modules that deal with each of the responsibilities of the overall system. The functional components of a database system can be broadly divided into the *storage manager*, the *query processor components*, and the *transaction management component*.

### 1. Storage Manager

> Since the main memory of computers cannot store this much information, and since the contents of main memory are lost in a system crash, the information is stored on disks. Data are moved between disk storage and main memory as needed. Since the movement of data to and from disk is slow relative to the speed of the central processing unit, it is imperative that the database system structure the data so as to minimize the need to move data between disk and main memory.

### 2. Query Processor

> The query processor is important because it helps the database system to simplify and facilitate access to data. The query processor allows database users to obtain good performance while being able to work at the view level and not be burdened with understanding the physical-level details of the implementation of the system. It is the job of the database system to translate updates and queries written in a nonprocedural language, at the logical level, into an efficient sequence of operations at the physical level.

### 3. Transaction Manager

> The transaction manager is important because it allows application developers to treat a sequence of database accesses as if they were a single unit that either happens in its entirety or not at all. This permits application developers to think at a higher level of abstraction about the application without needing to be concerned with the lower-level details of managing the effects of concurrent access to the data and of system failures.[1]

## ACID

> An exam- ple is a funds transfer, as in Section 1.2, in which one account A is debited and another account B is credited. Clearly, it is essential that either both the credit and debit occur, or that neither occur. That is, the funds transfer must happen in its entirety or not at all. This all-or-none requirement is called atomicity. In addition, it is essential that the execution of the funds transfer preserves the consistency of the database. That is, the value of the sum of the balances of A and B must be preserved. This correctness requirement is called consistency. Finally, after the successful execution of a funds transfer, the new values of the balances of accounts A and B must persist, despite the possibility of system failure. This persistence requirement is called durability.[1]

## NoSQL vs SQL

> The lack of a high-level query language based on the relational model gave programmers greater flexibility to work with new types of data. The lack of traditional database systems’ support for strict data consistency provided more flexibility in an application’s use of distributed data stores. The NoSQL model of “eventual consistency” allowed for distributed copies of data to be inconsistent as long they would eventually converge in the absence of further updates.[1]
>
> The limitations of NoSQL systems, such as lack of support for consistency, and lack of support for declarative querying, were found acceptable by many ap- plications (e.g., social networks), in return for the benefits they provided such as scalability and availability. However, by the early 2010s it was clear that the limitations made life significantly more complicated for programmers and database administrators. As a result, these systems evolved to provide features to support stricter notions of consistency, while continuing to support high scalability and availability. Additionally, these systems increasingly support higher levels of abstraction to avoid the need for programmers to have to reimplement features that are standard in a traditional database system.[1]

---

## Structure of Relational Database

> A relational database consists of a collection of tables, each of which is assigned a unique name. 
>
> Thus, in the relational model the term relation is used to refer to a table, while the term tuple is used to refer to a row. Similarly, the term attribute refers to a column of a table.

## References

