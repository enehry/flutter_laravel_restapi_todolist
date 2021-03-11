import 'dart:convert';

import 'package:todo_list/model/todo.dart';

import 'package:http/http.dart' as http;

class TodoListApi {
  final apiUrl = Uri.http('localhost:8000', '/api/todos', {'q': 'http'});

  Future<List<Todo>> getTodo() async {
    http.Response res = await http.get(apiUrl);
    List<Todo> todoList = [];

    if (res.statusCode == 200) {
      var jsonResponse = jsonDecode(res.body);

      for (var data in jsonResponse) {
        todoList.add(Todo.fromJson(data));
      }
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }

    return todoList;
  }

  Future<int> store(Todo todo) async {
    http.Response res = await http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(todo.toJson()),
    );

    return res.statusCode;
  }

  Future<int> delete(int id) async {
    http.Response res = await http.delete(
      Uri.http('localhost:8000', '/api/todos/$id', {'q': 'http'}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    return res.statusCode;
  }

  Future<int> update(Todo todo) async {
    http.Response res = await http.put(
        Uri.http('localhost:8000', '/api/todos/${todo.id}', {'q': 'http'}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(todo.toJson()));

    return res.statusCode;
  }
}
