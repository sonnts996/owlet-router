/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:example/src/home/home_route.dart';
import 'package:example/src/home/splash_page.dart';
import 'package:owlet_router/router.dart';

class MainRoute extends RouteBase {
  MainRoute() : super.root();

  final home = HomeRoute('/home');

  final splash = MaterialRouteBuilder('/', pageBuilder: (context, settings) => const SplashPage());

  @override
  List<RouteBase> get children => [
        home,
        splash,
      ];
}
