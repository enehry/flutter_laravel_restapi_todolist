import 'package:flutter/material.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/services/todo_list_api.dart';

class TodoProvider extends ChangeNotifier {
  Future<List<Todo>> _list;

  void populate() {
    _list = TodoListApi().getTodo();
  }

  Future<List<Todo>> get todoList => _list;

  void refreshList() {
    _list = TodoListApi().getTodo();
    notifyListeners();
  }

  Future<String> delete(int id) async {
    int response = await TodoListApi().delete(id);
    refreshList();

    return response.toString();
  }

  Todo _todo;

  void update(Todo todo) {
    _todo = todo;
    notifyListeners();
  }

  Todo get todo => _todo;

  Future<String> updateData(Todo todo) async {
    print('ok1');
    int response = await TodoListApi().update(todo);
    print('ok2');

    return response.toString();
  }
}
