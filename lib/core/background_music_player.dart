import 'package:audioplayers/audioplayers.dart';

class BackgroundMusicPlayer {
  BackgroundMusicPlayer(this._player) {
    _player.setReleaseMode(ReleaseMode.loop);
  }

  final AudioPlayer _player;

  void playBgm() async {
    await _player.setVolume(1.0);
    await _player.play(AssetSource('audio/background_music.mp3'));
  }
}
