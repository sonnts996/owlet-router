// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 06/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/material.dart';

import '../../rowlet.dart';

/// Callback when push a route
typedef NonRouteCallback<R> = Future<R?> Function(BuildContext pushContext, Route<R?> route);

/// With ROwletNavigator, when pushes a new route, if the route has route settings is [NonRouteSettings]
/// the [NonRouteSettings.callback] will be called and cancel the pushing.
class NonRouteSettings<T extends Object?> extends RouteSettings {
  /// With ROwletNavigator, when pushes a new route, if the route has route settings is [NonRouteSettings]
  /// the [NonRouteSettings.callback] will be called and cancel the pushing.
  NonRouteSettings({
    super.arguments,
    super.name,
    required this.callback,
  });

  /// Return the callback route. It is called and cancels the pushing.
  final NonRouteCallback<T> callback;
}

/// ROwletNavigator provides a feature that accepts the named actions, such as pushing a custom dialog or custom bottom sheet.
/// You can define a callback as a route. When calling the push (or pushName) method,
/// the callback function will be called and return the result, and no route be pushed to your navigator.
///
/// Note:
/// This works only with these functions:
/// - [Navigator.push],
/// - [Navigator.pushNamed],
///
/// [WARNING] [Navigator.popAndPushNamed] may be bright an error
class NonRouteBuilder<ARGS extends Object?, T extends Object?> extends RouteBuilder<ARGS, T> {
  /// [NonRouteBuilder]'s constructor.
  NonRouteBuilder(super.segmentPath, {required this.callback});

  /// Return the callback route. It is called and cancels the pushing.
  final NonRouteCallback<T> callback;

  @override
  Route<T>? builder(RouteSettings settings) {
    final newSetting = NonRouteSettings<T>(
      arguments: settings.arguments,
      name: settings.name,
      callback: callback,
    );
    return NoAnimationPageRoute(
      settings: newSetting,
      builder: (context) => Material(
        child: Container(alignment: Alignment.center, child: Text('${settings.name}')),
      ),
    );
  }
}
