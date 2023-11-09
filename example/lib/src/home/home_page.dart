/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/home/tabs/home_tab_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(debugLabel: 'HomeScaffold');
  final int currentIndex = 1;
  late final tabService = NavigationService(
    navigationKey: GlobalKey(),
    root: HomeTabRoute('/'),
    initialRoute: '/',
  );

  @override
  void initState() {
    super.initState();
    tabService.history.addListener(() {
      print(tabService.history);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: const Text('Home'), leading: const SizedBox.shrink(), centerTitle: true),
      drawer: Drawer(
          child: ListView(
        children: const [
          ListTile(
            title: Text('Item 1'),
          ),
          ListTile(
            title: Text('Item 2'),
          ),
          ListTile(
            title: Text('Item 3'),
          ),
          ListTile(
            title: Text('Item 4'),
          ),
          ListTile(
            title: Text('Item 5'),
          ),
          ListTile(
            title: Text('Item 6'),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            switch (value) {
              case 0:
                scaffoldKey.currentState?.openDrawer();
                break;
              case 1:
                tabService.pushNamed(route: tabService.root.homeTab);
                break;
              case 2:
                tabService.pushNamed(route: tabService.root.profileTab);
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.line_horizontal_3), label: 'Menu'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), label: 'Profile'),
          ]),
      body: OwletNavigator.from(tabService),
    );
  }
}
