// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKINect
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/config/get_it.dart';
import '/screen/super.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ScreenMain extends SuperScreen {
  const ScreenMain({required UriKey key}) : super(key: key);

  @override
  _State createState() => _State();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _State extends SuperState<ScreenMain> {
  @override
  Widget build(_) {
    debugPrint("Building Screen widget...");
    final String title = getIt<GroupTest>().title.value;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 30.0,
              ),
            ),
            const SizedBox(height: 10.0),
            // 1. Wrap widget that needs updating in a Consumer.
            Consumer(
              builder: (_, final ref, __) {
                // 2. Access the value that may change at any given moment.
                final int count = getIt<GroupTest>().count.watch(ref);
                debugPrint("Building Text widget...");
                // 3. Do whatever you want with the value.
                return Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 30.0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
