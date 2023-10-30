import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import './model/todo.dart';

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;
  const DatabaseApp(this.db, {super.key});

  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {
  Future<List<Todo>>? todoList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Example'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await Navigator.of(context).pushNamed('/clear');
              setState(() {
                todoList = getTodos();
              });
            },
            icon: const Icon(Icons.list),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  print("none");
                  return const CircularProgressIndicator();
                case ConnectionState.waiting:
                  print("waiting");
                  return const CircularProgressIndicator();
                case ConnectionState.active:
                  print("active");
                  return const CircularProgressIndicator();
                case ConnectionState.done:
                  print("done");
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Todo todo = (snapshot.data as List<Todo>)[index];
                        return ListTile(
                          title: Text(
                            todo.title!,
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Container(
                            child: Column(
                              children: <Widget>[
                                Text(todo.content!),
                                Text(
                                    '체크 : ${todo.active == 1 ? 'true' : 'false'}'),
                                Container(
                                  height: 1,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                          onTap: () async {
                            TextEditingController contentController =
                                TextEditingController(text: todo.content!);
                            Todo result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('${todo.id} : ${todo.title}'),
                                    content: Column(
                                      children: [
                                        TextField(
                                          controller: contentController,
                                          decoration: const InputDecoration(
                                              labelText: 'Todo'),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              todo.content =
                                                  contentController.text;
                                              todo.active == 1
                                                  ? todo.active = 0
                                                  : todo.active = 1;
                                            });
                                            Navigator.of(context).pop(todo);
                                          },
                                          child: const Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(todo);
                                          },
                                          child: const Text('No')),
                                    ],
                                  );
                                });
                            _updateTodo(result);
                          },
                          onLongPress: () async {
                            Todo result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('${todo.id} : ${todo.title}'),
                                    content: Text(
                                        'Do you want to delete ${todo.content}?'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(todo);
                                          },
                                          child: const Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No')),
                                    ],
                                  );
                                });
                            _deleteTodo(result);
                          },
                        );
                      },
                      itemCount: (snapshot.data as List<Todo>).length,
                    );
                  } else {
                    return const Text('No data');
                  }
                default:
                  return const CircularProgressIndicator();
              }
            },
            future: todoList,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final todo = await Navigator.of(context).pushNamed('/add');
              if (todo != null) {
                _insertTodo(todo as Todo);
              }
            },
            heroTag: null,
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              _updateAllNotActive();
            },
            heroTag: null,
            child: const Icon(Icons.update),
          ),
        ],
      ),
    );
  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> queryRes = await database.query('todos');

    List<Todo> res = List.generate(queryRes.length, (i) {
      int active = queryRes[i]['active'] == 1 ? 1 : 0;
      return Todo(
          title: queryRes[i]['title'].toString(),
          content: queryRes[i]['content'].toString(),
          active: active,
          id: queryRes[i]['id']);
    });

    return res;
  }

  void _insertTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      todoList = getTodos();
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.update(
      'todos',
      todo.toMap(),
      where: 'id = ? ',
      whereArgs: [todo.id],
    );
    setState(() {
      todoList = getTodos();
    });
  }

  void _updateAllNotActive() async {
    final Database database = await widget.db;
    await database.rawUpdate('update todos set active=0');
    setState(() {
      todoList = getTodos();
    });
  }

  void _deleteTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.delete('todos', where: 'id=?', whereArgs: [todo.id]);
    setState(() {
      todoList = getTodos();
    });
  }
}
