import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class BackgroundMusicPlayer {
  BackgroundMusicPlayer(this._player) {
    _player.setReleaseMode(ReleaseMode.loop);
  }

  final AudioPlayer _player;
  bool _isPaused = false;

  void playBgm() async {
    await _player.setVolume(1.0);
    // await _player.play(AssetSource('audio/background_music.mp3'));
    _isPaused = false;
  }

  void resumeBgm() async {
    if (_isPaused) {
      try {
        await _player.resume();
        _isPaused = false;
      } catch (e) {
        playBgm();
      }
    }
  }

  void dispose() {
    _player.dispose();
  }

  Future<void> fadeOutAndPause({
    Duration duration = const Duration(seconds: 1),
  }) async {
    if (_isPaused) return;

    const int steps = 20;
    final double stepSize = 1.0 / steps;
    final int stepDuration = duration.inMilliseconds ~/ steps;

    for (int i = 0; i <= steps; i++) {
      final volume = 1.0 - (i * stepSize);
      await _player.setVolume(volume.clamp(0.0, 1.0));
      await Future.delayed(Duration(milliseconds: stepDuration));
    }

    await _player.pause();
    _isPaused = true;
    await _player.setVolume(1.0);
  }
}
