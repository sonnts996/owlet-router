# Owlet Router

<img src="assets/owlets_on_the_tree.jpg" alt="owlets_on_the_tree" width="300"/>

[![version](https://img.shields.io/pub/v/owlet_router)](https://pub.dev/packages/owlet_router) [![like](https://img.shields.io/pub/likes/owlet_router)](https://pub.dev/packages/owlet_router) [![issues](https://img.shields.io/github/issues/sonnts996/owlet-router)](https://github.com/sonnts996/owlet-router) [![license](https://img.shields.io/github/license/sonnts996/owlet-router)](https://github.com/sonnts996/owlet-router)

The `owlet_router` is a route manager. It utilizes the route builder to
construct the router.

It is designed with several purposes in mind:

- Providing a clear and easily definable route manager that is simple to read and use.
- Built upon the base Flutter Router, allowing for integration with various page route types and the
  ability to customize and extend the router.
- Enabling modularization of the router, making it easy to segment routes and create independent
  routes.
- Offering the capability to check, prevent, or redirect routes before they are pushed.

# Table of content

- [Getting started](#getting-started)
- [Usage](#usage)
- [Features](#features)
    - [1. NavigationService](#1-navigationservice)
    - [1.1. Owlet Navigator](#owlet-navigator)
    - [2. Provider](#2-provider)
    - [3. Route history](#3-route-history)
    - [4. Unknown Route](#4-unknown-route)
    - [5. Route](#5-route)
        - [5.1. Route builder](#51-route-builder)
        - [5.2. Route usage](#52-how-does-it-work)
        - [5.3. Custom RouteBuilder](#53-custom-routebuilder)
        - [5.4. Troubleshoot](#54-troubleshoot)
    - [6. Nested Navigator](#6-nested-navigator)
- [Inspiration and References](#inspiration-and-references)
- [Features and bugs](#features-and-bugs)

# Getting started

Add this line to your dependencies:

```yaml
dependencies:
  rowlet_router: '0.0.1'
```

- import the package:

```dart
import 'package:rowlet_router/router.dart';
```

# Usage

- Create your `AppRoute` class for the top-level route (the root route). This route has 2 direct
  children `splash` and `home`.

```dart
class AppRoute extends RouteBase {
  class AppRoute():super.root(); // The default to set the root segments is '/'
  
  final splash = MaterialRouteBuilder(
      '/', pageBuilder: (context, settings) => const SplashPage());
  
  final home = MaterialRouteBuilder(
      '/home', pageBuilder: (context, settings) => const HomePage());
  
  final profiles = ProfileRoute('/profile');

  List<RouteBase> get children => [splash, home, profiles];
}
```

- The `ProfileRoute` is a child route module of `AppRoute`. It has 2 children, the details
  page (`/profile/`) and the update profile page (`/profile/update-profile`).

```dart
class ProfileRoute extends RouteBase {
  class ProfileRoute(super.segment);
  
  final details = MaterialRouteBuilder(
      '/', pageBuilder: (context, settings) => const DetailsPage());
      

  final update = MaterialRouteBuilder(
      '/update-profile', pageBuilder: (context, settings) => const UpdateProfilePage());

  List<RouteBase> get children => [details, update];
}
```

- To utilize this route, you must inject the top-level route (AppRoute) into your navigator using
  the `NavigationService`.

```dart
final appRoute = AppRoute(); // The root route

final service = NavigationService(
    navigationKey: GlobalKey(),
    routeObservers: [ /* your observers */],
    initialRoute: '/',
    root: appRoute,
    unknownRoute: owletDefaultUnknownRoute);

// ...
// Use in root navigator

Widget build(BuildContext context) {
  return MaterialApp.router(
    routerConfig: service.routerConfig,

    /// ...
  );
}

// *************************************************
// Use in nested navigator                       

Widget build(BuildContext context) {
  return OwletNavigator(service);
}
```

- To push the `profile` route, you can use the normal push method of Navigator:

```dart
final result = await Navigator.of(context).pushNamed('/profile/');
```

- ... or call from the route field.

```dart
final result = await appRoute.profiles.pushNamed(
                            args: //..., 
                            params: // ... query parameters
                            fragment: // #route-fragment,
                        );
```

# Features

## 1. NavigationService

The `NavigationService` provides the necessary method for a new `Navigator`:

```dart
Navigator(
    key: service.navigationKey,
    initialRoute: service.initialRoute,
    observers: <NavigatorObserver>[service.history, ...service.routeObservers],
    onGenerateRoute: service.onGenerateRoute,
    onPopPage: service.onPopPage,
    onUnknownRoute: service.onUnknownRoute,
  );
```

### Owlet Navigator

The `OwletNavigator` is a custom implementation of `Navigator` designed to offer advanced features
like route guards and named functions. By default, the `RouterDelegate` utilizes
the `OwletNavigator`.

```dart
Widget build(BuildContext context) {
  return OwletNavigator(service);
}
```

## 2. Provider

To optimize performance, consider making the NavigationService a singleton within the Navigator.
This can be achieved by creating a singleton variable or utilizing dependency injection, such as
GetIt.

The `NavigationServiceProvider` allows you to access the `NavigationService` within the context.

```dart
final service = NavigationService.of(context);
```

Additionally, creating routes as static fields can enhance performance. However, keep in mind that
static routes cannot dynamically change their parent routes. It's not necessary to create every
route as a static field, the module manager features can still operate with individual routes,
allowing you to create representative routes for each part of the application.

To locate the corresponding `RouteBase` object within the current context, traverse the route tree.

```dart
final route = RouteBase.of<ROUTE_TYPE>(context);
```

However, this approach may result in a worst-case time complexity of O(n * k), where 'n' represents
the average depth of the route tree and 'k' represents the number of `NavigationService` layers. As
mentioned earlier, an alternative approach is to determine the route type directly from the part
route.

```dart
final route = profiles.findType<ROUTE_TYPE>();
```

## 3. Route history

The `NavigationService` offers a route history observer that logs the current routes.

```dart
void listenHistory() {
  final history = service.history;
  history.addListener(() {
    /// Listen when routes change.
    if (kDebugMode) {
      print(history.current);
    }
  });
  final currentRoute = history.current; // Get the current route which is displayed on the top.

  bool isAppeared = history.contains('/home'); // check if the /home route is showing on display 

  // find a route that matches the condition, if you need to do something with it such as the Navigator.replacement.
  final route = history.nearest(/* condition */);
}
```

## 4. Unknown route

If your route cannot be found or if an error occurs during its construction, the unknown route will
be used as a replacement.

```dart
final service = NavigationService(
  // ...
    unknownRoute: yourRoute
);
```

## 5. Route

The `owlet_router` utilizes a module architecture for routing. To define a route, create a class
that extends `RouteBase`. Inside this class, you can specify the children of the route. Repeat this
process for child routes to expand the route tree

```dart
final appRoute = AppRoute();

// ..

class AppRoute extends RouteBase {
  MainRoute() : super.root(); // if this route is the root route

  final splash = MaterialRouteBuilder(
      '/', pageBuilder: (context, settings) => const SplashPage());

  final home = MaterialRouteBuilder(
      '/home', pageBuilder: (context, settings) => const HomePage());

  final items = ListItemRoute('/item');

  @override
  List<RouteBase> get children => [splash, home, items];
}


class ListItemRoute extends RouteBase {
  ListItemRoute(super.segment);

  final list = MaterialRouteBuilder(
      '/list', pageBuilder: (context, settings) => const ListItemPage());

  late final detail = RouteGuard(
    routeBuilder: RouteBuilder<String, dynamic>(
      '/detail',
      builder: (settings) {
        if (settings.arguments is String) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) =>
                DetailPage(item: settings.arguments as String),
          );
        }
        return CancelledRoute(false);
      },
    ),
    routeGuard: (context, route) async {
      if (!navigatorServices.history.contains(list.path)) {
        Navigator.push(context, list.noAnimationBuilder()!);
      }
      return route;
    },
  );

  @override
  List<RouteBase> get children => [detail, list];
}
```

> [!Warning]
>
> Don't forget to add your route to the `List<RouteBase> get children` getter. If it's not
> registered there, the route will not be found.

### 5.1. Route builder

Think of `RouteBase` as a folder; it doesn't create anything, making it a non-launchable route. To
create a page route, we use `RouteBuilder`, which is a launchable route.

```dart
final page1 = RouteBuilder(
  '/page1',
  builder: (settings) =>
      MaterialPageRoute(
        settings: settings,
        builder: (context) => Page1(arguments: settings.arguments),
      ),
);
```

The `RouteBuilder` allows you to customize your `PageRoute`, and we have created
some [custom](#53-custom-routebuilder) `RouteBuilder`. You can also customize your `PageRoute` by
overriding the `RouteBuilder.builder` method.

### 5.2. How does it work?

1. What is the route path?

   To obtain the path of the `splash`, you can use the `splash.path` method. The `splash` path is
   generated by concatenating its parent path with its own path. If the result contains duplicate
   slashes (`//`), they will be merged into one. Therefore, if you wish for the segment to have the
   same route as its parent, simply use a single slash (`/`) as its segment.

2. Push a new route

   If you know the path, a simplified approach is to use `Navigator.pushNamed` to push it onto the
   Navigator.

    ```dart
    Navigator.of(context).pushNamed('/home');
 
    // or
 
    Navigator.of(context).pushNamed(appRoute.home.path);
    ```

   The `RouteBuilder`'s extension provides an other method to push it

   ```dart
   appRoute.home.pushNamed(context);
   ```

3. Argument and result

   The RouteBuilder<A, T>.pushNamed method provides information about the route's argument type
   and result type

    ```dart
    final page2 = RouteBuilder<String, bool>(
     '/page2',
     builder: (settings) {
       final greeting = settings.arguments as String?;
       return MaterialPageRoute(
         builder: (context) => TestApp(content: greeting),
       );
     },
    );
    
    // ...
    final bool result = await page2.pushName(context, args: /* String type is required*/);
    ```

4. In a module:

   If `ListItemRoute` is located within a module package, you cannot access the `appRoute` because
   it is
   defined in the main package. Instead, you can use `RouteBase.of<ListItemRoute>()` to specifically
   retrieve your items route. This approach promotes greater independence of your code between
   different packages.

### 5.3. Custom RouteBuilder

- `MaterialRouteBuilder`: It will create a MaterialPageRoute.
- `CupertinoRouteBuilder`:  It will create a CupertinoPageRoute.
- `NoTransitionRouteBuilder`:  It will create a PageRoute without any transition when appears.

    ```dart
    final splash = MaterialRouteBuilder('/', pageBuilder: (context, settings) => const SplashPage());
    ```

- `RouteGuard`:

    - It exclusively operates with the `OwletNavigator`. The `RouteGuard` offers
      a `routeGuard` method that is invoked before pushing the route. This method allows you to
      modify the route before pushing it.

    - To prevent the route from being pushed, return a `CancelledRoute`. To redirect it, return
      another route or use a `RedirectRoute('redirect-path')` within the `routeGuard` method."

    ```dart
    final detail = RouteGuard(
      route: RouteBuilder<String, dynamic>(
        '/detail',
        builder: (settings) {
          if (settings.arguments is String) {
            return MaterialPageRoute(
                settings: settings,
                builder: (context) => DetailPage(item: settings.arguments as String));
          }
          return CancelledRoute(false);
        },
      ),
      routeGuard: (context, route) async {
        if (!navigatorServices.history.contains(list.path)) {
          Navigator.push(context, list.noAnimationBuilder()!);
        }
        return route;
      },
    );
    ```

  > [!Note]
  >
  >   The `RouteGuard` works only with these functions:
  >   - `Navigator.push`,
  >   - `Navigator.pushNamed`,
  >   - `Navigator.popAndPushNamed`,
  >   - `Navigator.pushReplacement`,
  >   - `Navigator.pushReplacementNamed`,
  >   - `Navigator.pushAndRemoveUntil`,
  >   - `Navigator.pushNamedAndRemoveUntil`

- `NamedFunctionRoute`:

  An ideal approach is to name a function and call it using the Navigator. When pushing a
  NamedFunctionRoute, no route is added; instead, the defined function is invoked, and its result
  will be returned.

  Similar to the RouteGuard, it also functions exclusively with the OwletNavigator.

  ```dart
  final action = NamedFunctionRouteBuilder(
    '/action',
    callback: (context, route) => print('Hello World'),
  );
  ```

  > [!Note]
  >
  > The `NamedFunctionRouteBuilder` works only with these functions:
  > - `Navigator.pushNamed`,
  > - `Navigator.popAndPushNamed`,

### 5.4. Troubleshoot

1. When using the `appRoute.profiles.update.path` method to obtain a route, and you expect the path
   to be `/home/profiles/update`, but the result is `/update`, ensure that you have included this
   route within the `children` getter of the `profile` route.
2. When updating the route's children and encountering [Troubleshoot#1](#54-troubleshoot), even if
   it
   already exists in the children list, make sure you have called the `repair` method after making
   the route changes.
3. For optimal performance, the router should be more stable and undergo fewer changes. Therefore,
   if you encounter issues when changing the route and performing a hot reload, consider utilizing
   the 'hot restart' method to resolve this issue. While the repair method can be effective, it
   demands additional resources, so it is advisable to avoid using it in release mode.

# 6. Nested Navigator

To use a nested navigator. Create a `NestedPage` with the `OwletNavigator`:

```dart
static final nestedService = NavigatorSerivce( /*...*/ );

class NestedPage extends StatefullWidget {

    /// ...
}

class NestedPageState extends State<NestedPage> {

    /// ...
    Widget build(BuildContext context) {
      return OwletNavigator(nestedService);
    }
}
```

In the root route, create a field with `NestedService`:

```dart
class AppRoute extends RouteBase {
    // ...
    final nestedPage = NestedService(
        service: nestedService,
        route: MaterialRouteBuilder('/nested', pageBuilder: (context, settings) => const NestedPage());
    );
}
```

Whenever you push a route as `/nested/sub-path/**`, if the `NestedPage` already exists in the
Navigator, the `nestedService` will be pushed with the path `/sub-path/**`. Otherwise, a new
`NestedPage` will be pushed onto the Navigator.

```dart
Navigator.of(context, rootNavigator: true).pushNamed('/nested/sub-path/**');
```

### NestedRoute

Similar to a nested navigator, nested routes facilitate the division of a route into two components.
The actual route gets injected into the navigation service, while the remaining segment serves as an
argument for the page widget.

```dart

class ItemDetailPageState extends State<ItemDetailPage> {
    
  late final NestedRoute nestedRoute;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      nestedRoute = RouteBase.of<NestedRoute>(context);

      nestedRoute.addListener(onRouteNotifier);
    });
  }

  @override
  void dispose() {
    nestedRoute.removeListener(onRouteNotifier);
    super.dispose();
  }

  void onRouteNotifier() {
    print(nestedRoute.value as RouteSettings?);
  }
}

//....

class AppRoute extends RouteBase {
    // ...
    final itemDetail = NestedRoute(
        route: MaterialRouteBuilder('/item-detail', pageBuilder: (context, settings) => const ItemDetailPage());
    );
}
```

# Inspiration and References

This package draws inspiration from the [flutter_modular](https://pub.dev/packages/flutter_modular)
package and incorporates concepts from the following resources:

- [Navigator](https://api.flutter.dev/flutter/widgets/Navigator-class.html),
- [Provider](https://pub.dev/packages/provider).
- [navigation_history_observer](https://pub.dev/packages/navigation_history_observer),

Additional resources from various forums have also been consulted during the development of this
package.

# Features and bugs

Please file feature requests and bugs at
the [issue tracker](https://github.com/sonnts996/owlet-router/issues).