# Getting started

Add this line to your dependencies:

```yaml
dependencies:
  rowlet: 'newest'
```

- import the package:

```dart
import 'package:rowlet/router.dart';
```

# Usage

* ``rowletNavigationService`` provides the methods to process the router definitions for
  rowletDelegate.

```dart
final navigationService = rowletNavigationService(
        navigationKey: GlobalKey(),
        routeObservers: [],
        initialRoute: '/',
        routeBase: mainRoute,
        routeNotFound: mainRoute.routeNotFound);
```

In your app, such as MaterialApp, define router like:

```dart
@override
Widget build(BuildContext context) {
  return MaterialApp.router(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    routerConfig: navigationService.routerConfig,
  );
}
 ```

* ``rowletNavigationService`` depends on a ``routeBase`` router.

```dart
final mainRoute = MainRoute();

/// ...

class MainRoute extends OriginRoute {

  final home = MaterialBuilder(
      '/home', 
      materialBuilder: (context, settings) => const HomePage());

  final splash = MaterialBuilder(
      '/',
      materialBuilder: (context, settings) => const SplashPage());

  final item = ItemRoute('/item');
  
  // Only route define in the getter ``List<RouteBase> get routes`` is accepted.
  @override
  List<RouteBase> get routes => [home, splash, item];
}


class ItemRoute extends RouteBase {
  ItemRoute(super.path);

  final detail = MaterialBuilder<String>(
      '/detail',
      materialBuilder: (context, settings) => DetailPage(item: settings.arguments as String));

  final list = MaterialBuilder(
      '/list', 
      materialBuilder: (context, settings) => const ListItemPage());

  // Only route define in the getter ``List<RouteBase> get routes`` is accepted.
  @override
  List<RouteBase> get routes => [detail, list];
}
```

* ``MainRoute`` is an ``OriginRoute``. In the router's tree, there is only one ``OriginRoute`` at
  the root of the tree.
  All children of ``MainRoute`` must be returned in the getter ``List<RouteBase> get routes``. Any
  route that is out of the route list will be ignored.

![Alt text](https://g.gravizo.com/svg?digraph%20G%20%7Bsize%20%3D%224%2C4%22%3B%0AMainRoute%20%5Bshape%3Dbox%5D%3B%0AMainRoute%20-%3E%20%22splash%20%28%27%2F%27%29%22%3B%0AMainRoute%20-%3E%20%22home%20%28%27%2Fhome%27%29%22%3B%0AMainRoute%20-%3E%20%22item%20%28%27%2Fitem%27%29%22%3B%0A%22item%20%28%27%2Fitem%27%29%22%20-%3E%20%22list%20%28%27%2Flist%27%29%22%3B%0A%22item%20%28%27%2Fitem%27%29%22%20-%3E%20%22detail%20%28%27%2Fdetail%27%29%22%20%5Blabel%3D%22String%20arguments%22%5D%3B%0A%7D)

* A ``RouteBase`` is a route folder, that mean it be able to group others route.
  For example:
  You have a item creator's route and category creator's route:

```url
\item_create
\category_create
```

A better definition can be:

```url
\item\create
\category\create
```

* A ``RouteBuilder`` is not only a ``RouteBase``, but it also returns a ``Route<dynamic>`` to build
  a new page.
  An error will be thrown if a ``RouteBuilder`` without a builder is called to build a new page. (
  Otherwise, if it is not called to build, it is simply a ``RouteBase``)

```dart
RouteBuilder(super.path, {
    RouterBuilder? builder,
  });
```

``MaterialBuilder`` will returns a ``RouteBuilder`` with a MaterialPageRoute
and ``CupertinoBuilder`` will returns CupertinoPageRoute.

> [!NOTE]
> A path must start with a slash '/'

---
> [!WARNING]
> Initial Route:
>
> ``rowletNavigatorSerivce``
> use [``Navigator.defaultGenerateInitialRoutes``](https://api.flutter.dev/flutter/widgets/Navigator/defaultGenerateInitialRoutes.html)
> as default.
> That means if your initial route has many path segments, all path segments must be
> a ``RouteBuilder`` with a non-null builder function:
>
> For example, if the route /stocks/HOOLI was used as the initialRoute, then the Navigator would
> push the following routes on startup: /, /stocks, /stocks/HOOLI.
> So all of the routes (/, /stocks, /stocks/HOOLI) must be defined as a ``RouteBuilder``.
>
> See more: https://api.flutter.dev/flutter/widgets/Navigator/defaultGenerateInitialRoutes.html

## Route path definition rules:

## Not found route:

# Features and bugs

Please file feature requests and bugs at
the [issue tracker](https://github.com/sonnts996/rowlet/issues).