/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/multiple_navigator/router1/router1.dart';
import 'package:flutter/material.dart';
import 'package:rowlet/rowlet.dart';

import '../router2/router2.dart';

class MultipleNavigatorPage extends StatefulWidget {
  const MultipleNavigatorPage({super.key});

  @override
  State<MultipleNavigatorPage> createState() => _MultipleNavigatorPageState();
}

class _MultipleNavigatorPageState extends State<MultipleNavigatorPage> {
  late final ROwletNavigationService service1;
  late final ROwletNavigationService service2;

  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    service1 = ROwletNavigationService(routeBase: Router1(), initialRoute: '/page1');
    service2 = ROwletNavigationService(routeBase: Router2(), initialRoute: '/page1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiple Navigator')),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: service1.navigationKey.currentContext != null &&
                          (Navigator.of(service1.navigationKey.currentContext!)).canPop()
                      ? () {
                          setState(() {
                            currentPage--;
                            if (currentPage < 1) currentPage = 1;
                          });
                          Navigator.of(service1.navigationKey.currentContext!).pop();
                        }
                      : null,
                  icon: const Icon(Icons.navigate_before)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      currentPage++;
                      if (currentPage > 4) currentPage = 1;
                    });
                    Navigator.of(service1.navigationKey.currentContext!).pushNamed('/page$currentPage');
                  },
                  icon: const Icon(Icons.navigate_next)),
              const Text('Navigator 1 control'),
            ],
          ),
          SizedBox(
              height: 300,
              child: ROwletNavigator(
                key: service1.navigationKey,
                initialRoute: service1.initialRoute,
                observers: <NavigatorObserver>[service1.history, ...service1.routeObservers],
                onGenerateRoute: service1.onGenerateRoute,
                onPopPage: service1.onPopPage,
                onUnknownRoute: service1.onUnknownRoute,
              )),
          Expanded(
              child: ROwletNavigator(
            key: service2.navigationKey,
            initialRoute: service2.initialRoute,
            observers: <NavigatorObserver>[service2.history, ...service2.routeObservers],
            onGenerateRoute: service2.onGenerateRoute,
            onPopPage: service2.onPopPage,
            onUnknownRoute: service2.onUnknownRoute,
          )),
        ],
      ),
    );
  }
}
