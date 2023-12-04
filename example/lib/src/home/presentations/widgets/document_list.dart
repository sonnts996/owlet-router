/*
 Created by Thanh Son on 21/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/icon_widget.dart';
import '../../domain/interfaces/metadata_interface.dart';

class DocumentList extends StatelessWidget {
  const DocumentList({
    super.key,
    required this.onTab,
    required this.metaData,
  });

  final void Function(String name) onTab;
  final MetaDataInterface metaData;

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Documents', style: Theme.of(context).textTheme.labelMedium)),
          ...metaData.pages.fold([], (previousValue, element) {
            final list = [
              ListTile(
                  leading: IconWidget(iconUrl: element.menuItem.icon, size: 20),
                  title: Text(element.menuItem.label),
                  onTap: () {
                    onTab(element.menuItem.segment);
                  }),
              const Divider(indent: 16),
              ...element.data.where((e) => e.title.isNotEmpty).map((e) => Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: ListTile(
                        leading: IconWidget(iconUrl: e.icon, size: 20),
                        title: Text(e.title),
                        onTap: () {
                          onTab('${element.menuItem.segment}${e.fragment}');
                        }),
                  )),
              const Divider(),
            ];
            return [...previousValue, ...list];
          }).toList(),
        ],
      );
}

class DesktopDrawerDocument extends StatelessWidget {
  const DesktopDrawerDocument({
    super.key,
    required this.onDocumentTab,
    required this.onNavigateTab,
    this.currentIndex = 0,
    required this.metaData,
  });

  final int currentIndex;
  final ValueChanged<String> onDocumentTab;
  final ValueChanged<int> onNavigateTab;
  final MetaDataInterface metaData;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Container(
          width: 300,
          padding: EdgeInsets.only(left: 8, right: 16),
          child: Column(children: [
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
            const Divider(),
            Expanded(child: DocumentList(onTab: onDocumentTab, metaData: metaData)),
          ]),
        ),
      );
}
