import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = new AudioPlayer();

class CustomAudioPlayer {
  Future<void> play(String audioUrl) async {
    await audioPlayer.play(audioUrl);
  }

  Future<void> pause() async {
    await audioPlayer.pause();
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }
}