// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKINect
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart' show ValueKey;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyRouteConfiguration {
  //
  //
  //

  final Uri? uri;

  //
  //
  //

  const MyRouteConfiguration(this.uri);

  factory MyRouteConfiguration.parse(String uri) =>
      MyRouteConfiguration(Uri.tryParse(uri));

  //
  //
  //

  String? get route => this.uri?.toString();

  //
  //
  //

  ValueKey<String>? get key {
    final route = this.route;
    return route != null ? ValueKey<String>(route) : null;
  }

  //
  //
  //

  @override
  int get hashCode => this.uri.hashCode;

  @override
  bool operator ==(Object other) => this.hashCode == other.hashCode;

  //
  //
  //

  String? get uid => uri?.queryParameters["uid"];
  String? get email => uri?.queryParameters["email"];

  Map<String, String>? get parameters => uri?.queryParameters;
}
