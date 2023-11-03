/*
 Created by Thanh Son on 31/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';

import '../route/builder/builder.dart';

/// Default unknown route builder
final owletDefaultUnknownRoute = MaterialRouteBuilder(
  '/page-not-found',
  pageBuilder: (context, settings) => Scaffold(
    appBar: AppBar(title: const Text('Page Not Found:')),
    body: Center(child: Text('Page Not Found: ${settings.name}')),
  ),
);
