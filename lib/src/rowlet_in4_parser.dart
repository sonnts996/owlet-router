/*
 Created by Thanh Son on 16/08/2023.
 Copyright (c) 2023 . All rights reserved.
*/

part of owlet_router;

/// A [RouteInformationParser] to parse between [RouteSegment] and [RouteInformation]
class ROwletInformationParser extends RouteInformationParser<RouteSegment> {
  /// Create a [ROwletInformationParser]. Which requires a NavigationService to find the route match [RouteInformation].
  ROwletInformationParser({required this.service});

  /// Provide the finder to find [RouteSegment] from [RouteInformation]
  final NavigationServiceBase service;

  @override
  Future<RouteSegment> parseRouteInformation(RouteInformation routeInformation) async =>
      service.findRoute(routeInformation.uri.path) ?? RouteSegment(routeInformation.uri.path);

  @override
  RouteInformation? restoreRouteInformation(RouteSegment configuration) =>
      RouteInformation(uri: Uri.parse(configuration.segmentPath));
}
