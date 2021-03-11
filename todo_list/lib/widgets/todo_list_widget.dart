import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/provider/todo_provider.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({
    Key key,
  }) : super(key: key);

  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().populate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50.0),
      child: FutureBuilder<List<Todo>>(
        future: context.watch<TodoProvider>().todoList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: ListTile(
                        onLongPress: () {
                          context
                              .read<TodoProvider>()
                              .update(snapshot.data[index]);
                          print('pressed');
                        },
                        isThreeLine: true,
                        leading: snapshot.data[index].isDone
                            ? Icon(Icons.check)
                            : Icon(Icons.close),
                        title: Text('${snapshot.data[index].title}',
                            style: Theme.of(context).textTheme.headline1),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMEd().format(DateTime.parse(
                                  snapshot.data[index].createdAt)),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 10.0),
                            ),
                            Text(
                              '${snapshot.data[index].content}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            print(await context
                                .read<TodoProvider>()
                                .delete(snapshot.data[index].id));
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container(
              child: Text('No data'),
            );
          }
        },
      ),
    );
  }
}
