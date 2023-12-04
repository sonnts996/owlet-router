/*
 Created by Thanh Son on 06/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:objectx/objectx.dart';
import 'package:owlet_router/router.dart';
import 'package:provider/provider.dart';

import '../../../../gen/injections.dart';
import '../../../widgets/responsive_layout.dart';
import '../../domain/interfaces/metadata_interface.dart';
import '../../domain/usecases/content_usecase.dart';
import '../../home_tab_route.dart';
import '../widgets/document.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({
    super.key,
    required this.page,
  });

  final PageInterface? page;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  final ContentUseCase contentUseCase = getIt.get<ContentUseCase>();

  PageInterface? page;
  late final RouteNotifier routeNotifier;

  @override
  void initState() {
    super.initState();
    if (widget.page != null) {
      page = widget.page!;
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        routeNotifier = RouteBase.of<HomeTabRoute>(context).homePage..addListener(listenRouteChange);
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        page = Provider.of(context, listen: false);
        routeNotifier = RouteBase.of<HomeTabRoute>(context).tabPage..addListener(listenRouteChange);
      });
    }
  }

  @override
  void dispose() {
    routeNotifier.removeListener(listenRouteChange);
    super.dispose();
  }

  void listenRouteChange() {
    (routeNotifier.settings).print(tag: 'routeNotifier');
  }

  @override
  Widget build(BuildContext context) => ResponsiveLayout(
        builder: (context, mode, child) => Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      HomeAppBar(
                        isNormalScreenMode: mode.isNormal,
                        coverImage: page?.coverImage,
                      )
                    ],
                body: child!)),
        child: Document(
          docs: page?.data.toList() ?? [],
          getContent: contentUseCase,
        ),
      );
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    this.isNormalScreenMode = true,
    this.coverImage,
  });

  final bool isNormalScreenMode;
  final String? coverImage;

  @override
  Widget build(BuildContext context) => SliverAppBar(
      expandedHeight: 300,
      pinned: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: DecoratedBox(
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
            child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFEDE0CD), // image color
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                ),
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300, minHeight: 100, maxHeight: 300),
                  child: Image.asset(
                    'assets/owlets_on_the_tree.jpg',
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.bottomCenter,
                  ),
                ))),
      ));
}
