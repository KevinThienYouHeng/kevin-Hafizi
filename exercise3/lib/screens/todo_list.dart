//-----------------------------------------------------------
// Mobile Application Programming (SCSJ3623)
// Semester 2, 2019/2020
// Exercise 3: HTTP and JSON
//
// Name 1:  KEVIN
// Name 2:  HAFIZI
//-----------------------------------------------------------

// TODO 1 - Toggle the status of the todo  when the user is pressing on the ListTile. This operation also updates the data on the server
// TODO 2 - Remove the todo  when the user is long-pressing on the ListTile. This operation also deletes the data from the server
// TODO 3 - Add a new todo  to the server when the user is pressing on the plus (+) button. The id for the newly created todo is given by the server

import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/data_service.dart';


class TodoListScreen extends StatefulWidget {
   @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
Future<Map<String,dynamic>> _futureData;

List<Todo> todo;

@override
void initState(){
  super.initState();
  //_futureData = dataService.getTodoList(1);
}


  @override
  Widget build(BuildContext context){
    return FutureBuilder<Map<String,dynamic>>(
    future: _futureData,
    builder: (context,snapshot){
      if(snapshot.hasData){
        todo = snapshot.data['todo'];

        return _buildMainScreen();
      }
      return _buildFetchingDataScreen();
    });

  }

  Scaffold _buildMainScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo List'),
      ),
      body: ListView.separated(
        itemCount: todo.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.blueGrey,
        ),
        itemBuilder: (context, index) {
          final Todo _todo = todo[index];
          return ListTile(
            title: Text(_todo.title,
                style: TextStyle(
                    decoration: _todo.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
            subtitle: Text('id: ${_todo.id}'),
            onTap: () {
               //                TODO 1             //
              dataService.updateTodoStatus(
              id: status.id, completed: status.completed );
            },
            onLongPress: () {
               //                TODO 2             //
              dataService.deleteTodo(id; Todo.id);
                          },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
           //                TODO 3             //
          dataService.createTodo(
          id: Todo.id, status: Todo.status );
        },
      ),
    );
  }

  Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching data in progress'),
          ],
        ),
      ),
    );
  }


}//class _TodoListScreenState
