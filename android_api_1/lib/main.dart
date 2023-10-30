import './main/android_native_app.dart';
import './main/cupertino_native_app.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const CupertinoApp(
        home: CupertinoNativeApp(),
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AndroidNativeApp(),
      );
    }
  }
}
