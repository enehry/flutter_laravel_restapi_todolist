import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/todo_provider.dart';
import 'package:todo_list/screen/home_screen.dart';

void main() {
  runApp(TodoList());
}

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            headline1: GoogleFonts.lato(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
            bodyText1: GoogleFonts.robotoCondensed(
                fontSize: 16.0, fontWeight: FontWeight.w300),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
