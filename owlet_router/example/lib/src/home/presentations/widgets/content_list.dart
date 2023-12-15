/*
 Created by Thanh Son on 21/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/icon_widget.dart';
import '../../domain/interfaces/metadata_interface.dart';

class ContentList extends StatelessWidget {
  const ContentList({
    required this.onTab,
    required this.metaData,
    super.key,
    this.currentPath,
    this.currentFragment,
  });

  final void Function(String name, PageInterface page) onTab;
  final MetaDataInterface metaData;
  final String? currentPath;
  final String? currentFragment;

  @override
  Widget build(BuildContext context) => ListView(children: [
        ...metaData.pages.fold([], (previousValue, element) {
          final list = [
            ListTile(
                leading: IconWidget(iconUrl: element.label.icon, size: 20),
                title: Text(element.label.label),
                selected: '/t${element.label.segment}' == currentPath,
                onTap: () {
                  onTab(element.label.segment, element);
                }),
            ...element.items.where((e) => e.label.isNotEmpty).map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ListTile(
                      leading: const SizedBox(
                          width: 20,
                          child: Icon(Icons.circle_outlined, size: 6)),
                      minLeadingWidth: 10,
                      title: Text(e.label),
                      selected: '/t${element.label.segment}' == currentPath &&
                          e.fragment == currentFragment,
                      onTap: () {
                        onTab('${element.label.segment}${e.fragment}', element);
                      },
                    ),
                  ),
                ),
            if (element.items.isNotEmpty) const Divider(),
          ];
          return [...previousValue, ...list];
        }),
      ]);
}

class DesktopDrawer extends StatelessWidget {
  const DesktopDrawer({
    required this.onDocumentTab,
    required this.onNavigateTab,
    required this.metaData,
    super.key,
    this.currentPath,
    this.currentFragment,
  });

  final void Function(String name, PageInterface page) onDocumentTab;
  final ValueChanged<int> onNavigateTab;
  final MetaDataInterface metaData;
  final String? currentPath;
  final String? currentFragment;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Container(
          width: 300,
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(CupertinoIcons.home, size: 20),
                  onTap: () => onNavigateTab(1),
                  title: const Text('Home'),
                  selected: currentPath == '/',
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.profile_circled, size: 20),
                  onTap: () => onNavigateTab(2),
                  title: const Text('Author'),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 8, bottom: 0, right: 16, top: 16),
                    child: Text('Documents',
                        style: Theme.of(context).textTheme.labelMedium)),
                const Divider(),
                Expanded(
                    child: ContentList(
                  onTab: onDocumentTab,
                  metaData: metaData,
                  currentFragment: currentFragment,
                  currentPath: currentPath,
                )),
                const SizedBox(height: 16),
              ]),
        ),
      );
}
