// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKINect
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'config/get_it.dart';
import 'config/routing/my_route_information_parser.dart';
import 'config/routing/my_router_delegate.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

final routerDelegate = MyRouterDelegate();

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyRouteInformationParser.setInitialLocation("/main");
  setupGetIt();
  runApp(ProviderScope(child: _App()));
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _App extends StatelessWidget {
  final _routeInformationParser = MyRouteInformationParser();
  @override
  Widget build(_) {
    startCount();
    return MaterialApp.router(
      title: "Riverpod Test",
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      routerDelegate: routerDelegate,
      routeInformationParser: this._routeInformationParser,
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// Omnis can be updated or set outside the UI.
void startCount() {
  Timer.periodic(const Duration(seconds: 1), (final timer) {
    // Setting an Omni.
    //getIt<GroupTest>().count.set(77);
    // Updating an Omni.
    getIt<GroupTest>().count.update((final valueOld) => valueOld + 1);
    if (timer.tick > 10) timer.cancel();
  });
}
