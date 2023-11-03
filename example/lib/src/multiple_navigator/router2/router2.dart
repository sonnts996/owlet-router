/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key, required this.pageName, this.currentPage = 1});

  final String pageName;
  final int currentPage;

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pageName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ElevatedButton(
            child: const Text('Next'),
            onPressed: () {
              var currentPage = widget.currentPage + 1;
              if (currentPage > 4) currentPage = 1;

              Navigator.of(context).pushNamed('/page$currentPage');
            },
          ),
        ),
      ),
    );
  }
}

class Router2 extends RouteBase {
  Router2() : super.root();

  final page1 = MaterialRouteBuilder(
    '/page1',
    pageBuilder: (context, settings) {
      return Page2(pageName: settings.name!, currentPage: 1);
    },
  );

  final page2 = MaterialRouteBuilder(
    '/page2',
    pageBuilder: (context, settings) {
      return Page2(pageName: settings.name!, currentPage: 2);
    },
  );

  final page3 = MaterialRouteBuilder(
    '/page3',
    pageBuilder: (context, settings) {
      return Page2(pageName: settings.name!, currentPage: 3);
    },
  );

  final page4 = MaterialRouteBuilder(
    '/page4',
    pageBuilder: (context, settings) {
      return Page2(pageName: settings.name!, currentPage: 4);
    },
  );

  @override
  List<RouteBase> get children => [page1, page2, page3, page4];
}
