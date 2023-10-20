/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/multiple_navigator/pages/multiple_navigator_page.dart';
import 'package:rowlet/rowlet.dart';

class MultipleNavigatorRoutes extends RouteSegment {
  MultipleNavigatorRoutes(super.segmentPath);

  final multiplePage = MaterialRouteBuilder('/', pageBuilder: (context, settings) => const MultipleNavigatorPage());

  @override
  List<RouteSegment> get children => [multiplePage];
}
