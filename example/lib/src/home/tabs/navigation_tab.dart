/*
 Created by Thanh Son on 12/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:objectx/objectx.dart';
import 'package:owlet_router/router.dart';

import '../home_tab_route.dart';

class NavigationTab extends StatefulWidget {
  const NavigationTab({super.key});

  @override
  State<NavigationTab> createState() => _NavigationTabState();
}

class _NavigationTabState extends State<NavigationTab> {
  late final HomeTabRoute tabRoute;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      tabRoute = RouteBase.of<HomeTabRoute>(context);

      tabRoute.routeNotifier.addListener(onRouteNotifier);
    });
  }

  @override
  void dispose() {
    tabRoute.routeNotifier.removeListener(onRouteNotifier);
    super.dispose();
  }

  void onRouteNotifier() {
    tabRoute.routeNotifier.value?.let((it) {
      if (tabRoute.routeTab.match(it.name ?? '')) {
        it.print();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
