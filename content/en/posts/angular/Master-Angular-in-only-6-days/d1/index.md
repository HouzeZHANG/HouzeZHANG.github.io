---
title: "D1"
date: 2024-08-02T22:51:02+02:00
slug: 2024-08-02-d1
type: posts
draft: true
categories:
  - default
tags:
  - default
---

Angular

components: A TS class that controls a part of the user interface and handles associated business logic, components also have HTML template and css styles
services: handle data, restful api
modules: group components, encapsulate services

SPA: Single Page Application
Only update what's going to change, reduce the server load

Angular runs on web server, need Angular CLI to run the project, node package install nodejs and npm

npm: node package manager, npm is included in nodejs

```bash
sudo npm install @angular/cli@16.1.6 --location=global
ng v
```

```bash
ng new appointment-app
cd appointment-app
ng serve -o
```

hot reload mechanism: when you change the code, the browser will automatically reload

`angular.json`: configuration file
`package.json`: dependencies, the other developers can install the dependencies by `npm install`
components are the building blocks of Angular applications

```typescript
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'appointment-app';
}
```

The `selector` the HTML tag that will be used to render the component

框架会有开发模式和发布模式，发布模式会压缩代码（发布的`build`文件夹只有JS，CSS和HTML文件），开发模式会有更多的错误提示

### Components

One-way data binding: data flows from the component to the view

Create a new component:

```bash
ng generate component appointment-list
```

The component is declared in the single module

If we want to render this component, we should use tag in `app.component.html` file, and this file will be rendered in the `index.html` file

### TS

TypeScript is a superset of JavaScript, it's a statically typed language

It is similar to Java, C# and other statically typed languages

```typescript
class Appointment {
  id: number;
  name: string;
  email: string;
  phone: string;
  date: string;
  time: string;

  log(text: string): void {
    message: string = 'Hello' + text;
    console.log(text);
  }

  private pLog(text: string): void {
    message: string = 'Hello' + text;
    console.log(text);
  }

  sum(a: number, b: number) {
    return a + b;
  }
}
```

`export`关键字用于导出类，函数，变量等，可以在其他文件中使用和导入

One way data binding syntax: `{{}}`: double curly braces

- ts文件描述了数据，以及数据可以被某html文件使用的方式
- html文件描述了数据如何被展示，可以通过double curly braces来引用ts文件中的数据
- bing the data from ts file(component) to html file

Two way data binding will reflect the changes in the view back to the component

### One-way data binding

- `ng g component <component_name>`创建新的组件
- 组件TS文件中定义数据类型，以及数据的初始化
- `ng g interface models/appointment`创建新的接口
  - 用于定义数据类型
- 在component的html文件中使用数据

```typescript
export class AppointmentListComponent {
  
    appointment: Appointment = {
      id: 1,
      title: "Take dog for a walk",
      date: new Date('2024-08-03')
    }
}
```

### Two-way data binding

Allow us to use `FormsModule` in each component we declare here.

```typescript
@NgModule({
  declarations: [
    AppComponent,
    AppointmentListComponent
  ],
  imports: [
    BrowserModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
```

双向数据绑定意味着展示数据和js的数据是完全同步的，如果一个改变了，另一个也会改变
当你需要清空数据栏的时候，只需要在js里面对数据进行清零即可

### Visualize the list

`ul`tag means unordered list

hard code the list

```html
<ul>
  <li>Take dog for a walk</li>
  <li>Go to the gym</li>
  <li>Buy groceries</li>
</ul>
```

use `*ngFor` to loop through the list, with one-way data binding, because we only want to read the data from the js file

```html
<div>
    <input [(ngModel)]="newAppointmentTitle" placeholder="Appointment description">
    <input [(ngModel)]="newAppointmentDate" type="date" placeholder="Appointment date">
    <button (click)="addAppointment()">Add</button>
</div>

<ul>
    <li *ngFor="let appointment of appointments">
        {{appointment.id}} {{appointment.title}} {{appointment.date | date:'dd.MM.yyyy'}}
    </li>
</ul>
```

### Remove an item from the list

```html
<ul>
    <li *ngFor="let appointment of appointments; index as i">
        {{appointment.id}} {{appointment.title}} {{appointment.date | date:'dd.MM.yyyy'}}
        <button (click)="deleteAppointment(i)">Delete</button>
    </li>
</ul>
```

`splice` method is used to remove an/some item(s) from the list

```typescript
deleteAppointment(index: number){
  this.appointments.splice(index, 1)
}
```

### Local Storage

Local storage is a way to store data across sessions

Local storage只适合存少量数据，数据多的话，会出现性能问题，这时候要用数据库

在重新加载或者刷新页面的时候，需要将数据从本地存储中取出来，这一步是很关键的

Lifecycle hooks: 类似于回调

### Add Bootstrap

A css framework

`npm` is just download the package and put it into the `node_modules` folder

```bash
npm install bootstrap@5.3
```

Add `@import "~bootstrap/dist/css/bootstrap.min.css"` in `style.css` file and the format changes will be applied to the whole project