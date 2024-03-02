// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 06/10/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of 'builder.dart';

///
/// The callback function for the push method receives the context of the push operation and the corresponding route.
typedef RouteCallback<R> = FutureOr<R?> Function(BuildContext context, Route route);

///
/// The [OwletNavigator] utilizes the [NamedFunctionRouteSettings] class to identify named function routes.
/// Additionally, it relays the callback for the processed function
class NamedFunctionRouteSettings<T extends Object?> extends RouteSettings {
  ///
  /// Create a new [RouteSettings] with the [callback]
  const NamedFunctionRouteSettings({
    required this.callback,
    super.arguments,
    super.name,
  });

  ///
  /// The callback function for the push method receives the context of the push operation and the corresponding route.
  final RouteCallback<T> callback;
}

///
/// The [OwletNavigator] provides a feature that allows you to name a function and call it using [Navigator.pushNamed],
/// returning the function's result as the push result.
///
/// **Note:** This feature only works with the following methods:
///
/// - [Navigator.push]
/// - [Navigator.pushNamed]
///
/// **WARNING:** Using [Navigator.popAndPushNamed] may cause an error.
class NamedFunctionRouteBuilder<A extends Object?, T extends Object?> extends RouteBuilder<A, T> {
  /// The [NamedFunctionRouteBuilder]'s constructor
  NamedFunctionRouteBuilder(super.segment, {required this.callback});

  ///
  /// The callback function for the push method receives the context of the push operation and the corresponding route.
  final RouteCallback<T> callback;

  @override
  bool get isCallback => true;

  @override
  Route<T>? build(RouteSettings settings) {
    final newSetting = NamedFunctionRouteSettings<T>(
      arguments: settings.arguments,
      name: settings.name,
      callback: callback,
    );
    return NoTransitionPageRoute(
      settings: newSetting,
      builder: (context) => owletDefaultPlaceholder(context, settings),
    );
  }
}
