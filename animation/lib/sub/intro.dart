import 'package:flutter/material.dart';
import './animation_app.dart';
import './saturn_loading.dart';
import 'dart:async';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<StatefulWidget> createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 10), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AnimationApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Animation App'),
              const SizedBox(
                height: 20,
              ),
              SaturnLoading()
            ],
          ),
        ),
      ),
    );
  }
}
