//-----------------------------------------------------------
// Mobile Application Programming (SCSJ3623)
// Semester 2, 2019/2020
// Exercise 3: HTTP and JSON
//
// Name 1:  KEVIN
// Name 2:  HAFIZI
//-----------------------------------------------------------
import 'dart:convert';
//import 'package:rest_client/rest_client.http' as http;
import 'package:http/http.dart' as http;
import '../models/todo.dart';


class DataService {
  static const String baseUrl =
      'http://192.168.0.139:3000'; // Change the IP address to your PC's IP. Remain the port number 3000 unchanged.

  // TODO 1: Complete this method. It is an helper for the HTTP GET request
  Future get(String endpoint) async {
     final response = await http.get('$baseUrl/$endpoint',
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
    }

  // TODO 2: Complete this method. It is an helper for the HTTP POST request
  Future post(String endpoint, {dynamic data}) async {
     final response = await http.post('$baseUrl/$endpoint',
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // TODO 3: Complete this method. It is an helper for the HTTP PATCH request
  Future patch(String endpoint, {dynamic data}) async {
    final response = await http.patch('$baseUrl/$endpoint',
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // TODO 4: Complete this method. It is an helper for the HTTP DELETE request
  Future delete(String endpoint) async {
    final response = await http.delete('$baseUrl/$endpoint',
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // TODO 5: Complete this method. It is meant for getting the list of TODO s from the server
  Future<List<Todo>> getTodoList() async {
   List<Todo> todoList = [];

    Response response = await TodoUtils.getTodoList();
    print("Title is ${response.statusCode}");
    print("Description is ${response.body}");

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var results = body["results"];

      for (var todo in results) {
        todoList.add(Todo.fromJson(todo));
      }

    } else {
      //Handle error
    }

    return todoList;
  }
  

  // TODO 6: Complete this method. It is meant for updating the status of a given TODO  (whether is completed or not) in the server
  Future<Todo> updateTodoStatus({int id, bool status}) async {
    final json = await patch('todo/$id/$status');
    json['title'] = await patch(
        Todo,where "id=?", where status "status=?", whereArgs: [todo.id] ); 

    return Todo.fromJson(json);
  }

  // TODO 7: Complete this method. It is meant for creating a new TODO  in the server
  Future<Todo> createTodo({Todo todo}) async {
     final json = await post('todos/$todo');
    json['title'] = await post(
        Todo, todo.toMap()
    ); 

    return Todo.fromJson(json);
  }

  // TODO 8: Complete this method. It is meant for deleting a given TODO  from the server
  Future<Todo> deleteTodo({int id}) async {
    final json = await delete('todos/$id');
    json['title'] = await delete(
        Todo, where: 'id=?', whereArgs:[id]
    ); 

    return Todo.fromJson(json);
  }
}

final dataService = DataService();
