/*
 Created by Thanh Son on 31/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';

import '../../router.dart';

/// By default, if use [NavigationService] in your app (see below), you can get it from the provider.
///
/// Example:
/// ```dart
///  MaterialApp.router(
///       // ...
///       routerConfig: service.routerConfig,
///     );
///
/// final service = NavigationServiceProvider.of(context);
/// ```
///
/// Another way, if use a second [OwletNavigator], you can use the [OwletNavigator.from] or wrap it inside the [NavigationServiceProvider] widget.
class NavigationServiceProvider extends InheritedWidget {
  /// The [NavigationServiceProvider]'s constructor.
  const NavigationServiceProvider({super.key, required super.child, required this.service});

  /// The instance of [NavigationService]
  final NavigationService service;

  /// Returns the root route in the [service]
  RouteMixin get root => service.root;

  /// Returns the [NavigationServiceProvider] if it exists in the [context].
  static NavigationServiceProvider? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NavigationServiceProvider>();

  /// Returns the [NavigationServiceProvider] if it exists in the [context]. But it will be thrown an error if the [NavigationServiceProvider] not found.
  static NavigationServiceProvider of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No NavigationServiceProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant NavigationServiceProvider oldWidget) => oldWidget.service != service;
}
