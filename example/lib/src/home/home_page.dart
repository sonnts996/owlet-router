/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/main_routes.dart';
import 'package:example/src/home/home_tab_route.dart';
import 'package:example/src/home/widgets/document.dart';
import 'package:example/src/widgets/ui_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:owlet_router/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.initialRoute,
    required this.service,
  });

  final String initialRoute;
  final NavigationService<HomeTabRoute> service;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey(debugLabel: 'HomeScaffold');

  NavigationService<HomeTabRoute> get tabService => widget.service;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      tabService.history.addListener(onTabChanged);
    });
  }

  @override
  void dispose() {
    tabService.history.removeListener(onTabChanged);
    super.dispose();
  }

  void onTabChanged() {
    if (tabService.route.homeTab.isRoute(tabService.history.current)) {
      setState(() {
        currentIndex = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return UILayout(
        child: OwletNavigator(tabService),
        builder: (context, isOnDesktopMode, child) => Scaffold(
              key: scaffoldKey,
              drawer: isOnDesktopMode
                  ? null
                  : Drawer(child: Documents(onTab: onSectionTab)),
              body: isOnDesktopMode
                  ? Row(children: [
                      DesktopDrawerDocument(
                          onDocumentTab: onSectionTab,
                          onNavigateTab: onNavigateTab),
                      Expanded(child: child!),
                    ])
                  : child!,
              bottomNavigationBar: isOnDesktopMode
                  ? null
                  : BottomNavigationBar(
                      currentIndex: currentIndex,
                      onTap: onNavigateTab,
                      type: BottomNavigationBarType.fixed,
                      items: const [
                          BottomNavigationBarItem(
                              icon: Icon(CupertinoIcons.line_horizontal_3),
                              label: 'Menu'),
                          BottomNavigationBarItem(
                              icon: Icon(CupertinoIcons.home), label: 'Home'),
                          BottomNavigationBarItem(
                              icon: Icon(CupertinoIcons.info_circle),
                              label: 'About'),
                          BottomNavigationBarItem(
                              icon: Icon(CupertinoIcons.profile_circled),
                              label: 'Author'),
                        ]),
            ));
  }

  void onNavigateTab(int index) {
    switch (index) {
      case 0:
        scaffoldKey.currentState?.openDrawer();
        break;
      case 1:
        tabService.route.homeTab.pushNamed();
        break;
      case 3:
        RouteBase.of<MainRoute>(context).profile.pushNamed();
        break;
    }
  }

  void onSectionTab(String name) {
    // tabService.pushNamed(path: name);
    Navigator.of(context, rootNavigator: true).pushNamed('/home$name');
  }
}
