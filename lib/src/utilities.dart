/*
 Created by Thanh Son on 31/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:objectx/objectx.dart';

import '../router.dart';

/// Default unknown route builder
final owletDefaultUnknownRoute = MaterialRouteBuilder(
  '/page-not-found',
  pageBuilder: (context, settings) => Scaffold(
    appBar: AppBar(title: const Text('Page Not Found:')),
    body: Center(child: Text('Page Not Found: ${settings.name}')),
  ),
);

/// Default empty page builder
Widget owletDefaultPlaceholder(context, settings) => Material();

/// Generate the uri's query parameter from Map<String, Object?>
String mapToQueryParameter(Map<String, Object?> args, {bool encode = false, String? fragment}) {
  String encodeValue(Object a) {
    if (encode) {
      return Uri.encodeComponent(a.toString());
    }
    return a.toString();
  }

  final query = StringBuffer();
  for (var i in args.keys) {
    final obj = args[i];
    if (obj == null) continue;
    if (query.isNotEmpty) {
      query.write('&');
    }
    query.write('${encodeValue(i)}=${encodeValue(obj)}');
  }
  fragment?.let((it) {
    if (it.startsWith('#')) query.write(it);
    query.write('#$it');
  });
  return query.toString();
}

/// Convert list of [RouteMixin] to [String]
String routesToString(Iterable<RouteMixin> list) {
  if (list.isEmpty) return 'Empty routes.';
  final max = (maxBy(list, (p0) => p0.path.length)?.path.length ?? 0) + 1;
  return list
      .map((e) => '${e.path.padRight(max)}: ${e.runtimeType}(canLaunch: ${e.canLaunch}, isCallback: ${e.isCallback})')
      .join('\n');
}
