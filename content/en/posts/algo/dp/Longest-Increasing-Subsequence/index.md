---
title: "Longest Increasing Subsequence"
date: 2024-07-31T11:04:51+02:00
slug: 2024-07-31-longest-increasing-subsequence
type: posts
draft: false
categories: ["Interview"]
tags: ["DP"]
---

## Introduction

LIS (Longest Increasing Subsequence) is a classic problem in dynamic programming. The problem is to find the length of the longest subsequence of a given sequence such that all elements of the subsequence are sorted in increasing order.

The subsequence is not necessarily contiguous or unique. The length of the subsequence is the number of elements in it.

For example:

```plaintext
Input: [10, 9, 2, 5, 3, 7, 101, 18]

Output: 4

Explanation: The longest increasing subsequence is [2, 3, 7, 101], therefore the length is 4.
```

## Dynamic Programming

This solution is to use dynamic programming to solve the problem.

$$

dp[i] = \max(dp[i], dp[j] + 1)

$$

where $0 \leq j < i$ and $nums[j] < nums[i]$.

```python
def lis(nums):

    if not nums:
        return 0

    n = len(nums)
    dp = [1] * n
    for i in range(n):
        for j in range(i):
            if nums[j] < nums[i]:
                dp[i] = max(dp[i], dp[j] + 1)
    return max(dp)
```

## Real World Example

```plaintext
Input: [-1, 9, 0, 8, -5, 6, -24]

Output: 3

Explanation: The longest increasing subsequence is [-1, 0, 8] or [-1, 0, 6], therefore the length is 3.
```
