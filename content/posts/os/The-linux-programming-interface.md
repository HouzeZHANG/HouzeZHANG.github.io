---
title: "Linux Programming Interface Chapter14"
date: 2023-07-02T15:24:50+02:00
draft: true
tags: ["OS"]
---

# System Programming Concepts

“Whenever we make a system call or call a library function, we should always check the return status of the call in order to determine if it was successful.” ([Kerrisk, 2010, p. 43](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=87&annotation=3WKQUCWC))

## 3.1 System Calls

“A system call is a controlled entry point into the kernel, allowing a process to request that the kernel perform some action on the process’s behalf.” ([Kerrisk, 2010, p. 43](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=87&annotation=TMCERDCU))

“The kernel makes a range of services accessible to programs via the system call application programming interface (API).” ([Kerrisk, 2010, p. 43](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=87&annotation=BRNRRY5M))

“A system call changes the processor state from user mode to kernel mode, so that the CPU can access protected kernel memory.” ([Kerrisk, 2010, p. 44](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=88&annotation=Z485LD77))

“The set of system calls is fixed. Each system call is identified by a unique number. (This numbering scheme is not normally visible to programs, which identify system calls by name.)” ([Kerrisk, 2010, p. 44](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=88&annotation=N6X46TD8))

“Each system call may have a set of arguments that specify information to be transferred from user space (i.e., the process’s virtual address space) to kernel space and vice versa.” ([Kerrisk, 2010, p. 44](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=88&annotation=VD3PYBJT))

“From a programming point of view, invoking a system call looks much like calling a C function. However, behind the scenes, many steps occur during the execution of a system call.” ([Kerrisk, 2010, p. 44](zotero://select/library/items/CW77TP4Y)) ([pdf](zotero://open-pdf/library/items/P9T2JPZU?page=88&annotation=9PKK4HDU))