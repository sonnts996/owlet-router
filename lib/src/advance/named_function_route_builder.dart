// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 06/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'dart:async';

import 'package:flutter/material.dart';

import '../../router.dart';

/// The function will be called when pushing a route with the settings as [NamedFunctionRouteSettings]
typedef RouteCallback<R> = FutureOr<R?> Function(BuildContext pushContext, Route<R?> route);

/// If using [OwletNavigator], everytime push a new route with the settings as [NamedFunctionRouteSettings],
/// the [NamedFunctionRouteSettings.callback] will be called and the pushing will be ignored.
class NamedFunctionRouteSettings<T extends Object?> extends RouteSettings {
  /// Create a new [RouteSettings] with the [callback]
  NamedFunctionRouteSettings({
    super.arguments,
    super.name,
    required this.callback,
  });

  /// Return the callback route. It is called and cancels the pushing.
  final RouteCallback<T> callback;
}

/// The [OwletNavigator] provides a feature that can be used to name a function. And call it like a Route ([Navigator.pushNamed]).
/// The function can also return the result.
///
///
/// **Note: This works only with these functions:**
/// - [Navigator.push],
/// - [Navigator.pushNamed],
///
/// __WARNING:__ The [Navigator.popAndPushNamed] may be bright an error
class NamedFunctionRouteBuilder<A extends Object?, T extends Object?> extends RouteBuilder<A, T> {
  /// The [NamedFunctionRouteBuilder]'s constructor with the [segment] path and your [callback].
  /// The result of the [callback] is also passed into the result of [Navigator.pushNamed]
  NamedFunctionRouteBuilder(super.segment, {required this.callback});

  /// The result of the [callback] is also passed into the result of [Navigator.pushNamed]
  final RouteCallback<T> callback;

  @override
  bool get isCallback => true;

  @override
  Route<T>? builder(RouteSettings settings) {
    final newSetting = NamedFunctionRouteSettings<T>(
      arguments: settings.arguments,
      name: settings.name,
      callback: callback,
    );
    return NoTransitionPageRoute(
      settings: newSetting,
      builder: (context) => Material(
        child: Container(alignment: Alignment.center, child: Text('${settings.name}')),
      ),
    );
  }
}
