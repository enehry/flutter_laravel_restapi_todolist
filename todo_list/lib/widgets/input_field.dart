import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/provider/todo_provider.dart';
import 'package:todo_list/services/todo_list_api.dart';

class InputField extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Todo todo = context.watch<TodoProvider>().todo;
    if (todo != null) {
      _contentController.text = todo.content;
      _titleController.text = todo.title;
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                validator: (val) =>
                    val.isNotEmpty ? null : 'Title must not be empty',
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Body',
                      alignLabelWithHint: true),
                  maxLines: 11,
                  minLines: 11,
                  validator: (val) =>
                      val.isNotEmpty ? null : 'Body must not be empty'
                  //validatePassword,        //Function to check validation
                  ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Clear'),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF313131),
                      primary: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (todo == null) {
                          int response = await TodoListApi().store(
                            Todo(
                              title: _titleController.text,
                              content: _contentController.text,
                              createdAt: '',
                              updatedAt: '',
                              isDone: false,
                            ),
                          );

                          if (response == 201) {
                            print('success');
                          }
                        } else {
                          print(
                            await context.read<TodoProvider>().updateData(
                                  Todo(
                                      id: todo.id,
                                      content: _contentController.text,
                                      title: _contentController.text,
                                      isDone: todo.isDone),
                                ),
                          );
                          context.read<TodoProvider>().update(null);
                        }
                      }
                      _contentController.text = '';
                      _titleController.text = '';

                      context.read<TodoProvider>().refreshList();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: todo == null ? Text('Save') : Text('Update'),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF313131),
                      primary: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
