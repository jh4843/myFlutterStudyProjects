import 'package:flutter/material.dart';
import 'dart:math' as math;

class SliverPage extends StatefulWidget {
  const SliverPage({super.key});

  @override
  State<StatefulWidget> createState() => _SliverPage();
}

class _SliverPage extends State<SliverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            //floating: true,
            //snap: true,
            //stretch: true,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Sliver Example'),
              background: Image.asset('assets/images/sunny.png'),
            ),
            backgroundColor: Colors.deepOrangeAccent,
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _HeaderDelegate(
              minHeight: 50,
              maxHeight: 150,
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sliver List Items',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                customCard('List Item 1'),
                customCard('List Item 2'),
                customCard('List Item 3'),
                customCard('List Item 4'),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _HeaderDelegate(
              minHeight: 50,
              maxHeight: 150,
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sliver Grid Items',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildListDelegate(
              [
                customCard('1'),
                customCard('2'),
                customCard('3'),
                customCard('4'),
              ],
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          ),
        ],
      ),
    );
  }

  Widget customCard(String text) {
    return Card(
      child: SizedBox(
        height: 120,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(fontSize: 40),
        )),
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _HeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate) {
    if (maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child) return true;

    return false;
  }
}
