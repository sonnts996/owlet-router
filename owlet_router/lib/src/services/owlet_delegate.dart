/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of 'router_services.dart';

///
/// Implementing a [RouterDelegate] using [RouteBuilder].
class OwletDelegate<R extends RouteMixin> extends RouterDelegate<RouteBuilder>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  ///
  /// The [OwletDelegate]'s constructor.
  OwletDelegate({
    required this.service,
    this.transitionDelegate = const DefaultTransitionDelegate(),
    this.clipBehavior = Clip.hardEdge,
    this.reportsRouteUpdateToEngine = false,
    this.requestFocus = true,
    this.restorationScopeId,
    this.routeTraversalEdgeBehavior = kDefaultRouteTraversalEdgeBehavior,
  });

  ///
  /// The navigation service exposes Owlet Router information.
  final NavigationService<R> service;

  ///
  /// Map to [Navigator.transitionDelegate]
  final TransitionDelegate transitionDelegate;

  ///
  /// Map to [Navigator.clipBehavior]
  final Clip clipBehavior;

  ///
  /// Map to [Navigator.reportsRouteUpdateToEngine]
  final bool reportsRouteUpdateToEngine;

  ///
  /// Map to [Navigator.requestFocus]
  final bool requestFocus;

  ///
  /// Map to [Navigator.restorationScopeId]
  final String? restorationScopeId;

  ///
  /// Map to [Navigator.routeTraversalEdgeBehavior]
  final TraversalEdgeBehavior routeTraversalEdgeBehavior;

  RouteBuilder? _currentConfiguration;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => service.navigationKey;

  @override
  Widget build(BuildContext context) => OwletNavigator(
        service,
        reportsRouteUpdateToEngine: reportsRouteUpdateToEngine,
        transitionDelegate: transitionDelegate,
        clipBehavior: clipBehavior,
        requestFocus: requestFocus,
        restorationScopeId: restorationScopeId,
        routeTraversalEdgeBehavior: routeTraversalEdgeBehavior,
      );

  @override
  RouteBuilder? get currentConfiguration => _currentConfiguration;

  @override
  Future<void> setNewRoutePath(RouteBuilder configuration) async {
    _currentConfiguration = configuration;
    notifyListeners();
  }
}
