import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/providers/background_music_provider.dart';

class BgmState extends Notifier<bool> {
  @override
  bool build() {
    return true;
  }

  Future<void> turnOn() async {
    ref.read(backgroundMusicProvider).playBgm();
    state = true;
  }

  Future<void> turnOff() async {
    await ref.read(backgroundMusicProvider).fadeOutAndPause();
    state = false;
  }
}
