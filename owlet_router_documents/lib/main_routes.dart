/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:owlet_router/router.dart';

import 'gen/injections.dart';
import 'src/home/domain/usecases/metadata_usecase.dart';
import 'src/home/home_tab_route.dart';
import 'src/home/presentations/home_page.dart';
import 'src/profile/presentations/profile_page.dart';
import 'src/splash_page.dart';

class MainRoute extends RouteBase {
  MainRoute() : super.root();

  final MetaDataUseCase metaDataUseCase = getIt.get<MetaDataUseCase>();

  late final home = NestedService(
      nestedService: homeTabService,
      route: RouteGuard(
        route: PlaceholderRouteBuilder('/home'),
        routeGuard: (context, it, route) async {
          if (service.history.containsName(it.path)) {
            return CancelledRoute();
          }
          final data = await metaDataUseCase();
          return MaterialPageRoute(
              settings: route.settings,
              builder: (context) {
                final initialRoute = route.settings.arguments as Map<String, dynamic>?;
                return HomePage(
                  initialRoute: initialRoute?['initialRoute'] ?? '/',
                  service: homeTabService,
                  metaData: data,
                );
              });
        },
      ));

  final splash = MaterialRouteBuilder(
    '/',
    pageBuilder: (context, settings) => const SplashPage(),
  );

  final profile = MaterialRouteBuilder(
    '/profile',
    pageBuilder: (context, settings) => const ProfilePage(),
  );

  @override
  List<RouteBase> get children => [home, splash, profile];
}
