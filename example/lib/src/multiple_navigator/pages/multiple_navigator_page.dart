/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

import '../router1/router1.dart';
import '../router2/router2.dart';

class MultipleNavigatorPage extends StatefulWidget {
  const MultipleNavigatorPage({super.key});

  @override
  State<MultipleNavigatorPage> createState() => _MultipleNavigatorPageState();
}

class _MultipleNavigatorPageState extends State<MultipleNavigatorPage> {
  late final NavigationService service1;
  late final NavigationService service2;

  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    service1 = NavigationService(root: Router1(), initialRoute: '/page1');
    service2 = NavigationService(root: Router2(), initialRoute: '/page1');
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
              child: Navigator(
                key: service1.navigationKey,
                initialRoute: service1.initialRoute,
                observers: <NavigatorObserver>[service1.history, ...service1.routeObservers],
                onGenerateRoute: service1.onGenerateRoute,
                onPopPage: service1.onPopPage,
                onUnknownRoute: service1.onUnknownRoute,
              )),
          const Divider(),
          Expanded(child: OwletNavigator.from(service2)),
        ],
      ),
    );
  }
}
