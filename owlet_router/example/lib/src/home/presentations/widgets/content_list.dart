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
    super.key,
    required this.onTab,
    required this.metaData,
  });

  final void Function(String name, PageInterface page) onTab;
  final MetaDataInterface metaData;

  @override
  Widget build(BuildContext context) => ListView(children: [
        ...metaData.pages.fold([], (previousValue, element) {
          final list = [
            ListTile(
                leading: IconWidget(iconUrl: element.label.icon, size: 20),
                title: Text(element.label.label),
                onTap: () {
                  onTab(element.label.segment, element);
                }),
            ...element.items.where((e) => e.label.isNotEmpty).map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ListTile(
                      leading: SizedBox(width: 20, child: Icon(Icons.circle_outlined, size: 6)),
                      minLeadingWidth: 10,
                      title: Text(e.label),
                      onTap: () {
                        onTab('${element.label.segment}${e.fragment}', element);
                      },
                    ),
                  ),
                ),
            if (element.items.isNotEmpty) const Divider(),
          ];
          return [...previousValue, ...list];
        }).toList(),
      ]);
}

class DesktopDrawer extends StatelessWidget {
  const DesktopDrawer({
    super.key,
    required this.onDocumentTab,
    required this.onNavigateTab,
    this.currentIndex = 0,
    required this.metaData,
  });

  final int currentIndex;
  final void Function(String name, PageInterface page) onDocumentTab;
  final ValueChanged<int> onNavigateTab;
  final MetaDataInterface metaData;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Container(
          width: 300,
          padding: EdgeInsets.only(left: 8, right: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(CupertinoIcons.home, size: 20),
                  onTap: () => onNavigateTab(1),
                  title: const Text('Home'),
                  selected: currentIndex == 1,
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.profile_circled, size: 20),
                  onTap: () => onNavigateTab(2),
                  title: const Text('Author'),
                  selected: currentIndex == 2,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 0, right: 16, top: 16),
                    child: Text('Documents', style: Theme.of(context).textTheme.labelMedium)),
                const Divider(),
                Expanded(child: ContentList(onTab: onDocumentTab, metaData: metaData)),
                SizedBox(height: 16),
              ]),
        ),
      );
}
