/*
 Created by Thanh Son on 05/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of route_base;

/// Route list's manager.
/// If a route can be built (as [RouteBuilder]), only one route's path is accepted in the list.
/// In another case, if a route cannot built, the list can have many instances with the same route path.
class RouteSet extends Iterable<RouteSegment> {
  /// Create a new [RouteSet] with empty list.
  RouteSet();

  final List<RouteSegment> _list = [];

  /// Returns true if allow add [value] to list. Otherwise, [DuplicatePathException] will be thrown
  /// If a route can be built (as [RouteBuilder]), only one route's path is accepted in the list.
  /// In another case, if a route cannot built, the list can have many instances with the same route path.
  bool _verifyRoute(RouteSegment value) => !_list.any((element) {
        if ((element is RouteBuilder && value is RouteBuilder) && element.path == value.path) {
          throw DuplicatePathException(error: '${value.runtimeType}(${value.path}) already existed in routes');
        }
        return false;
      });

  /// Returns the [RouteSegment] at [index].
  RouteSegment operator [](int index) => _list[index];

  /// Sets the [RouteSegment] value at [index]. If [_verifyRoute] is not allow, an exception will be thrown.
  void operator []=(int index, RouteSegment value) {
    assert(_verifyRoute(value));

    _list[index] = value;
  }

  ///  Returns the [RouteSegment] match the [test] condition, the [RouteBuilder] is a priority to return.
  ///  If there are no [RouteBuilder] matches, the first [RouteSegment] will be returned.
  ///  Finally, nothing is matched, a null is the last result.
  RouteSegment? routeWhere(bool Function(RouteSegment element) test) {
    RouteSegment? route;
    for (var i in _list) {
      if (test(i)) {
        if (i is RouteBuilder) {
          return i;
        } else {
          route = i;
        }
      }
    }
    return route;
  }

  /// Add the [value] value at the end of the list. if [_verifyRoute] is not allow, an exception will be thrown.
  void add(RouteSegment value) {
    assert(_verifyRoute(value));
    _list.add(value);
  }

  /// Add all values in [routeSet] value at the end of the list. If [_verifyRoute] is not allow, an exception will be thrown.
  ///
  /// Warning: For each item in the list to still be added until the route, which [_verifyRoute] disallows.
  /// So, if you catch this exception maybe make the list has the wrong value.
  void addAll(RouteSet routeSet) {
    for (var i in routeSet) {
      add(i);
    }
  }

  @override
  List<RouteSegment> toList({bool growable = true}) => _list;

  @override
  Iterator<RouteSegment> get iterator => _RouteSetIterator(_list);
}

class _RouteSetIterator implements Iterator<RouteSegment> {
  _RouteSetIterator(this._list);

  int _index = -1;
  final List<RouteSegment> _list;

  @override
  RouteSegment get current => _list[_index];

  @override
  bool moveNext() {
    _index++;
    return _index < _list.length;
  }
}
