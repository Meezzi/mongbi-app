import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/providers/background_music_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BgmState extends Notifier<bool> {
  static const _bgmKey = 'isBgmOn';

  @override
  bool build() {
    _loadPersistedState();
    return true;
  }

  void _loadPersistedState() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_bgmKey);
    if (saved != null && saved != state) {
      state = saved;
    }
  }

  Future<void> turnOn() async {
    if (state) {
      await ref.read(backgroundMusicProvider).playBgm();
      return;
    }

    state = true;
    await _persistState(true);
    await ref.read(backgroundMusicProvider).playBgm();
  }

  Future<void> turnOff() async {
    if (!state) return;

    state = false;
    await _persistState(false);
    await ref.read(backgroundMusicProvider).fadeOutAndPause();
  }

  Future<void> _persistState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_bgmKey, value);
  }
}
