import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class BackgroundMusicPlayer {
  BackgroundMusicPlayer(this._player) {
    _player.setReleaseMode(ReleaseMode.loop);
  }

  final AudioPlayer _player;
  bool _isPaused = true;
  bool _isFadingOut = false;

  Future<void> playBgm() async {
    if (_isFadingOut) _isFadingOut = false;
    if (!_isPaused) return;

    _isPaused = false;
    await _player.setVolume(1.0);
    await _player.play(AssetSource('audio/background_music.mp3'));
  }

  Future<void> resumeBgm() async {
    if (_isFadingOut || !_isPaused) return;

    try {
      await _player.resume();
      _isPaused = false;
    } catch (_) {
      await playBgm();
    }
  }

  Future<void> fadeOutAndPause({
    Duration duration = const Duration(seconds: 1),
  }) async {
    if (_isPaused || _isFadingOut) return;

    _isFadingOut = true;
    const int steps = 20;
    final double stepSize = 1.0 / steps;
    final int stepDelay = duration.inMilliseconds ~/ steps;

    for (int i = 0; i <= steps; i++) {
      if (!_isFadingOut) {
        await _player.setVolume(1.0);
        return;
      }

      final volume = (1.0 - i * stepSize).clamp(0.0, 1.0);
      await _player.setVolume(volume);
      await Future.delayed(Duration(milliseconds: stepDelay));
    }

    if (_isFadingOut) {
      await _player.pause();
      _isPaused = true;
      await _player.setVolume(1.0);
    }

    _isFadingOut = false;
  }

  void dispose() {
    _player.dispose();
  }
}
