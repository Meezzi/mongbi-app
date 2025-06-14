import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/background_music_player.dart';

final backgroundMusicProvider = Provider<BackgroundMusicPlayer>((
  ref,
) {
  final audioPlayer = AudioPlayer();
  final bgmPlayer = BackgroundMusicPlayer(audioPlayer);

  ref.onDispose(() {
    bgmPlayer.dispose();
  });

  return bgmPlayer;
});
