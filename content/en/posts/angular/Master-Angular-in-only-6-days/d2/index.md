---
title: "D2"
date: 2024-08-04T10:34:35+02:00
slug: 2024-08-04-d2
type: posts
draft: true
categories:
  - default
tags:
  - default
---

## Architecture of the application

- make reservation
- list reservations
- update reservation
- delete reservation

CRUD operations

Simple crud restful api

Router 负责路由，根据URL显示不同的组件
Home Component负责显示主页
ReservationForm Component负责显示预约表单
ReservationListComponent Component负责显示预约列表
ReservationService 负责处理数据

```bash
ng g component home --module home
```

Component can only be declared in one module 这个是独占的，一个component只能从属于一个module，但是一个module可以包含多个component

创建一个独立的service，但是把他放在reservation文件夹下

```bash
ng g service reservation/reservation
```

创建interface

```bash
ng g i models/reservation
```

一般定义数据格式都是先从`interface`开始

## Router

在`app-routing.module.ts`中定义路由

```typescript
const routes: Routes = [
    {path:"", component: HomeComponent},
    {path:"list", component: ReservationListComponent},
    {path:"new", component:ReservationFormComponent}
];
```

## Navigation Menu

需要在`app-routing.module.ts`中导入其他modules，这样router就可以找到其他的components

在主页面添加按钮，以导航到其他页面

```html
<div>
    <h2>
        Welcome to the Hotel Reservation System!
    </h2>
    <button [routerLink]="['/new']">Create a new reservation</button>
    <button>View all reservations</button>
</div>
```

