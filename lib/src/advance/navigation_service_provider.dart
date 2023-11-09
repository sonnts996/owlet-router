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
class NavigationServiceProvider<R extends RouteBase> extends InheritedWidget {
  /// The [NavigationServiceProvider]'s constructor.
  const NavigationServiceProvider({super.key, required super.child, required this.service});

  /// The instance of [NavigationService]
  final NavigationService<R> service;

  /// Returns the root route in the [service]
  R get root => service.root;

  /// Returns the [NavigationServiceProvider] if it exists in the [context]. Use [useRoot] for get the top-level of it.
  static NavigationServiceProvider<R>? maybeOf<R extends RouteBase>(BuildContext context, {bool useRoot = false}) {
    if (useRoot) {
      final root = context.dependOnInheritedWidgetOfExactType<RootNavigationServiceProvider<R>>();
      return root ?? context.dependOnInheritedWidgetOfExactType<NavigationServiceProvider<R>>();
    }
    return context.dependOnInheritedWidgetOfExactType<NavigationServiceProvider<R>>();
  }

  /// Returns the [NavigationServiceProvider] if it exists in the [context].
  /// But it will be thrown an error if the [NavigationServiceProvider] not found.
  /// Use [useRoot] for get the top-level of it
  static NavigationServiceProvider<R> of<R extends RouteBase>(BuildContext context, {bool useRoot = false}) {
    final result = maybeOf<R>(context, useRoot: useRoot);
    assert(result != null, 'No NavigationServiceProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant NavigationServiceProvider oldWidget) => oldWidget.service != service;
}

/// In your app, if you use [RouterDelegate] from [NavigationService],
/// a [RootNavigationServiceProvider] will be employed for the top-level of [NavigationService].
/// This is particularly relevant when there are multiple [NavigationService] instances within your app.
/// To obtain the root at the top-level, utilize the useRoot flag.
class RootNavigationServiceProvider<R extends RouteBase> extends NavigationServiceProvider<R> {
  /// In your app, if you use [RouterDelegate] from [NavigationService],
  /// a [RootNavigationServiceProvider] will be employed for the top-level of [NavigationService].
  /// This is particularly relevant when there are multiple [NavigationService] instances within your app.
  /// To obtain the root at the top-level, utilize the useRoot flag.
  RootNavigationServiceProvider({required super.child, required super.service});

  /// Returns the top-level of [NavigationServiceProvider] if it exists in the [context].
  static RootNavigationServiceProvider<R>? maybeOf<R extends RouteBase>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<RootNavigationServiceProvider<R>>();

  /// Returns the top-level [NavigationServiceProvider] if it exists in the [context].
  /// But it will be thrown an error if the [NavigationServiceProvider] not found.
  static RootNavigationServiceProvider<R> of<R extends RouteBase>(BuildContext context) {
    final result = maybeOf<R>(context);
    assert(result != null, 'No RootNavigationServiceProvider found in context');
    return result!;
  }
}
