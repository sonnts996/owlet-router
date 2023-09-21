/*
 Created by Thanh Son on 05/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of owlet_router;

class RouteSet extends Iterable<RouteBase> {
  RouteSet();

  final List<RouteBase> _list = [];

  bool _verifyRoute(RouteBase value) => !_list.any((element) {
        if ((element is RouteBuilder && value is RouteBuilder) &&
            element.fullRoute == value.fullRoute) {
          throw DuplicatePathException(
              error:
                  '${value.runtimeType}(${value.fullRoute}) already existed in routes');
        }
        return false;
      });

  RouteBase operator [](int index) => _list[index];

  void operator []=(int index, RouteBase value) {
    assert(_verifyRoute(value));

    _list[index] = value;
  }

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

  void add(RouteBase value) {
    assert(_verifyRoute(value));
    _list.add(value);
  }

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
