import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_app.dart';

import 'sub/add_todo.dart';
import 'sub/clear_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(database),
        '/add': (context) => AddTodoApp(database),
        '/clear': (context) => ClearListApp(database)
      },
    );
  }

  Future<Database> initDatabase() async {
    String databasePath = join(await getDatabasesPath(), 'todo_database.db');
    print('Database Path: $databasePath');

    return openDatabase(
      databasePath,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title TEXT, content TEXT, active INTEGER)",
        );
      },
      version: 1,
    );
  }
}
