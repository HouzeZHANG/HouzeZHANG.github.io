---
title: "Hands-on gdb"
date: 2023-07-04T13:02:54+02:00
draft: false
tags: ["gdb", "CMU-15445"]
---

### Background

I read [this blog](https://www.cs.cmu.edu/~gilpin/tutorial/) when I was doing [CMU15445-Project0](https://15445.courses.cs.cmu.edu/spring2023/project0/), mainly providing a hands-on way to learn gdb. This post is a brief summary for this blog, appending my bug-free code for the example source code.

### Highlights

- `gdb [prog_name]` is used to load program waited to be debugged into gdb.  
- In the gdb prompt, we can `run` prog or `quit` gdb.
- `break [function name]` will set breakpoint at certain function.  
Ex: `break LinkedList<int>::remove` will set a breakpoint on the LinkedList<int>::remove method  
- `condition [N] [condition]` will will add a conditional constraint to the breakpoint (make conditional breakpoints)  
Ex: `condition 1 item_to_remove == 1` means that when the breakpoint 1 is reached, gdb will terminate the program only when item_to_remove == 1  
- `step` will step into the function.  
- `next` is used to skip the function call, not stepping into the function.

### Assignment

The example `main.cc` which is provided by author is a demo for linked list. The following source code is the **bug-free** version, without memory-leak. You can find the original code [here](https://www.cs.cmu.edu/~gilpin/tutorial/main.cc).

```c++
// main.cc
// Andrew Gilpin
// agg1@cec.wustl.edu

// This file contains the example program used in the gdb debugging
// tutorial. The tutorial can be found on the web at
// http://students.cec.wustl.edu/~agg1/tutorial/

#include <iostream>
using namespace std;

int number_instantiated = 0;

template <class T>
class Node {
public:
  Node (const T &value, Node<T> *next = 0) : value_(value), next_(next) {
    cout << "Creating Node, "
         << ++number_instantiated
         << " are in existence right now" << endl;
  }
  ~Node () {
    cout << "Destroying Node, "
         << --number_instantiated
         << " are in existence right now" << endl;
    next_ = 0;
  }

  Node<T>* next () const { return next_; }
  void next (Node<T> *new_next) { next_ = new_next; };
  const T& value () const { return value_; }
  void value (const T &value) { value_ = value; }

private:
  Node ();
  T value_;
  Node<T> *next_;
};

template <class T>
class LinkedList {
public:
  LinkedList () : head_(0) {};
  ~LinkedList () { delete_nodes (); };

  // returns 0 on success, -1 on failure
  int insert (const T &new_item) {
    return ((head_ = new Node<T>(new_item, head_)) != 0) ? 0 : -1;
  }

  // returns 0 on success, -1 on failure
  int remove (const T &item_to_remove) {
    Node<T> *marker = head_;
    Node<T> *temp = 0;  // temp points to one behind as we iterate

    while (marker != 0) {
      if (marker->value() == item_to_remove) {
        if (temp == 0) { // marker is the first element in the list
          if (marker->next() == 0) {
            head_ = 0;
            delete marker; // marker is the only element in the list
            marker = 0;
          } else {
//          head_ = new Node<T>(marker->value(), marker->next());
            head_ = marker->next();
            delete marker;
            marker = 0;
          }
          return 0;
        } else {
          temp->next (marker->next());
//          delete temp;
          delete marker;
          marker = 0;
          return 0;
        }
      }
//      marker = 0;  // reset the marker
      temp = marker;
      marker = marker->next();
    }

    return -1;  // failure
  }

  void print (void) {
    Node<T> *marker = head_;
    while (marker != 0) {
      cout << marker->value() << endl;
      marker = marker->next();
    }
  }

private:
  void delete_nodes (void) {
    Node<T> *marker = head_;
    while (marker != 0) {
      Node<T> *temp = marker;
      delete marker;
      marker = temp->next();
    }
  }

  Node<T> *head_;
};

int main (int argc, char **argv) {
  LinkedList<int> *list = new LinkedList<int> ();

  list->insert (1);
  list->insert (2);
  list->insert (3);
  list->insert (4);

  cout << "The fully created list is:" << endl;
  list->print ();

  cout << endl << "Now removing elements:" << endl;
  list->remove (4);
  list->print ();
  cout << endl;

  list->remove (1);
  list->print ();
  cout << endl;

  list->remove (2);
  list->print ();
  cout << endl;

  list->remove (3);
  list->print ();

  delete list;

  return 0;
}
```

### References

https://www.cs.cmu.edu/~gilpin/tutorial/