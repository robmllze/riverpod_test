// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKINect
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart'
    show RouteInformation, RouteInformationParser, debugPrint;

import 'my_route_configuration.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyRouteInformationParser
    extends RouteInformationParser<MyRouteConfiguration> {
  //
  //
  //

  static String? _initialLocation;
  static void setInitialLocation(String initialLocation) =>
      _initialLocation = initialLocation;

  //
  //
  //

  @override
  Future<MyRouteConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final targetLocation = routeInformation.location;
    var location = _initialLocation ?? targetLocation;
    if (targetLocation?.startsWith("/qr") == true) location = targetLocation;
    _initialLocation = null;
    debugPrint("Parsing $location");
    Uri? uri;
    if (location != null) uri = Uri.tryParse(location);
    return MyRouteConfiguration(uri);
  }

  //
  //
  //

  @override
  RouteInformation? restoreRouteInformation(
    final MyRouteConfiguration configuration,
  ) {
    final location = configuration.uri?.toString();
    if (location != null) {
      return RouteInformation(location: location);
    }
  }
}
