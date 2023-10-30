import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import "../model/todo.dart";

class AddTodoApp extends StatefulWidget {
  final Future<Database> db;
  const AddTodoApp(this.db, {super.key});

  @override
  State<StatefulWidget> createState() => _AddTodoApp();
}

class _AddTodoApp extends State<AddTodoApp> {
  TextEditingController? _titleController;
  TextEditingController? _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add todo'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: '제목'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(labelText: '할일'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Todo todo = Todo(
                      title: _titleController!.value.text,
                      content: _contentController!.value.text,
                      active: 0);
                  Navigator.of(context).pop(todo);
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
