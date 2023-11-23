/*
 Created by Thanh Son on 31/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:objectx/objectx.dart';

import '../router.dart';

///
/// The default unknown route builder, which is used when the specified route cannot be found or the route builder returns a null route.
final owletDefaultUnknownRoute = MaterialRouteBuilder(
  '/page-not-found',
  pageBuilder: (context, settings) =>
      Scaffold(
        appBar: AppBar(title: const Text('Page Not Found:')),
        body: Center(child: Text('Page Not Found: ${settings.name}')),
      ),
);

///
/// Build a blank page.
Widget owletDefaultPlaceholder(context, settings) => Material();

///
/// Constructs the URI's query parameters from a Map<String, Object?>.
/// When the encoding flag is set to true, the parameters are encoded using the URI encoder.
String mapToQueryParameter(Map<String, Object?> args, {bool encode = false, String? fragment}) {
  String encodeValue(Object a) {
    if (encode) {
      return Uri.encodeComponent(a.toString());
    }
    return a.toString();
  }

  final query = StringBuffer();
  fragment?.let((it) {
    if (it.startsWith('#')) query.write(encodeValue(it));
    query.write('#${encodeValue(it)}');
  });
  query.write('?');
  for (var i in args.keys) {
    final obj = args[i];
    if (obj == null) continue;
    if (query.isNotEmpty) {
      query.write('&');
    }
    query.write('${encodeValue(i)}=${encodeValue(obj)}');
  }

  return query.toString();
}

/// Convert the list of [RouteMixin] to [String]
String routesToString(Iterable<RouteMixin> list) {
  if (list.isEmpty) return 'Empty routes.';
  final max = (maxBy(list, (p0) => p0.path.length)?.path.length ?? 0) + 1;
  return list
      .map((e) => '${e.path.padRight(max)}: ${e.runtimeType}(canLaunch: ${e.canLaunch}, isCallback: ${e.isCallback})')
      .join('\n');
}
