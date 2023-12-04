# Route

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