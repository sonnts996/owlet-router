/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/main.dart';
import 'package:example/src/items/items_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomeActionItem(
                descriptions:
                    'If you are login, the Profile Page will be opened. Otherwise, RouteGuard will redirect to the Login Page.',
                onPressed: () {
                  navigatorServices.root.auth.profile.pushNamed(context);
                },
                icon: CupertinoIcons.profile_circled,
                buttonLabel: 'Profile',
              ),
              HomeActionItem(
                descriptions: 'Open List Items Page. Another way to find your route is RouteBase.of.',
                onPressed: () {
                  // navigatorServices.root.items.list.pushNamed(context);
                  RouteBase.of<ListItemRoute>(context, depthSearch: true).list.pushNamed(context);
                },
                icon: CupertinoIcons.list_bullet,
                buttonLabel: 'List Items',
              ),
              HomeActionItem(
                descriptions:
                    "Open  [Item 1]'s Detail Page. At the same time, the List Items Page is opened, under Detail Page.",
                onPressed: () {
                  navigatorServices.root.items.detail.pushNamed(context, args: 'Item 1');
                },
                icon: CupertinoIcons.bookmark_fill,
                buttonLabel: 'Detail',
              ),
              HomeActionItem(
                descriptions: "Open an Undefined route",
                onPressed: () {
                  Navigator.pushNamed(context, '/any_undefined_route');
                },
                icon: CupertinoIcons.nosign,
                buttonLabel: 'Unknown Page',
              ),
              HomeActionItem(
                descriptions: "Open a Replacement Page, that is used for testing the Navigator.replacement",
                onPressed: () {
                  navigatorServices.root.replacementSegments.replacement.pushNamed(context, args: 'from home');
                },
                icon: CupertinoIcons.rectangle_stack,
                buttonLabel: 'Replacement',
              ),
              HomeActionItem(
                descriptions:
                    "A Dynamic Page Route, that means the route path is not existed in the router until upgrade.",
                onPressed: () {
                  navigatorServices.root.dynamicRoute.premiumPage.pushNamed(context);
                },
                icon: CupertinoIcons.lock,
                buttonLabel: 'Dynamic Route',
              ),
              HomeActionItem(
                descriptions: "Demo using multiple navigator in a Page.",
                onPressed: () {
                  navigatorServices.root.multiple.multiplePage.pushNamed(context);
                },
                icon: Icons.account_tree,
                buttonLabel: 'Multiple Navigator',
              ),
              HomeActionItem(
                descriptions: "Open a Dialog by router",
                onPressed: () {},
                icon: CupertinoIcons.app_badge,
                buttonLabel: 'Dialog Route',
              ),
              HomeActionItem(
                descriptions: "Open a Bottom Sheet by router",
                onPressed: () {},
                icon: CupertinoIcons.bubble_middle_bottom,
                buttonLabel: 'Bottom Sheet',
              ),
              HomeActionItem(
                descriptions: "Call a function by router",
                onPressed: () {},
                icon: Icons.functions,
                buttonLabel: 'Function Route',
                moreActions: [
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.app_badge, size: 20),
                      label: const Text('Dialog')),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.bubble_middle_bottom, size: 20),
                      label: const Text('Bottom Sheet')),
                ],
              ),
            ]),
      ),
    );
  }
}

class HomeActionItem extends StatelessWidget {
  const HomeActionItem({
    super.key,
    required this.descriptions,
    required this.onPressed,
    required this.buttonLabel,
    required this.icon,
    this.moreActions = const [],
  });

  final String descriptions;

  final VoidCallback onPressed;
  final IconData icon;
  final String buttonLabel;
  final List<Widget> moreActions;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(descriptions),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(onPressed: onPressed, icon: Icon(icon, size: 20), label: Text(buttonLabel)),
                ...moreActions
              ]),
        ),
      ),
    );
  }
}
