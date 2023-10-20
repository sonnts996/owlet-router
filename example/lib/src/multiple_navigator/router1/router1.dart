/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:rowlet/rowlet.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(16.0),
    );
  }
}

class Router1 extends OriginRoute {
  final page1 = MaterialRouteBuilder(
    '/page1',
    pageBuilder: (context, settings) {
      return const Page1(color: Colors.red);
    },
  );

  final page2 = MaterialRouteBuilder(
    '/page2',
    pageBuilder: (context, settings) {
      return const Page1(color: Colors.blue);
    },
  );

  final page3 = MaterialRouteBuilder(
    '/page3',
    pageBuilder: (context, settings) {
      return const Page1(color: Colors.yellow);
    },
  );

  final page4 = MaterialRouteBuilder(
    '/page4',
    pageBuilder: (context, settings) {
      return const Page1(color: Colors.orange);
    },
  );

  @override
  List<RouteSegment> get children => [page1, page2, page3, page4];
}
