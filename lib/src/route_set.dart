/*
 Created by Thanh Son on 05/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

/// Route list manager, if a route can be built ([RouteBuilder]), only one route path is accepted in the list.
/// In another case, if a route cannot built, the list can have many instances with the same route path.
///
/// [RouteSet] should be use internal
class RouteSet extends Iterable<RouteBase> {
  /// Create a new [RouteSet] with empty list.
  RouteSet();

  final List<RouteBase> _list = [];

  /// Return true if allow add [value] to list. Otherwise, [Duplicate Path Exception] will be thrown
  /// if a route can be built ([RouteBuilder]), only one route path is accepted in the list.
  /// In another case, if a route cannot built, the list can have many instances with the same route path.
  bool _verifyRoute(RouteBase value) => !_list.any((element) {
        if ((element is RouteBuilder && value is RouteBuilder) &&
            element.fullRoute == value.fullRoute) {
          throw DuplicatePathException(
              error:
                  '${value.runtimeType}(${value.fullRoute}) already existed in routes');
        }
        return false;
      });

  /// Return the [RouteBase] at [index]
  RouteBase operator [](int index) => _list[index];

  /// Set the [RouteBase] value at [index]. if [_verifyRoute] is not allow, an exception will be thrown.
  void operator []=(int index, RouteBase value) {
    assert(_verifyRoute(value));

    _list[index] = value;
  }

  ///  Return the [RouteBase] match the [test] condition, the [RouteBuilder] is a priority to return.
  ///  If no [RouteBuilder] is a match, the first [RouteBase] will be returned.
  ///  Finally, nothing is matched, a null is the last value.
  RouteBase? routeWhere(bool Function(RouteBase element) test) {
    RouteBase? route;
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
  void add(RouteBase value) {
    assert(_verifyRoute(value));
    _list.add(value);
  }

  /// Add all values in [routeSet] value at the end of the list. if [_verifyRoute] is not allow, an exception will be thrown.
  ///
  /// Warning: For each item in the list to still be added.  until the route, which [_verifyRoute] disallows.
  /// So, if you catch this exception maybe make the list has the wrong value.
  void addAll(RouteSet routeSet) {
    for (var i in routeSet) {
      add(i);
    }
  }

  @override
  Iterator<RouteBase> get iterator => _RouteSetIterator(_list);
}

class _RouteSetIterator implements Iterator<RouteBase> {
  _RouteSetIterator(this._list);

  int _index = -1;
  final List<RouteBase> _list;

  @override
  RouteBase get current => _list[_index];

  @override
  bool moveNext() {
    _index++;
    return _index < _list.length;
  }
}
