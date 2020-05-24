//-----------------------------------------------------------
// Mobile Application Programming (SCSJ3623)
// Semester 2, 2019/2020
// Exercise 3: HTTP and JSON
//
// Name 1:  ......
// Name 2:  ......
//-----------------------------------------------------------

// TODO 1 - Toggle the status of the todo  when the user is pressing on the ListTile. This operation also updates the data on the server
// TODO 2 - Remove the todo  when the user is long-pressing on the ListTile. This operation also deletes the data from the server
// TODO 3 - Add a new todo  to the server when the user is pressing on the plus (+) button. The id for the newly created todo is given by the server

import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../models/data.dart' as data;
import '../services/data_service.dart';


class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo List'),
      ),
      body: ListView.separated(
        itemCount: data.globalTodoList.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.blueGrey,
        ),
        itemBuilder: (context, index) {
          final Todo _todo = data.globalTodoList[index];
          return ListTile(
            title: Text(_todo.title,
                style: TextStyle(
                    decoration: _todo.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
            subtitle: Text('id: ${_todo.id}'),
            onTap: () {
              dataService.updateTodoStatus();
            },
            onLongPress: () {
              dataService.deleteTodo();
            dataService.delete();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          dataService.post();
          dataService.createTodo();
        },
      ),
    );
  }
}
