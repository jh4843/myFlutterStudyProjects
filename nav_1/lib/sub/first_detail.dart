import 'package:flutter/material.dart';

class FirstDetail extends StatefulWidget {
  const FirstDetail({super.key});

  @override
  State<StatefulWidget> createState() => _FirstDetail();
}

class _FirstDetail extends State<FirstDetail> {
  List<String> todoList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    todoList.add('당근 사오기');
    todoList.add('약 사오기');
    todoList.add('청소하기');
    todoList.add('부모님께 전화드리기');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Detail Example'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              child: Text(
                todoList[index],
                style: const TextStyle(fontSize: 30),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/third', arguments: todoList[index]);
              },
            ),
          );
        },
        itemCount: todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNavigation(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNavigation(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/second');
    if (result == null || result == "") return;
    setState(() {
      todoList.add(result as String);
    });
  }
}
