import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class TabsPage extends StatefulWidget {
  const TabsPage(this.observer, {super.key});

  final FirebaseAnalyticsObserver observer;

  @override
  State<StatefulWidget> createState() => _TabsPage(observer);
}

class _TabsPage extends State<TabsPage>
    with SingleTickerProviderStateMixin, RouteAware {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  _TabsPage(this.observer);

  final FirebaseAnalyticsObserver observer;
  TabController? _controller;
  int selectedIndex = 0;

  final List<Tab> tabs = <Tab>[
    const Tab(
      text: 'No. 1',
      icon: Icon(Icons.looks_one),
    ),
    const Tab(
      text: 'No. 2',
      icon: Icon(Icons.looks_two),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      length: tabs.length,
      initialIndex: selectedIndex,
    );
    _controller!.addListener(
      () {
        setState(
          () {
            if (selectedIndex != _controller!.index) {
              selectedIndex = _controller!.index;
              _sendCurrentTab();
            }
          },
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    observer.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: tabs.map(
          (Tab tab) {
            return Center(child: Text(tab.text!));
          },
        ).toList(),
      ),
    );
  }

  void _sendCurrentTab() {
    analytics.setCurrentScreen(
      screenName: 'tab/$selectedIndex',
    );
  }
}
