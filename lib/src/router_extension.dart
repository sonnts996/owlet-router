/*
 Created by Thanh Son on 06/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

extension RouterExtension<E extends Object> on RouteBuilder<E> {

  Future<T?> pushNamed<T extends Object?>(
    BuildContext context, {
    bool forRoot = false,
    E? args,
  }) =>
      Navigator.pushNamed<T>(
        context,
        fullRoute,
        arguments: args,
      );

  Future<T?> pushReplacementNamed<T extends Object?, T0 extends Object?>(
    BuildContext context, {
    bool forRoot = false,
    T0? result,
    E? args,
  }) =>
      Navigator.pushReplacementNamed<T, T0>(
        context,
        fullRoute,
        arguments: args,
        result: result,
      );

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    E? args,
    bool forRoot = false,
  }) =>
      Navigator.pushNamedAndRemoveUntil<T>(
        context,
        fullRoute,
        predicate,
        arguments: args,
      );

  Future<T?> popAndPushNamed<T extends Object?, T0 extends Object?>(
    BuildContext context, {
    bool forRoot = false,
    E? args,
    T0? result,
  }) =>
      Navigator.popAndPushNamed<T, T0>(
        context,
        fullRoute,
        arguments: args,
        result: result,
      );
}
