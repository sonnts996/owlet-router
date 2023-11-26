/*
 Created by Thanh Son on 21/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:objectx/objectx.dart';

class Documents extends StatelessWidget {
  const Documents({
    super.key,
    required this.onTab,
  });

  final void Function(String name) onTab;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ListView(children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Documents',
                style: Theme.of(context).textTheme.labelMedium)),
        ListTile(
            leading: const Icon(Icons.directions, size: 20),
            title: const Text('Navigation Service'),
            onTap: () {
              onTab('/navigation-service#');
            }),
        const Divider(indent: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ListTile(
              leading: SvgPicture.asset(
                "assets/logo_owlet.svg",
                height: 20,
                fit: BoxFit.fitHeight,
                color: Theme.of(context).iconTheme.color,
              ),
              title: const Text('Owlet Navigator'),
              onTap: () {
                onTab('/navigation-service#owlet-navigator');
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ListTile(
              leading: const Icon(CupertinoIcons.link, size: 20),
              title: const Text('Nested Navigator'),
              onTap: () {
                onTab('/navigation-service#Nested-navigator');
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ListTile(
              leading: const Icon(Icons.api_rounded, size: 20),
              title: const Text('Provider'),
              onTap: () {
                onTab('/navigation-service#provider');
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ListTile(
              leading: const Icon(Icons.history, size: 20),
              title: const Text('History'),
              onTap: () {
                onTab('/navigation-service#history');
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ListTile(
              leading: const Icon(Icons.history, size: 20),
              title: const Text('Unknown Route'),
              onTap: () {
                onTab('/navigation-service#unknown-route');
              }),
        ),
        const Divider(),
        ListTile(
            leading: const Icon(Icons.route, size: 20),
            title: const Text('Route'),
            onTap: () {
              onTab('/route');
            }),
        const Divider(indent: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ListTile(
              leading: const Icon(Icons.account_tree_rounded, size: 20),
              title: const Text('Route Builder'),
              onTap: () {
                onTab('/route#route-builder');
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ListTile(
              leading: const Icon(Icons.alt_route_rounded, size: 20),
              title: const Text('Route Guard'),
              onTap: () {
                onTab('/route#route-guard');
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ListTile(
              leading: const Icon(Icons.functions, size: 20),
              title: const Text('Named Function'),
              onTap: () {
                onTab('/route#named-function');
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ListTile(
              leading: const Icon(Icons.link, size: 20),
              title: const Text('Nested Service'),
              onTap: () {
                onTab('/route#nested-service');
              }),
        ),
        const Divider(),
        ListTile(
            leading: const Icon(Icons.widgets, size: 20),
            title: const Text('Other'),
            onTap: () {
              onTab('/other');
            }),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ListTile(
              leading: const Icon(Icons.troubleshoot, size: 20),
              title: const Text('Troubleshoot'),
              onTap: () {
                onTab('/route#troubleshoot');
              }),
        ),
      ]);
    });
  }
}

class DesktopDrawerDocument extends StatelessWidget {
  const DesktopDrawerDocument({
    super.key,
    required this.onDocumentTab,
    required this.onNavigateTab,
    this.currentIndex = 0,
  });

  final int currentIndex;
  final ValueChanged<String> onDocumentTab;
  final ValueChanged<int> onNavigateTab;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).let(
          (it) => it.copyWith(
              listTileTheme: ListTileThemeData(
                  titleTextStyle: it.textTheme.labelMedium,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  selectedColor: Colors.white),
              textTheme: it.textTheme
                  .apply(bodyColor: Colors.white, displayColor: Colors.white),
              iconTheme: it.iconTheme.copyWith(color: Colors.white),
              dividerTheme: const DividerThemeData(color: Colors.white12)),
        ),
        child: Container(
          width: 300,
          color: Colors.indigo,
          child: Column(children: [
            const SizedBox(height: 16),
            ListTile(
                leading: SvgPicture.asset(
                  "assets/logo_owlet.svg",
                  height: 32,
                  fit: BoxFit.fitHeight,
                  color: Colors.white,
                ),
                title: Text('Owlet Router',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.apply(color: Colors.white))),
            const SizedBox(height: 16),
            Container(
                color: currentIndex == 1 ? Colors.indigoAccent : null,
                child: ListTile(
                  leading: const Icon(CupertinoIcons.home, size: 20),
                  onTap: () => onNavigateTab(1),
                  title: const Text('Home'),
                  selected: currentIndex == 1,
                )),
            Container(
                color: currentIndex == 2 ? Colors.indigoAccent : null,
                child: ListTile(
                  leading: const Icon(CupertinoIcons.info_circle, size: 20),
                  onTap: () => onNavigateTab(2),
                  title: const Text('About'),
                  selected: currentIndex == 2,
                )),
            Container(
                color: currentIndex == 3 ? Colors.indigoAccent : null,
                child: ListTile(
                  leading: const Icon(CupertinoIcons.profile_circled, size: 20),
                  onTap: () => onNavigateTab(3),
                  title: const Text('Author'),
                  selected: currentIndex == 3,
                )),
            const Divider(),
            Expanded(child: Documents(onTab: onDocumentTab)),
          ]),
        ));
  }
}
