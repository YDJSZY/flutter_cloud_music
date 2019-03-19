import 'package:flutter/material.dart';
import '../../components/audioPlayer/index.dart';
import '../../apiRequest/index.dart';

class AudioPlayerPage extends StatefulWidget {
  final int currentPlayIndex; // 当前播放的音频是哪一个
  final List audioList; // 音频列表

  AudioPlayerPage(this.audioList, this.currentPlayIndex);

  @override
  State<StatefulWidget> createState() {
    return _AudioPlayerPage();
  }
}

class _AudioPlayerPage extends State<AudioPlayerPage> {
  CustomAudioPlayer audioPlayer = CustomAudioPlayer();
  @override
  void initState() {
    super.initState();
    var currentPlayAudioMsg = widget.audioList[widget.currentPlayIndex];
    print(currentPlayAudioMsg);
    (() async {
      var audioDetaiMsg = await _getMusicPlayUrl(currentPlayAudioMsg['id']);
      var audioPlayUrl = audioDetaiMsg['data'][0]['url'];
      audioPlayer.play(audioPlayUrl);
      print(audioPlayUrl);
    })();
  }

  _getMusicPlayUrl(id) async {
    var res = await getMusicPlayUrl(id);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('播放音乐'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Text('music'),
      )
    );
  }
}