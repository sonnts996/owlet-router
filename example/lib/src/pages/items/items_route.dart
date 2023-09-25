/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/pages/items/detail_page.dart';
import 'package:example/src/pages/items/list_item_page.dart';
import 'package:rowlet/rowlet.dart';

class ItemRoute extends RouteBase {
  ItemRoute(super.path);

  final detail = MaterialBuilder<String>(
    '/detail',
    materialBuilder: (context, settings) => DetailPage(item: settings.arguments as String),
  );

  final list = MaterialBuilder('/list', materialBuilder: (context, settings) => const ListItemPage());

  @override
  List<RouteBase> get routes => [detail, list];
}
