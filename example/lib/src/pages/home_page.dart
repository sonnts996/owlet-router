/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rowlet/rowlet.dart';

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
              ElevatedButton.icon(
                  onPressed: () {
                    navigatorServices.routeBase.auth.profile.pushNamed(context);
                  },
                  icon: const Icon(CupertinoIcons.profile_circled),
                  label: const Text('Profile')),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () {
                  navigatorServices.routeBase.items.list.pushNamed(context);
                },
                icon: const Icon(CupertinoIcons.list_bullet),
                label: const Text('List Items'),
              ),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () {
                  navigatorServices.routeBase.items.detail.pushNamed(context, args: 'Items 0');
                },
                icon: const Icon(CupertinoIcons.bookmark_fill),
                label: const Text('Detail Route'),
              ),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/any_undefine_route');
                },
                icon: const Icon(CupertinoIcons.nosign),
                label: const Text('Page not found'),
              ),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () {
                  navigatorServices.routeBase.replacementSegments.replacement.pushNamed(context, args: 'from home');
                },
                icon: const Icon(CupertinoIcons.rectangle_stack),
                label: const Text('Replacement'),
              ),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () {
                  navigatorServices.routeBase.dynamicRoute.premiumPage.pushNamed(context);
                },
                icon: const Icon(CupertinoIcons.rectangle_stack),
                label: const Text('Dynamic Route'),
              ),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () {
                  navigatorServices.routeBase.dynamicRoute.upgrade.pushNamed(context);
                },
                icon: const Icon(CupertinoIcons.rectangle_stack),
                label: const Text('Update Dynamic Route'),
              ),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () {
                  navigatorServices.routeBase.multiple.multiplePage.pushNamed(context);
                },
                icon: const Icon(Icons.account_tree),
                label: const Text('Multiple Navigator'),
              ),
            ]),
      ),
    );
  }
}
