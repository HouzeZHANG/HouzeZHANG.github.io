---
title: "Sql"
date: 2024-07-30T18:07:38+02:00
slug: 2024-07-30-sql
type: posts
draft: true
categories: ["Database"]
tags: ["SQL", "Database"]
---

## Introduction

The SQL language is used to access and manipulate databases. SQL is an ANSI (American National Standards Institute) standard language, but there are many different versions of the SQL language.

The aim of this article is to provide a comprehensive guide to SQL and serve as a reference for SQL queries. The majority of the examples are from LeetCode.

---

## Representation

### Rename Table

Use `select` to rename table.

```sql
select (...) as (...);
```

### Rename Field

Use `select` to rename field.

```sql
select S as New from table;
```

### Filter Fields

Use `select` to filter fields.

```sql
select S1, S2, S3, ... from table;
```

---

## Field Type

### Enum Type

Use `=` to compare enum type.

```sql
select * from table where tp = 'A';
```

### NULL Type

Use `is null` to compare null type.

```sql
select * from table where tp is null;
```

### NOT NULL Type

Use `is not null` to compare not null type.

```sql
select * from table where tp is not null;
```

### OR Logic

```sql
select name from Customer
where referee_id is null or referee_id != 2
```

## Top N from X offset (Second Highest Salary)

Use `limit` to get top N from X offset.

```sql
select * from table order by S desc limit N offset X;
```

## Math

### `round()`

Use `round()` to round numbers.

Keep 3 decimal places.

```sql
select

a.machine_id as machine_id, round(avg(b.timestamp - a.timestamp), 3) as processing_time

from Activity as a
join Activity as b
on a.activity_type = 'start' and b.activity_type = 'end' and a.machine_id = b.machine_id and a.process_id = b.process_id

group by machine_id
```

## Aggregation and Grouping

### Group By

Use `group by` to group by fields.

```sql
select S1, S2, ... from table group by S1, S2, ...;
```

### Having

Use `having` to filter groups.

```sql
select S1, S2, ... from table group by S1, S2, ... having S1 > N;
```

### Count

Use `count` to count fields.

```sql
select count(S) from table;
```

```sql
select S1, count(S2) from table group by S1;
```

### Sum

Use `sum` to sum fields.

```sql
select sum(S) from table;
```

After `group by`, `select` can only contain fields in `group by` or aggregation functions.

```sql
select S1, sum(S2) from table group by S1;
```

## SubQuery (Find Managers with at least 5 Direct Reports)

```sql
 select name from employee where id in 
 (select managerId from (select id,managerId,name,COUNT(id) as number_of_report from Employee group by managerId ) as New where New.number_of_report>=5)
```

## Join

### Inner Join

[https://leetcode.com/problems/employees-earning-more-than-their-managers/](https://leetcode.com/problems/employees-earning-more-than-their-managers/)

Use `join` + `on` to join tables.

If the condition is not met, the record will not be displayed.

```sql
select a.name as Employee
from Employee as a
join Employee as b
on a.managerId = b.id
where a.salary > b.salary
```

### Outer Join

[https://leetcode.com/problems/combine-two-tables/](https://leetcode.com/problems/combine-two-tables/)

Use `left join` or `right join` to outer join tables.

The aim of outer join is to keep all records in the left table. If there is no match in the right table, the result is `null`.

```sql
select a.name as Employee
from Employee as a
left join Employee as b
on a.managerId = b.id
where a.salary > b.salary
```

---

## Date and Time

### Date

#### `add_date()`

```sql
Select w1.id from Weather w1 join Weather w2 
on w1.recordDate = date_add(w2.recordDate, interval 1 day)
where w1.temperature > w2.temperature;
```

---

## Window Function

```sql
-- Select the department name, employee name, and salary
SELECT 
    d.name AS Department, 
    emp.name AS Employee, 
    emp.salary 
FROM (
    -- Select all columns from employee and add a rank based on salary within each department
    SELECT 
        employee.*, 
        DENSE_RANK() OVER (PARTITION BY departmentid ORDER BY salary DESC) AS rnk 
    FROM 
        employee
) AS emp
-- Join the department table to get the department name
LEFT JOIN 
    department AS d 
    ON d.id = emp.departmentid
-- Filter to get only the top 3 salaries per department
WHERE 
    emp.rnk <= 3;
```

### Dense Rank, Rank, and Row Number

- `DENSE_RANK()`: Returns the rank of rows within the partition of a result set, without any gaps in the ranking.
- `RANK()`: Returns the rank of rows within the partition of a result set, with gaps in the ranking where there are ties.
- `ROW_NUMBER()`: Returns a unique number for each row starting from 1.
