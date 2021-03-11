import 'package:flutter/material.dart';
import 'package:todo_list/responsive.dart';
import 'package:todo_list/widgets/input_field.dart';
import 'package:todo_list/widgets/todo_list_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: Container(),
        tablet: Container(),
        desktop: Center(
          child: Card(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 1500,
                maxHeight: 700,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: InputField(),
                    ),
                    Expanded(
                      flex: 4,
                      child: TodoListWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
