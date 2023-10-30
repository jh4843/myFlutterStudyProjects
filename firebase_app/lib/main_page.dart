import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import './sub/tabs_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.analytics, required this.observer})
      : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _MainPageState createState() => _MainPageState(analytics, observer);
}

class _MainPageState extends State<MainPage> {
  _MainPageState(this.analytics, this.observer);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  String _message = '';

  void _setMessage(String message) {
    setState(
      () {
        _message = message;
      },
    );
  }

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'hello flutter',
        'int': 100,
      },
    );

    _setMessage('Successfully sent [test_event]');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              color: Colors.deepPurple,
              onPressed: _sendAnalyticsEvent,
              child: const Text(
                'Test',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(_message, style: const TextStyle(color: Colors.blueAccent)),
            ElevatedButton(
              onPressed: () {
                _setMessage("");
              },
              child: const Icon(Icons.restore_page_outlined),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.tab),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              settings: const RouteSettings(name: '/tabs'),
              builder: (BuildContext context) {
                return TabsPage(observer);
              },
            ),
          );
        },
      ),
    );
  }
}
