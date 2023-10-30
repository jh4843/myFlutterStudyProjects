import 'package:flutter/material.dart';
import '../model/people.dart';
import './second_page.dart';

class AnimationApp extends StatefulWidget {
  const AnimationApp({super.key});

  @override
  State<AnimationApp> createState() => _AnimationAppState();
}

class _AnimationAppState extends State<AnimationApp> {
  List<People> peoples = List.empty(growable: true);
  int current = 0;

  Color _weightColor = Colors.blue;

  double _opacity = 1; // 1: visible, 0: invisible

  @override
  void initState() {
    peoples.add(People("John", 170, 60));
    peoples.add(People("Mary", 149, 88));
    peoples.add(People("Jane", 160, 50));
    peoples.add(People("James", 180, 20));
    peoples.add(People("Didi", 188, 30));
    peoples.add(People("Jenny", 150, 10));

    super.initState();
  }

  void _changeWeightColor(double weightValue) {
    if (weightValue < 40) {
      _weightColor = Colors.blueAccent;
    } else if (weightValue < 60) {
      _weightColor = Colors.indigo;
    } else if (weightValue < 80) {
      _weightColor = Colors.indigo;
    } else {
      _weightColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Animation App"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 2),
                child: SizedBox(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: Text('name: ${peoples[current].name}'),
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        curve: Curves.bounceIn,
                        color: Colors.amber,
                        width: 50,
                        height: peoples[current].height,
                        child: Text(
                          'height: ${peoples[current].height}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeInCubic,
                        color: _weightColor,
                        width: 50,
                        height: peoples[current].weight,
                        child: Text(
                          'weight: ${peoples[current].weight}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        curve: Curves.linear,
                        color: Colors.pinkAccent,
                        width: 50,
                        height: peoples[current].bmi,
                        child: Text(
                          'bmi: ${peoples[current].bmi.toString().substring(0, 2)}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (current < peoples.length - 1) {
                      current++;
                    }
                    _changeWeightColor(peoples[current].weight);
                  });
                },
                child: const Text("Next"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (current > 0) {
                      current--;
                    }
                    _changeWeightColor(peoples[current].weight);
                  });
                },
                child: const Text("Previous"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _opacity == 1 ? _opacity = 0 : _opacity = 1;
                  });
                },
                child: _opacity == 1
                    ? const Text("Disappear")
                    : const Text("Appear"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SecondPage()));
                },
                child: const SizedBox(
                  width: 200,
                  child: Row(
                    children: <Widget>[
                      Hero(tag: 'detail', child: Icon(Icons.cake)),
                      Text('Move Second Page')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
