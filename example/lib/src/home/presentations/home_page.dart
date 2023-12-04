/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:objectx/objectx.dart';
import 'package:owlet_router/router.dart';
import 'package:provider/provider.dart';

import '../../../main_routes.dart';
import '../../widgets/constrains_body.dart';
import '../../widgets/responsive_layout.dart';
import '../domain/interfaces/metadata_interface.dart';
import '../home_tab_route.dart';
import 'widgets/document_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.initialRoute,
    required this.service,
    required this.metaData,
  });

  final String initialRoute;
  final NavigationService<HomeTabRoute> service;
  final MetaDataInterface metaData;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(debugLabel: 'HomeScaffold');

  NavigationService<HomeTabRoute> get tabService => widget.service;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      tabService.history.addListener(onTabChanged);
    });
    tabService.route.printAll();
  }

  @override
  void dispose() {
    tabService.history.removeListener(onTabChanged);
    super.dispose();
  }

  void onTabChanged() {
    (tabService.history).print(tag: 'history');
  }

  @override
  Widget build(BuildContext context) => ResponsiveLayout(
      child: Provider.value(
        value: widget.metaData,
        updateShouldNotify: (previous, current) => false,
        builder: (context, child) => child!,
        child: OwletNavigator(tabService),
      ),
      builder: (context, mode, child) => Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: false,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/github-mark.svg',
                      height: 24,
                      width: 24,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/pub-dev-logo.svg',
                      height: 24,
                      width: 24,
                    )),
                SizedBox(width: 16),
              ],
              titleSpacing: 0,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (mode.isNormal)
                      SizedBox(
                        width: 300,
                        height: kToolbarHeight,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 8),
                              const SizedBox(width: 10),
                              ShaderMask(
                                shaderCallback: (bounds) => const LinearGradient(
                                  colors: [Color(0xFF6C89EE), Color(0xFF012FC5)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                                child: SvgPicture.asset(
                                  'assets/logo_owlet.svg',
                                  height: 32,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(widget.metaData.name, style: Theme.of(context).textTheme.titleMedium)
                            ]),
                      ),
                    SizedBox(width: 16),
                    SizedBox(height: kToolbarHeight, child: BreadCrumbWidget(service: widget.service)),
                  ]),
            ),
            drawer: mode.isNormal
                ? null
                : Drawer(
                    child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 16),
                    child: DocumentList(onTab: onSectionTab, metaData: widget.metaData),
                  )),
            body: mode.isNormal
                ? BodyContainer(
                    child: Row(children: [
                    DesktopDrawerDocument(
                      onDocumentTab: onSectionTab,
                      onNavigateTab: onNavigateTab,
                      currentIndex: currentIndex,
                      metaData: widget.metaData,
                    ),
                    Expanded(child: child!),
                  ]))
                : child!,
            bottomNavigationBar: mode.isNormal
                ? null
                : BottomNavigationBar(
                    currentIndex: 1,
                    onTap: onNavigateTab,
                    type: BottomNavigationBarType.fixed,
                    items: const [
                        BottomNavigationBarItem(icon: Icon(CupertinoIcons.line_horizontal_3), label: 'Menu'),
                        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
                        BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), label: 'Author'),
                      ]),
          ));

  void onNavigateTab(int index) {
    switch (index) {
      case 0:
        scaffoldKey.currentState?.openDrawer();
        break;
      case 2:
        RouteBase.of<MainRoute>(context).profile.pushNamed();
        break;
    }
  }

  void onSectionTab(String name) {
    // tabService.pushNamed(path: name);
    Navigator.of(context, rootNavigator: true).pushNamed('/home/t$name');
  }
}

class BreadCrumbWidget extends StatefulWidget {
  const BreadCrumbWidget({
    super.key,
    required this.service,
  });

  final NavigationService service;

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
      breadCrumb.add(BreadCrumbItem(
        route: history.routes.first,
        label: 'Home',
        onTab: () {
          if (history.routes.length == 1) {
          } else {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
      ));
      if (history.routes.length > 1) {
        BreadCrumbItem(
          route: history.current,
          label: '',
          onTab: () {
            if (history.routes.length == 1) {
            } else {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = breadCrumb.elementAt(index);
        return itemBuilder(item.onTab, item.label);
      },
      separatorBuilder: (context, index) => Icon(Icons.chevron_right),
      itemCount: breadCrumb.length);

  Widget itemBuilder(VoidCallback onPressed, String title) => TextButton(onPressed: onPressed, child: Text(title));
}
