## 5.1. Route builder

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