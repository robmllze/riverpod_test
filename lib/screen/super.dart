// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKINect
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '/utils/keys.dart';
export '/utils/keys.dart';
import '/utils/let.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class SuperScreen extends StatefulWidget {
  //
  //
  //

  const SuperScreen({required UriKey key}) : super(key: key);

  //
  //
  //

  @override
  UriKey get key => super.key as UriKey;

  //
  //
  //

  /// Creates a MaterialPage from this screen.
  MaterialPage toMaterialPage() => MaterialPage(key: this.key, child: this);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class SuperState<T extends SuperScreen> extends State<T>
    with SingleTickerProviderStateMixin {
  //
  //
  //

  final _parameters = <String, String>{};

  //
  //
  //

  U? parameter<U>(String key) => let<U>(this._parameters[key]);

  //
  //
  //

  /// Sets screen parameters.
  void _setParameters(Map<String, String>? parameters) {
    if (parameters != null) {
      this._parameters.addAll(parameters);
    }
  }

  //
  //
  //

  @override
  void initState() {
    final uri = this.widget.key.uri;
    debugPrint("Initializing $uri");
    this._setParameters(uri?.queryParameters);
    super.initState();
  }

  //
  //
  //

  @override
  void dispose() {
    debugPrint("Disposing ${this.widget.key.uri}");
    super.dispose();
  }

  //
  //
  //

  @override
  Widget build(final context) {
    return SafeArea(
      child: this.safeBuild(context),
    );
  }

  //
  //
  //

  Widget safeBuild(BuildContext context) => const SizedBox();
}
