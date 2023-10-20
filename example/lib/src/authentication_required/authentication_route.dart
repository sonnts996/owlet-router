/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/authentication_required/pages/login_datasource.dart';
import 'package:example/src/authentication_required/pages/login_page.dart';
import 'package:example/src/authentication_required/pages/profile_page.dart';
import 'package:rowlet/rowlet.dart';

/// You can use injections for this, such as getIt.
final LoginDataSource loginDataSource = LoginDataSource();

class AuthenticationRoute extends RouteSegment {
  AuthenticationRoute(super.segmentPath);

  final login = RouteGuardBuilder(
    cancelledValue: true,
    routeBuilder: MaterialRouteBuilder(
      '/login',
      pageBuilder: (context, settings) => LoginPage(loginDataSource: loginDataSource),
    ),
    routeGuard: (_, route) async {
      if (loginDataSource.isLogin) {
        /// Ignore pushing a new login route when you are already in a login state.
        /// [cancelledValue] will be result of Navigator.push
        return null;
      }
      return route;
    },
  );

  late final RouteGuardBuilder<Object, Object?> profile = RouteGuardBuilder(
    routeBuilder: MaterialRouteBuilder(
      '/profile',
      pageBuilder: (context, settings) => ProfilePage(loginDataSource: loginDataSource),
    ),
    routeGuard: (pushContext, route) async {
      // If you are not in a login state, push and wait for the login page.
      // After return, if you are still not in a login state, the pushing will be ignored.
      // Otherwise, the profile push will be pushed.
      if (!loginDataSource.isLogin) {
        await login.pushNamed<bool>(pushContext);
        if (loginDataSource.isLogin) {
          return route;
        } else {
          return null;
        }
      }
      return route;
    },
  );

  @override
  List<RouteSegment> get children => [profile, login];
}
