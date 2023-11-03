/*
 Created by Thanh Son on 05/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_base;

/// Route list's manager.
/// If a route can be built, only one route's path is accepted in the list.
/// In another case, if a route cannot built, the list can have many instances with the same route path.
class RouteSet extends Iterable<RouteMixin> {
  /// Create a new [RouteSet] with empty list.
  RouteSet([List<RouteMixin>? list]) : _list = list ?? [];

  final List<RouteMixin> _list;

  /// Returns true if allows adding [value] into the list. Otherwise, [DuplicatePathException] will be thrown
  /// If a route can be built, only one route's path is accepted in the list.
  /// In another case, if a route cannot built, the list can have many instances with the same route path.
  bool _verifyRoute(RouteMixin value) => !_list.any((element) {
        if ((element.canLaunch && value.canLaunch) && element.path == value.path) {
          throw DuplicatePathException(error: '${value.runtimeType}(${value.path}) already existed in routes');
        }
        return false;
      });

  /// Returns the [RouteMixin] at [index].
  RouteMixin operator [](int index) => _list[index];

  /// Sets the [RouteMixin] value at [index]. If [_verifyRoute] is not allowed, an exception will be thrown.
  void operator []=(int index, RouteMixin value) {
    assert(_verifyRoute(value));

    _list[index] = value;
  }

  ///  Returns the [RouteMixin] match the [test] condition, the [RouteMixin.canLaunch] is a priority to return.
  ///  If there are no routes can launch, the first route will be returned.
  ///  Finally, nothing is matched, a null is the last result.
  RouteMixin? routeWhere(bool Function(RouteMixin element) test) {
    RouteMixin? route;
    for (var i in _list) {
      if (test(i)) {
        if (i.canLaunch) {
          return i;
        } else {
          route = i;
        }
      }
    }
    return route;
  }

  /// Add the [value] value at the end of the list. if [_verifyRoute] is not allow, an exception will be thrown.
  void add(RouteMixin value) {
    assert(_verifyRoute(value));
    _list.add(value);
  }

  /// Add all values in [routeSet] value at the end of the list. If [_verifyRoute] is not allow, an exception will be thrown.
  ///
  /// __Warning:__ For each item in the list to still be added until the route, which [_verifyRoute] disallows.
  /// So, if you catch this exception maybe make the list has the wrong value.
  void addAll(RouteSet routeSet) {
    for (var i in routeSet) {
      add(i);
    }
  }

  @override
  List<RouteMixin> toList({bool growable = true}) => _list;

  @override
  Iterator<RouteMixin> get iterator => _RouteSetIterator(_list);

  @override
  String toString() {
    if (_list.isEmpty) return 'Empty routes.';
    final max = (maxBy(_list, (p0) => p0.path.length)?.path.length ?? 0) + 1;
    return _list
        .map((e) => '${e.path.padRight(max)}: ${e.runtimeType}(canLaunch: ${e.canLaunch}, isCallback: ${e.isCallback})')
        .join('\n');
  }

  /// Sorted the route by path.
  void sorted() {
    _list.sort((a, b) => a.path.compareTo(b.path));
  }
}

class _RouteSetIterator implements Iterator<RouteMixin> {
  _RouteSetIterator(this._list);

  int _index = -1;
  final List<RouteMixin> _list;

  @override
  RouteMixin get current => _list[_index];

  @override
  bool moveNext() {
    _index++;
    return _index < _list.length;
  }
}
