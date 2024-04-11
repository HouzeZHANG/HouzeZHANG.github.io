---
title: "Swarm"
date: 2024-04-11T11:43:15Z
draft: true
tags: ["default"]
---

How solo developer automate contianer lifecycle.
Scale out/in/down/up?
Recreate if they fail?
Replace containers without downtime (blue/green deploy)?

2016 Swarm needs of container. Swarmkit toolkit.  

Swarm mode is a clustering solution built inside the docker.
Orchestrate the lifecycle.

What is the raft database?

## Basic Concepts

### Manager-worker Arch.

#### Manager Node

A worker has permission to control the swarm, having api, orchestrator, allocator, scheduler and dispatcher.

#### Worker Node

Worker + Executor

#### Control plan

How orders get sent around the swarm.

### Service vs Tasks

Single service can have multiple tasks. Each task will launch a container. Manager will think about where to place those nodes.

### RAFT

A protocol ensures consistency across multiple nodes.

## Hands-on

### docker swarm init

swarm use raft db as config db.

### docker node ls

### docker service *

Replace docker run in docker swarm. Previous one is used in single node situation.

`docker service create alpine ping 8.8.8.8`

## docker service ls

## docker service update

Change the config

## References