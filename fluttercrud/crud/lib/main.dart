import 'package:crud/screens/todo_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Logic Dependent Dropdown',
      //theme: ThemeData(

      //primarySwatch: Colors.amber,
      // ),
      home: TodoList(),
    );
  }
}
