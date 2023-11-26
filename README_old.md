# Owlet Router

<table style="border: none;">
<tr style="border: none;">
<td style="border: none; vertical-align: top;">
<img src="https://github.com/sonnts996/owlet-router/blob/main/example/assets/owlets_on_the_tree.jpg?raw=true" alt="owlets_on_the_tree" width="300"/>

</td>
<td style="border: none; vertical-align: top;">
The `owlet_router` is a route manager, not a route itself. It utilizes the route builder to
construct the router.

It is designed with several purposes in mind:

- Providing a clear and easily definable route manager that is simple to read and use.
- Built upon the base Flutter Router, allowing for integration with various page route types and the
  ability to customize and extend the router.
- Enabling modularization of the router, making it easy to segment routes and create independent
  routes.
- Offering the capability to check, prevent, or redirect routes before they are pushed.

</td>
</tr>
</table>

```dart
class AppRoute extends RouteBase {
  class AppRoute():super.root();
  
  final profiles = ProfileRoute('/profile');

  List<RouteBase> get children => [profiles];
}

class ProfileRoute extends RouteBase {
  class ProfileRoute(super.segment);
  
  final details = MaterialRouteBuilder(
      '/', pageBuilder: (context, settings) => const DetailsPage());

  final update = MaterialRouteBuilder(
      '/update-profile', pageBuilder: (context, settings) => const UpdateProfilePage());

  List<RouteBase> get children => [details, update];
}

/// ...
await appRoute.profiles.update.pushNamed(context);
```

# Table of content

- [Getting started](#getting-started)
- [Usage](#usage)
    - [1. NavigationService](#1-navigationservice)
        - [Second Navigator](#in-the-second-navigator)
        - [1.1. Owlet Navigator](#11-owlet-navigator)
        - [1.2. Provider](#12-provider)
        - [1.2. Route history](#13-route-history)
        - [1.4. Unknown Route](#14-unknown-route)
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
    routeObservers: [ /* your observers */],
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

The `NavigationService` is also used in standalone `Navigator` instances.

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

The `OwletNavigator` is a custom implementation of `Navigator` designed to offer advanced features
like route guards and named functions. By default, the `RouterDelegate` utilizes
the `OwletNavigator`.

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

The `NavigationService` should be a singleton in the `Navigator`. You can create a singleton
variable or use dependency injection, for example, with GetIt.

The `NavigationServiceProvider` allows you to access the `NavigationService` within the
context. By default, it is exclusively used in `RouteDelegate` through `service.routerConfig`.

```dart
// To get NavigationServiceProvider
final provider = NavigationServiceProvider.of(context);

// To get NavigationService
final service = NavigationService.of(context);

// To get your route in NavigationService
final route = RouteBase.of<ROUTE_TYPE>(context);
```

> By default, `RouteBase.of` will return your root route (`service.root`), and you can
> use `ROUTE_TYPE` to cast it to the defined data type.
>
> If you want to retrieve a specific route branch, you can
> use `RouteBase.of<ROUTE_TYPE>(context, depthSearch: true)`. This allows you to find a route in the
> route tree that matches `ROUTE_TYPE`.

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

The `NavigationService` offers a route history observer that logs the current routes. If you want to
utilize it in your `Navigator`, simply add it to your route observers list.

```dart
Widget build(BuildContext context) {
  return Navigator(
    // ..
    observers: <NavigatorObserver>[service.history, ...service.routeObservers],
  );
}
```

### 1.4. Unknown route

If your route cannot be found or if an error occurs during its construction, the unknown route will
be used as a replacement.

```dart
final service = NavigationService(
  // ...
    unknownRoute: yourRoute
);
```

## 2. Route

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

### 2.1. Route builder

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
some [custom](#23-custom-route-builder) `RouteBuilder`. You can also customize your `PageRoute` by
overriding the `RouteBuilder.builder` method.

### 2.2. How does it work?

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

5. What happens if you have multiple routes with the same path?

   If your route is non-launchable, this is allowed. However, if your route is launchable, an
   exception will be thrown because the NavigationService cannot determine which route to push.

### 2.3. Custom route builder

- `MaterialRouteBuilder`: It will create a MaterialPageRoute.
- `CupertinoRouteBuilder`:  It will create a CupertinoPageRoute.
- `NoTransitionRouteBuilder`:  It will create a PageRoute without any transition when appears.

    ```dart
    final splash = MaterialRouteBuilder('/', pageBuilder: (context, settings) => const SplashPage());
    ```

- `RouteGuardBuilder`:

    - It exclusively operates with the `OwletNavigator`. The `RouteGuardBuilder` offers
      a `routeGuard` method that is invoked before pushing the route. This method allows you to
      modify the route before pushing it.

    - To prevent the route from being pushed, return a `CancelledRoute`. To redirect it, return
      another route or use a `RedirectRoute('newPath')` within the `routeGuard` method."

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
  >   The `RouteGuardBuilder` works only with these functions:
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

  Similar to the RouteGuardBuilder, it also functions exclusively with the OwletNavigator.

  ```dart
  final action = NamedFunctionRouteBuilder(
    '/action',
    callback: (context, route) => print('Hello World'),
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

# Troubleshoot

1. "When using the `appRoute.profiles.update.path` method to obtain a route, and you expect the path
   to be `/home/profiles/update`, but the result is `/update`, ensure that you have included this
   route within the `children` getter of the `profile` route."
2. When updating the route's children and encountering [Troubleshoot#1](#troubleshoot), even if it
   already exists in the children list, make sure you have called the `repair` method after making
   the route changes.
3. For optimal performance, the router should be more stable and undergo fewer changes. Therefore,
   if you encounter issues when changing the route and performing a hot reload, consider utilizing
   the 'hot restart' method to resolve this issue. While the repair method can be effective, it
   demands additional resources, so it is advisable to avoid using it in release mode.

# Features and bugs

Please file feature requests and bugs at
the [issue tracker](https://github.com/sonnts996/owlet-router/issues).