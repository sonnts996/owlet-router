/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of 'router_services.dart';

///
/// A [RouteInformationParser] to parse between [RouteBase] and [RouteInformation]
class OwletInformationParser extends RouteInformationParser<RouteMixin> {
  ///
  /// Create a [OwletInformationParser]
  OwletInformationParser({required this.service});

  ///
  /// Provide the finder to find [RouteBase] from [RouteInformation]
  final NavigationService service;

  @override
  Future<RouteMixin> parseRouteInformation(RouteInformation routeInformation) async =>
      service.findRoute(routeInformation.uri.path) ?? RouteBase(routeInformation.uri.path);

  @override
  RouteInformation? restoreRouteInformation(RouteMixin configuration) =>
      RouteInformation(uri: Uri.parse(configuration.segment));
}
