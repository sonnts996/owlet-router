/*
 Created by Thanh Son on 25/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:example/src/pages/home_page.dart';
import 'package:example/src/pages/items/items_route.dart';
import 'package:example/src/pages/splash_page.dart';
import 'package:rowlet/rowlet.dart';

class MainRoute extends OriginRoute {


  final home = MaterialBuilder('/home', materialBuilder: (context, settings) => const HomePage());

  final splash = MaterialBuilder(
    '/',
    materialBuilder: (context, settings) => const SplashPage(),
  );

  final item = ItemRoute('/item');


  @override
  List<RouteBase> get routes => [home, splash, item];
}
