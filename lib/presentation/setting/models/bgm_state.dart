import 'package:flutter_riverpod/flutter_riverpod.dart';

class BgmState extends Notifier<bool> {
  BgmState();

  @override
  bool build() {
    return false;
  }

  void toggle() => state = !state;
}
