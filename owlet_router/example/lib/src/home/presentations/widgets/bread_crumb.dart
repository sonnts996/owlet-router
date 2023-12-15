/*
 Created by Thanh Son on 04/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

class BreadCrumbItem {
  BreadCrumbItem({
    required this.route,
    required this.label,
    required this.onTab,
  });

  final Route route;
  final String label;
  final VoidCallback onTab;
}

class BreadCrumbWidget extends StatefulWidget {
  const BreadCrumbWidget({
    required this.service,
    required this.routeNamedMap,
    super.key,
  });

  final NavigationService service;
  final HashMap<String, String> routeNamedMap;

  @override
  State<BreadCrumbWidget> createState() => _BreadCrumbWidgetState();
}

class _BreadCrumbWidgetState extends State<BreadCrumbWidget> {
  final Set<BreadCrumbItem> breadCrumb = {};

  @override
  void initState() {
    super.initState();
    updateBreadCrumb();
    widget.service.history.addListener(updateBreadCrumb);
  }

  @override
  void dispose() {
    widget.service.history.removeListener(updateBreadCrumb);
    super.dispose();
  }

  void updateBreadCrumb() {
    final history = widget.service.history;
    setState(() {
      breadCrumb.clear();
      for (final e in history.routes) {
        breadCrumb.add(
          BreadCrumbItem(
              route: e,
              label:
                  widget.routeNamedMap[Uri.parse(e.settings.name ?? '').path] ??
                      '.',
              onTab: () {
                widget.service.popUntil((route) => compareRouteName(route, e));
              }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = breadCrumb.elementAt(index);
        return itemBuilder(item.onTab, item.label);
      },
      separatorBuilder: (context, index) => const Icon(Icons.chevron_right),
      itemCount: breadCrumb.length);

  Widget itemBuilder(VoidCallback onPressed, String title) =>
      TextButton(onPressed: onPressed, child: Text(title));
}
