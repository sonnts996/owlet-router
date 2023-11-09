/*
 Created by Thanh Son on 06/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';
import 'package:owlet_router/router.dart';

extension ServiceExtension on BuildContext {
  // MainRoute get route => RouteBase.of(this);

  NavigationService get service => NavigationService.of(this);
}
