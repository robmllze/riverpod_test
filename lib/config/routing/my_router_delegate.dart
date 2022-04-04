// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKINect
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';

import '../uri_to_page.dart';
import 'my_route_configuration.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MyRouterDelegate extends RouterDelegate<MyRouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRouteConfiguration> {
  //
  //
  //

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  //
  //
  //

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  //
  //
  //

  final _stack = <Page>[];
  final _history = <int, MyRouteConfiguration>{};
  Map<int, MyRouteConfiguration> get history => Map.of(this._history);
  bool _popBeforePush = true;
  var _currentConfiguration = const MyRouteConfiguration(null);

  //
  //
  //

  @override
  MyRouteConfiguration get currentConfiguration => this._currentConfiguration;

  //
  //
  //

  @override
  Future<void> setInitialRoutePath(MyRouteConfiguration configuration) async {
    final pageToAdd = uriToPage(configuration.uri);
    if (pageToAdd != null) {
      this._stack.add(pageToAdd);
      await this.setNewRoutePath(configuration);
    }
  }

  //
  //
  //

  @override
  Future<void> setNewRoutePath(MyRouteConfiguration configuration) async {
    this._currentConfiguration = configuration;
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    this._history[timestamp] = configuration;
    this.notifyListeners();
  }

  //
  //
  //

  Future<void> push(MyRouteConfiguration configuration) async {
    this._popBeforePush = false;
    await this.setNewRoutePath(configuration);
  }

  //
  //
  //

  Future<void> pushNamed(
    String base, [
    Map<String, dynamic>? queryParameters,
  ]) async {
    final converted = queryParameters
        ?.map((final key, final value) => MapEntry(key, value.toString()));
    await this.push(
      MyRouteConfiguration(Uri(path: base, queryParameters: converted)),
    );
  }

  //
  //
  //

  Future<void> popThenPush(MyRouteConfiguration configuration) async {
    this._popBeforePush = true;
    await this.setNewRoutePath(configuration);
  }

  //
  //
  //

  Future<void> popThenPushNamed(
    String base, [
    Map<String, dynamic>? queryParameters,
  ]) async {
    final converted = queryParameters
        ?.map((final key, final value) => MapEntry(key, value.toString()));
    await this.popThenPush(
      MyRouteConfiguration(Uri(path: base, queryParameters: converted)),
    );
  }

  //
  //
  //

  MyRouteConfiguration? prevConfiguration() {
    final length = this.history.length;
    if (length > 1) {
      final secondLastKey = this._history.keys.toList()[length - 2];
      return this._history[secondLastKey]!;
    }
  }

  //
  //
  //

  Future<void> prev() async {
    final p = this.prevConfiguration();
    if (p != null) await this.popThenPush(p);
  }

  //
  //
  //

  @override
  Widget build(_) {
    // Determine page to add based on current configuration.
    final pageToAdd = uriToPage(this.currentConfiguration.uri);

    /// If navigation stack is empty, this.setInitialRoutePath has not yet been
    /// called by the parent.
    if (this._stack.isNotEmpty && pageToAdd != null) {
      // If page to add is currently on top of the navigation stack, it doesn't
      // need to be added.
      if (this._stack.last.key != pageToAdd.key) {
        // Remove page to add from narvigation stack to ensure there aren't any
        // duplicates.
        this._stack.removeWhere((final u) => u.key == pageToAdd.key);

        // Remove last page on navigation stack if required.
        if (this._popBeforePush && this._stack.isNotEmpty) {
          this._stack.removeLast();
        }

        // Default to true for next time.
        this._popBeforePush = true;

        // Add page to top of navigation stack.
        this._stack.add(pageToAdd);
      }
      return Navigator(
        key: this.navigatorKey,
        pages: this._stack.toList(),
        transitionDelegate: NoAnimationTransitionDelegate(),
        onPopPage: (final route, final result) {
          if (!route.didPop(result)) return false;
          this.notifyListeners();
          return true;
        },
      );
    }

    debugPrint("No page yet");

    // Show nothing until this.setInitialRoutePath is called.
    return const SizedBox();
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// Copied from:
// https://api.flutter.dev/flutter/widgets/TransitionDelegate-class.html
class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord>
        locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>>
        pageRouteToPagelessRoutes,
  }) {
    final List<RouteTransitionRecord> results = <RouteTransitionRecord>[];

    for (final RouteTransitionRecord pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
    }
    for (final RouteTransitionRecord exitingPageRoute
        in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final List<RouteTransitionRecord>? pagelessRoutes =
            pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final RouteTransitionRecord pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }
      results.add(exitingPageRoute);
    }
    return results;
  }
}
