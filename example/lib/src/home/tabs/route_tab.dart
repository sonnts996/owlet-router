/*
 Created by Thanh Son on 12/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/home/home_tab_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:objectx/objectx.dart';
import 'package:owlet_router/router.dart';

class RouteTab extends StatefulWidget {
  const RouteTab({super.key});

  @override
  State<RouteTab> createState() => _RouteTabState();
}

class _RouteTabState extends State<RouteTab> {
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
