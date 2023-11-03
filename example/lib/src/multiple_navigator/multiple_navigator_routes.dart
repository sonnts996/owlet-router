/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/multiple_navigator/pages/multiple_navigator_page.dart';
import 'package:owlet_router/router.dart';

class MultipleNavigatorRoutes extends RouteBase {
  MultipleNavigatorRoutes(super.segment);

  final multiplePage = MaterialRouteBuilder('/', pageBuilder: (context, settings) => const MultipleNavigatorPage());

  @override
  List<RouteBase> get children => [multiplePage];
}
