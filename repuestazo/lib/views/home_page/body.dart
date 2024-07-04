import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.currentIndex,
    required this.pages,
  });

  final int currentIndex;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: currentIndex,
      children: pages,
    );
  }
}
