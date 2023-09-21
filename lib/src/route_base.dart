/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

@immutable
class RouteBase {
  RouteBase(this.path);

  final String path;
  RouteBase? parent;

  @mustBeOverridden
  List<RouteBase> get routes => [];

  RouteSet get _routes {
    final sets = RouteSet();
    sets.add(this);
    if (routes.isNotEmpty) {
      for (final i in routes) {
        i.apply(this);
        sets.addAll(i._routes);
      }
    }
    return sets;
  }

  Uri get uri => Uri.parse(fullRoute);

  Map<String, String> get queryParameter => uri.queryParameters;

  String get fullRoute {
    assert(path.startsWith('/'), 'Path must be start with /');
    return parent.letOrNull(
      (it) {
        if (it.path == '/') return path;
        return '${it.fullRoute}$path';
      },
      onNull: () => path,
    );
  }

  @override
  int get hashCode => Object.hashAll([path]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RouteBase && path == other.path;
  }

  @override
  String toString() => '$runtimeType($fullRoute)';

  void apply(RouteBase? parent) {
    if (this.parent != null && this.parent != parent) {
      throw InvalidRouteException(
          error: '${toString()} already has a parent (${this.parent.toString()}.'
              "Can not use an instance route in more than a parent route. Let's create another instance of this.");
    }

    this.parent = parent;
  }

  bool isRoute(Route route) => route.settings.name == fullRoute;
}

T _unimplementedBuilder<T>(String path) {
  throw UnimplementedError('_unimplementedBuilder:'
      'Could not found RouterBuilder or PageBuilder of this route: $path');
}

typedef RouterBuilder = Route Function(BuildContext context, RouteSettings settings);

typedef PageBuilder = Widget Function(BuildContext context, RouteSettings settings);

class RouteBuilder<T extends Object> extends RouteBase {
  RouteBuilder(
    super.path, {
    RouterBuilder? builder,
  }) : _builder = builder;

  final RouterBuilder? _builder;

  Route builder(BuildContext context, RouteSettings settings) => _builder.letOrNull(
        (it) => it(context, settings),
        onNull: () => _unimplementedBuilder(toString()),
      );
}

class MaterialBuilder<T extends Object> extends RouteBuilder<T> {
  MaterialBuilder(
    super.path, {
    this.materialBuilder,
    this.maintainState = true,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
  });

  final PageBuilder? materialBuilder;
  final bool maintainState;
  final bool fullscreenDialog;
  final bool allowSnapshotting;

  @override
  Route builder(BuildContext context, RouteSettings settings) => materialBuilder.letOrNull(
        (it) => MaterialPageRoute(
          builder: (context) => it(context, settings),
          allowSnapshotting: allowSnapshotting,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          settings: settings,
        ),
        onNull: () => _unimplementedBuilder(toString()),
      );
}

class CupertinoBuilder<T extends Object> extends RouteBuilder<T> {
  CupertinoBuilder(
    super.path, {
    this.cupertinoBuilder,
    this.maintainState = true,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
    this.title,
  });

  final PageBuilder? cupertinoBuilder;
  final bool maintainState;
  final bool fullscreenDialog;
  final bool allowSnapshotting;
  final String? title;

  @override
  Route builder(BuildContext context, RouteSettings settings) => cupertinoBuilder.letOrNull(
        (it) => CupertinoPageRoute(
          builder: (context) => it(context, settings),
          allowSnapshotting: allowSnapshotting,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
          settings: settings,
          title: title,
        ),
        onNull: () => _unimplementedBuilder(toString()),
      );
}
