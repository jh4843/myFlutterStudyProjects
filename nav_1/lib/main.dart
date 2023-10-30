import 'package:flutter/material.dart';
import 'package:nav_1/sub/first_detail.dart';
import 'package:nav_1/sub/third_detail.dart';
import 'package:nav_1/sub/second_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstDetail(),
        '/second': (context) => SecondDetail(),
        '/third': (context) => const ThirdDetail(),
      },
    );
  }
}
