/*
 Created by Thanh Son on 29/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
part of nested_route;

///
/// Notify when a route is pushed, setting the notifier's value to the pushed route's settings.
mixin class RouteNotifier
    implements ChangeNotifier, ValueListenable<RouteSettings?> {
  final ValueNotifier<RouteSettings?> _notifier = ValueNotifier(null);

  @override
  RouteSettings? get value => _notifier.value;

  /// Recently pushed router settings.
  RouteSettings? get settings => _notifier.value;

  ///
  /// Notify that the route's [settings] have been updated.
  /// Set the [ignoreDuplicate] flag to true to skip notifiers if the [settings] remain unchanged.
  @internal
  void updateRouteSettings(RouteSettings settings,
      {bool ignoreDuplicate = false}) {
    if (!ignoreDuplicate || (ignoreDuplicate && _notifier.value == settings)) {
      _notifier.value = settings;
    }
  }

  @override
  void addListener(VoidCallback listener) {
    _notifier.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _notifier.removeListener(listener);
  }

  @override
  void dispose() {
    _notifier.dispose();
  }

  @override
  bool get hasListeners => _notifier.hasListeners;

  @override
  void notifyListeners() {
    _notifier.notifyListeners();
  }
}
