---
title: "Cannot Bind to NgModel"
date: 2024-08-04T10:08:07+02:00
slug: 2024-08-04-cannot-bind-to-ngmodel
type: posts
draft: true
categories:
  - default
tags:
  - default
---

下面这段代码运行的时候会报错：

```html
<div>
    <input [(ngModel)]="newBookTitle" placeholder="Book title">
    <input [(ngModel)]="newBookAuthor" placeholder="Book author">
    <button (click)="addBook()">Add Book</button>
</div>
```

报错信息是：
```bash
Build at: 2024-08-04T08:05:37.121Z - Hash: 9765d09becf880ee - Time: 524ms

Error: src/app/book/book.component.html:4:12 - error NG8002: Can't bind to 'ngModel' since it isn't a known property of 'input'.
```

解决方法是在`app.module.ts`中引入`FormsModule`模块：

```typescript
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    AppComponent,
    BookComponent
  ],
  imports: [
    BrowserModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
```