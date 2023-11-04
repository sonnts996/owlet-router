# Owlet Router

The `owlet_router` is a router manager. It is not a route, it uses the route builder to build the
router.

It is built based on purposes:

- A clear router manager. Easy to define, read, and use it.
- It uses on base Flutter Router, easy to integrate with many page route types, customize, and
  extend the router.
- Modularization of the router, easy to split the route, and built independent routes.
- Can check before pushing, preventing, or redirecting route.

# Table of content

- [Getting started](#getting-started)
- [Usage](#usage)
    - [1. NavigationService](#1-navigationservice)
        - [Second Navigator](#in-the-second-navigator)
        - [1.1. Owlet Navigator](#11-owlet-navigator)
        - [1.2. Provider](#12-provider)
        - [1.2. Route history](#13-route-history)
        - [1.4. Unknown Route](#14-if-the-route-can-not-build)
    - [2. Route](#2-route)
        - [2.1. Route builder](#21-route-builder)
        - [2.2. Route usage](#22-how-does-it-work)
        - [2.3. Custom route builder](#23-custom-route-builder)
- [Integration](#integration)
    - [Flutter Router](#flutter-router)
    - [Modular](#modular)
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

## 1. NavigationService

The `NavigationService` provides the necessary method for a new `Navigator`:

```dart

final appRoute = AppRoute(); // The root route

final service = NavigationService(
    navigationKey: GlobalKey(),
    routeObservers: [ /* your observers */
    ],
    initialRoute: '/',
    root: appRoute,
    unknownRoute: owletDefaultUnknownRoute);

// ...

Widget build(BuildContext context) {
  return MaterialApp.router(
    routerConfig: service.routerConfig,

    /// ...
  );
}
```

#### In the second `Navigator`:

The `NavigationService` is also used in an independent `Navigator`.

```dart
Widget build(BuildContext context) {
  return Navigator(
    key: service.navigationKey,
    initialRoute: service.initialRoute,
    observers: <NavigatorObserver>[service.history, ...service.routeObservers],
    onGenerateRoute: service.onGenerateRoute,
    onPopPage: service.onPopPage,
    onUnknownRoute: service.onUnknownRoute,
  );
}

// or

Widget build(BuildContext context) {
  return OwletNavigator.from(service);
}
```

### 1.1. Owlet Navigator

The `OwletNavigator` is a `Navigator`'s implementation for the advanced features such as route guard
or named function. By default, `RouterDelegate` uses the `OwletNavigator`.

```dart
Widget build(BuildContext context) {
  return NavigationServiceProvider(
      service: service,
      child: OwletNavigator(
        key: service.navigationKey,
        initialRoute: service.initialRoute,
        observers: <NavigatorObserver>[service.history, ...service.routeObservers],
        onGenerateRoute: service.onGenerateRoute,
        onPopPage: service.onPopPage,
        onUnknownRoute: service.onUnknownRoute,
      ));
}

// or

Widget build(BuildContext context) {
  return OwletNavigator.from(service);
}
```

### 1.2. Provider

The `NavigationService` must be a singleton in the `Navigator`. You can create a singleton variable
or use an injection (such as GetIt).

The `NavigationServiceProvider` allows you to get the `NavigationService` in the context. By
default, it use in `RouteDelegate` (`service.routerConfig`)
or `OwletNavigator.from`.

```dart
// To get NavigationServiceProvider
final provider = NavigationServiceProvider.of(context);

// To get NavigationService
final service = NavigationService.of(context);

// To get your route in NavigationService
final route = RouteBase.of<ROUTE_TYPE>(context);
```

> By default, the `RouteBase.of` will return your root route (`service.root`), you can
> use `ROUTE_TYPE` to cast to the defined data type.
>
> If you want to get a special route branch,
> the `RouteBase.of<ROUTE_TYPE>(context, depthSearch: true)` allows finding a route in the route
> tree that matches `ROUTE_TYPE`.

### 1.3. Route history

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

  bool isAppeared = history.contains(
      '/home'); // check if the /home route is showing on display 

  // find a route that matches the condition, if you need to do something with it such as the Navigator.replacement.
  final route = history.nearest(/* condition */);
}
```

The `NavigationService` provides a route history observer that logs the current routes.
If you want to use it in your `Navigator`, let's put it into your route observers list.

```dart
Widget build(BuildContext context) {
  return Navigator(
    // ..
    observers: <NavigatorObserver>[service.history, ...service.routeObservers],
  );
}
```

### 1.4. If the route can not build

If can not find your route or the route is thrown an error when built, the unknown route will be
used as a replacement.

```dart

final service = NavigationService(
  // ...
    unknownRoute: yourRoute
);
```

## 2. Route

The `owlet_router` uses the module architecture for the router. To define a route, you create a
class that extends a RouteBase. Inside it, you can define the children of this route. Repeat this to
the child route to expand the route tree.

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

  late final detail = RouteGuardBuilder(
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
    routeGuard: (pushContext, route) async {
      if (!navigatorServices.history.contains(list.path)) {
        Navigator.push(pushContext, list.noAnimationBuilder()!);
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
> Do not forget add your route into the getter `List<RouteBase> get children`. The route
> will be not found if not register in it.

### 2.1. Route builder

The `RouteBase` is like a folder, it can not build anything, we call it a non-launchable route.
To build a page route, we use `RouteBuilder` (launchable route).

```dart

final page1 = RouteBuilder(
  '/page1',
  builder: (settings) =>
      MaterialPageRoute(
        settings: settings,
        builder: (context) =>
            Page1(
                arguments: settings.arguments
            ),
      ),
);
```

The `RouteBuilder` allows customize your `PageRoute`, we have created some custom `RouteBuilder`
below. You also custom your PageRoute by overriding the `RouteBuilder.builder` method.

### 2.2. How does it work?

1. The `appRoute` can not work if not defined in `NavigationService`. You must define it:

    ```dart
    
    final appRoute = AppRoute(); // The root route
    
    final service = NavigationService(
    
      /// ...
      root: appRoute,
    );
    ```

2. What is the route path?

   To get the `splash`'s path, you can call `splash.path` method. The `splash` path will be
   generated by concat its parent path with its path. If the result appears duplicate slash (`//`),
   it will merge it into one. So, if you want the segment to have the same route as its parent,
   let's put a single slash (`/`) as its segment.

3. Push it onto the Navigator

   If you know this path, a simplified method is using Navigator.pushNamed to push it onto the
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

4. Argument and result

   The `RouteBuilder<ARGS, T>.pushNamed` will let you know the route arguments type and route result
   type.

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

5. In a module

   If `ListItemRoute` is in a module package, you can not get the `appRoute` (cause it is defined in
   the main package).
   You can use `RouteBase.of<ListItemRoute>()` to get only your `items` route. This method allows
   your code to be more independent between each package.

6. What happens if have many routes with the same path?

   That is allowed if your route is non-launchable. Otherwise, if your route is launchable, an
   exception will be thrown because the NavigationService can not know which route will be pushed.

### 2.3. Custom route builder

- `MaterialRouteBuilder`: It will create a MaterialPageRoute.
- `CupertinoRouteBuilder`:  It will create a CupertinoPageRoute.
- `NoTransitionRouteBuilder`:  It will create a PageRoute without any transition when appears.

    ```dart
    final splash = MaterialRouteBuilder('/', pageBuilder: (context, settings) => const SplashPage());
    ```

- `RouteGuardBuilder`:

    * It is only working with the `OwletNavigator`. The `RouteGuardBuilder` provides a `routeGuard`
      method, that will be called before pushing the route. You also can modify your route before
      pushing it.

    * To cancel the pushing, let's return a `CancelledRoute`. To redirect it, return another route
      or a
      `RedirectRoute('newPath')` in the `routeGuard` method.

      ```dart
      final detail = RouteGuardBuilder(
        routeBuilder: RouteBuilder<String, dynamic>(
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
        routeGuard: (pushContext, route) async {
          if (!navigatorServices.history.contains(list.path)) {
            Navigator.push(pushContext, list.noAnimationBuilder()!);
          }
          return route;
        },
      );
      ```

      > [!Note]
      >
      > The `RouteGuardBuilder` works only with these functions:
      > - `Navigator.push`,
      > - `Navigator.pushNamed`,
      > - `Navigator.popAndPushNamed`,
      > - `Navigator.pushReplacement`,
      > - `Navigator.pushReplacementNamed`,
      > - `Navigator.pushAndRemoveUntil`,
      > - `Navigator.pushNamedAndRemoveUntil`

- `NamedFunctionRoute`:

  An ideal about named a function, and call it by `Navigator`. If pushing a `NamedFunctionRoute`, no
  route is pushed, only the defined function is called and returns the result.

  Like `RouteGuardBuilder`, it also work only with `OwletNavigator`.

  ```dart
  final action = NamedFunctionRouteBuilder(
    '/action',
    callback: (pushContext, route) => print('Hello World'),
  );
  ```

  > [!Note]
  >
  > The `RouteGuardBuilder` works only with these functions:
  > - `Navigator.pushNamed`,
  > - `Navigator.popAndPushNamed`,

# Integration

## Flutter router

## Modular

# Features and bugs

Please file feature requests and bugs at
the [issue tracker](https://github.com/sonnts996/owlet-router/issues).