//-----------------------------------------------------------
// Mobile Application Programming (SCSJ3623)
// Semester 2, 2019/2020
// Exercise 3: HTTP and JSON
//
// Name 1:  KEVIN THIEN YOU HENG
// Name 2:  MUHAMMAD HAFIZI BIN MD ZULKEFLEE
//-----------------------------------------------------------
import 'dart:convert';
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
     final http.Response response = await http.post('$baseUrl/$endpoint',
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
    final json = await get('todos');
    return (json as List).map((item) => Todo.fromJson(item)).toList();
  }

  // TODO 6: Complete this method. It is meant for updating the status of a given TODO  (whether is completed or not) in the server
  Future<Todo> updateTodoStatus({int id, bool status}) async {
    final json = await patch('todos/$id',data:{'completed':status});
    return Todo.fromJson(json);
  }

  // TODO 7: Complete this method. It is meant for creating a new TODO  in the server
  Future<Todo> createTodo({Todo todo}) async {
    final json = await post('todos/',data:{'title':todo.title,'completed':todo.completed});
    return Todo.fromJson(json);
  }

  // TODO 8: Complete this method. It is meant for deleting a given TODO  from the server
  Future<Todo> deleteTodo({int id}) async {
    final json = await delete('todos/$id');
    return Todo.fromJson(json);
  }
}

final dataService = DataService();
