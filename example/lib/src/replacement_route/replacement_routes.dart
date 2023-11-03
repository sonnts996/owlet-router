/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/replacement_route/pages/replacement_pages.dart';
import 'package:owlet_router/router.dart';

class ReplacementRoutes extends RouteBase {
  ReplacementRoutes(super.segment);

  final replacement = MaterialRouteBuilder(
    '/',
    pageBuilder: (context, settings) {
      return ReplacementPages(
        message: settings.arguments?.toString(),
      );
    },
  );

  @override
  List<RouteBase> get children => [replacement];
}
