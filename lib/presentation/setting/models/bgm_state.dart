import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/providers/background_music_provider.dart';

class BgmState extends Notifier<bool> {
  @override
  bool build() {
    return true;
  }

  Future<void> turnOn() async {
    state = true;
    ref.read(backgroundMusicProvider).playBgm();
  }

  Future<void> turnOff() async {
    state = false;
    await ref.read(backgroundMusicProvider).fadeOutAndPause();
  }
}
