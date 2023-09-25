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
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton.icon(
            onPressed: () {
              appNavigatorServices.routeBase.item.list.pushNamed(context);
            },
            icon: const Icon(CupertinoIcons.list_bullet),
            label: const Text('List Items'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/any_undefine_route');
            },
            icon: const Icon(CupertinoIcons.nosign),
            label: const Text('Page not found'),
          )
        ]),
      ),
    );
  }
}
