// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MediKINect
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:flutter_riverpod/flutter_riverpod.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class Omni<T> extends StateNotifier<T> {
  //
  //
  //

  Omni(T initial) : super(initial);

  //
  //
  //

  late final provider = StateNotifierProvider<Omni, dynamic>((ref) => this);

  //
  //
  //

  void update(T Function(T valueOld) valueNew) =>
      super.state = valueNew(super.state);

  //
  //
  //

  void set(T stateNew) => super.state = stateNew;

  //
  //
  //

  T watch(WidgetRef ref) => ref.watch(this.provider) as T;

  //
  //
  //

  T read(WidgetRef ref) => ref.read(this.provider) as T;

  //
  //
  //

  T get value => this.state;
}
