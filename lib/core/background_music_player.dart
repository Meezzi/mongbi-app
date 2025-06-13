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
    await _player.play(AssetSource('audio/background_music.mp3'));
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
}
