// ignore_for_file: missing_override_of_must_be_overridden

/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

/// The top-level parent of routes. Using the Origin Route to apply the router to all of the route members.
class OriginRoute extends RouteBase {
  /// The Origin route's path should be '/'.
  OriginRoute([String path = '/']) : super(path) {
    _init();
  }

  void _init() => _routes;
}

/// Create a route wrapper with it's route path.
/// The [parent] field is a lazy update after running. The parent is the object, which defines this in [RouteBase.routes].
///
/// Note that a route can have only one parent, which means, an error will be thrown if update a  non-null [RouteBase.parent] to a new value.
class RouteBase {
  /// Create new route with it's path. This route path does not include the parent router.
  ///
  /// Note the the path must be start with '/'
  RouteBase(this.path) : assert(path.startsWith('/'), 'Path must be start with /');

  /// This route path does not include the parent router
  final String path;

  RouteBase? _parent;

  /// Return this parent router, if null, this may not have a parent or not have applied the parent route yet.
  RouteBase? get parent => _parent;

  /// Must be overridden this getter, if this route has children, all it's children must be defined in the returned list.
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

  /// Return this [fullRoute] as [Uri]
  Uri get uri => Uri.parse(fullRoute);

  /// Return the final route, which contains the [parent] router and this [path]. If not have the [parent], only this [path] is returned.
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
  String toString() => '$runtimeType($fullRoute)';

  /// Set the parent for this route.
  /// If the parent is this route's parent, nothing happens.
  /// If this route's parent is null, the parent will be applied.
  /// Otherwise, an exception will be thrown, cause the route had a parent.
  void apply(RouteBase? parent) {
    if (this.parent != null && this.parent != parent) {
      throw InvalidRouteException(
          error: '${toString()} already has a parent (${this.parent.toString()}.'
              "Can not use an instance route in more than a parent route. Let's create another instance of this.");
    }

    _parent = parent;
  }

  /// Compare this [fullRoute] with the [route], and return true if the router path is the same.
  bool isRoute(Route route) => route.settings.name == fullRoute;
}

T _unimplementedBuilder<T>(String path) {
  throw UnimplementedError('_unimplementedBuilder:'
      'Could not found RouterBuilder or PageBuilder of this route: $path');
}

/// Return the route builder to build a new page widget with a [settings].
/// The [settings] contained the route and arguments.
typedef RouterBuilder = Route Function(BuildContext context, RouteSettings settings);

/// Return the page widget with a [settings].
/// The [settings] contained the route and arguments.
typedef PageBuilder = Widget Function(BuildContext context, RouteSettings settings);

/// If the route can build a page, it must be an instance of [RouteBuilder].
/// The argument of this route has type is [T]
class RouteBuilder<T extends Object> extends RouteBase {
  /// Create new [RouteBase] with [path].
  /// Route [builder] return a [Route] for [Navigator] build this page.
  /// If don't want to define it, can override the [builder] function.
  /// If the [_builder] is null. Nothing happens if do not open this route until you open this route.
  RouteBuilder(super.path, {
    RouterBuilder? builder,
  }) : _builder = builder;

  final RouterBuilder? _builder;

  /// Return the builder to build the route.
  /// If the [_builder] is null. Nothing happens if do not open this route until you open this route.
  Route builder(BuildContext context, RouteSettings settings) => _builder.letOrNull(
        (it) => it(context, settings),
    onNull: () => _unimplementedBuilder(toString()),
  );
}

/// The [RouteBuilder] with [MaterialPageRoute].
/// The argument of this route has type is [T]
class MaterialBuilder<T extends Object> extends RouteBuilder<T> {
  /// Create the [RouteBuilder] with [MaterialPageRoute] options.
  MaterialBuilder(super.path, {
    this.materialBuilder,
    this.maintainState = true,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
  });

  /// return a page widget with [RouteSettings]
  final PageBuilder? materialBuilder;

  /// Transfer to [MaterialPageRoute.maintainState]
  final bool maintainState;

  /// Transfer to [MaterialPageRoute.fullscreenDialog]
  final bool fullscreenDialog;

  /// Transfer to [MaterialPageRoute.allowSnapshotting]
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

/// The [RouteBuilder] with [CupertinoPageRoute].
/// The argument of this route has type is [T]
class CupertinoBuilder<T extends Object> extends RouteBuilder<T> {
  /// Create the [RouteBuilder] with [MaterialPageRoute] options.
  CupertinoBuilder(super.path, {
    this.cupertinoBuilder,
    this.maintainState = true,
    this.allowSnapshotting = true,
    this.fullscreenDialog = false,
    this.title,
  });

  /// return a page widget with [RouteSettings]
  final PageBuilder? cupertinoBuilder;

  /// Transfer to [CupertinoPageRoute.maintainState]
  final bool maintainState;

  /// Transfer to [CupertinoPageRoute.fullscreenDialog]
  final bool fullscreenDialog;

  /// Transfer to [CupertinoPageRoute.allowSnapshotting]
  final bool allowSnapshotting;

  /// Transfer to [CupertinoPageRoute.title]
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
