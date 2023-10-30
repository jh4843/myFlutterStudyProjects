import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './large_file_main.dart';

class FileApp extends StatefulWidget {
  const FileApp({super.key});

  @override
  State<StatefulWidget> createState() => _FileApp();
}

class _FileApp extends State<FileApp> {
  List<String> itemList = List.empty(growable: true);
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    var result = await readListFile();
    setState(() {
      itemList.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Example'),
        actions: <Widget>[
          TextButton(
            // set this button color is red
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LargeFileMain();
                  },
                ),
              );
            },
            child: const Text(
              '로고 바꾸기',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Center(
                        child: Text(
                          itemList[index],
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    );
                  },
                  itemCount: itemList.length,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          writeFruit(controller.value.text);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('File Example'),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           const Text(
  //             'You have pushed the button this many times:',
  //           ),
  //           Text(
  //             '$_count',
  //             style: Theme.of(context).textTheme.headlineMedium,
  //           ),
  //           ElevatedButton(
  //             onPressed: _resetCounter,
  //             child: const Text("Reset"),
  //           ),
  //         ],
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         setState(() {
  //           _count++;
  //           writeCountFile(_count);
  //         });
  //       },
  //       child: const Icon(Icons.add),
  //     ),
  //   );
  // }

  // void writeCountFile(int count) async {
  //   var dir = await getApplicationDocumentsDirectory();
  //   print('writeCountFile: ${dir.path}');
  //   File('${dir.path}/count.txt').writeAsStringSync(count.toString());
  // }

  // void readCountFile() async {
  //   try {
  //     var dir = await getApplicationDocumentsDirectory();
  //     var file = await File('${dir.path}/count.txt').readAsString();
  //     print(file);
  //     setState(() {
  //       _count = int.parse(file);
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //}

  Future<List<String>> readListFile() async {
    List<String> itemList = List.empty(growable: true);
    var key = "first";
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? firstCheck = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File('${dir.path}/fruit.txt').exists();

    if (firstCheck == null || firstCheck == false || fileExist == false) {
      pref.setBool(key, true);
      var file =
          await DefaultAssetBundle.of(context).loadString('repo/fruits.txt');

      File('${dir.path}/fruits.txt').writeAsStringSync(file);
      var array = file.split("\n");
      for (var item in array) {
        print(item);
        itemList.add(item);
      }
      return itemList;
    } else {
      var file = await File('${dir.path}/fruits.txt').readAsString();
      var array = file.split("\n");
      for (var item in array) {
        print(item);
        itemList.add(item);
      }
      return itemList;
    }
  }

  void writeFruit(String fruit) async {
    var dir = await getApplicationDocumentsDirectory();
    var file = await File('${dir.path}/fruits.txt').readAsString();
    file = '$file\n$fruit';
    File('${dir.path}/fruits.txt').writeAsStringSync(file);

    setState(() {
      itemList.add(controller.value.text);
    });
  }
}
