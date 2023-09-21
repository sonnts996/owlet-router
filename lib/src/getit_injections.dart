/*
 Created by Thanh Son on 21/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

mixin GetITInjection {
  FutureOr<void> inject();

  FutureOr<void> dispose() {}

  FutureOr<void> reset() {}

  static void injectIt(RouteBase route) {
    for (var r in route._routes) {
      if (r is GetITInjection) {
        (r as GetITInjection).inject();
      }
    }
  }
}
