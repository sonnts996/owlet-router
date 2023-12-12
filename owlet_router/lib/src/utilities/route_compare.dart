/*
 Created by Thanh Son on 05/12/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:objectx/objectx.dart';

import '../../router.dart';

///
/// Return true if the [a] path and [b] path are the same. If either or both of them are null or cannot be parsed into a valid URI, then return false.
bool compareName(String? a, String? b) {
  final aPath = a?.let(Uri.tryParse)?.path;
  final bPath = b?.let(Uri.tryParse)?.path;
  if (aPath == null || bPath == null) return false;
  return aPath == bPath;
}

///
/// Return true if the [a] path and [b] path are the same. If either or both of them are null or cannot be parsed into a valid URI, then return false.
bool compareRouteName(Route a, Route b) {
  if (identical(a, b)) {
    return true;
  }
  return compareName(a.settings.path, b.settings.path);
}

///
/// Return true if the [a]  and [b]  are the same URI and arguments. If either or both of them are null or cannot be parsed into a valid URI, then return false.
bool compareRouteNameWithArgument(Route a, Route b) {
  if (identical(a, b)) {
    return true;
  }
  final aUri = a.settings.name?.let(Uri.tryParse);
  final bUri = b.settings.name?.let(Uri.tryParse);
  if (aUri == null || bUri == null) return false;
  return a.settings.arguments == b.settings.arguments &&
      aUri.path == aUri.path &&
      mapEquals(aUri.queryParameters, bUri.queryParameters) &&
      aUri.fragment == bUri.fragment;
}

///
/// Return true if the [a] path and [b] path are the same. If either or both of them are null or cannot be parsed into a valid URI, then return false.
bool compareRouteWithRouteMixin(Route a, RouteMixin b) {
  final aPath = a.settings.name?.let(Uri.tryParse)?.path;
  if (aPath == null) return false;
  return aPath == b.path;
}
