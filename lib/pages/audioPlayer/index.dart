import 'package:flutter/material.dart';
import 'dart:ui';
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
  Map currentPlayAudioMsg = {'name': '', 'ar': [{'name': ''}], 'al': {}};
  @override
  void initState() {
    super.initState();
    var currentPlayAudioMsg = _getCurrentPlayAudio(widget.currentPlayIndex); // 当前播放的音频信息
    print(currentPlayAudioMsg);
    (() async {
      var audioDetaiMsg = await _getMusicPlayUrl(currentPlayAudioMsg['id']);
      var audioPlayUrl = audioDetaiMsg['data'][0]['url'];
      audioPlayer.play(audioPlayUrl);
    })();
  }

  Map _getCurrentPlayAudio(int index) {
    var data = widget.audioList[index]; // 当前播放的音频信息
    setState(() {
      currentPlayAudioMsg = data;
    });
    return data;
  }

  _getMusicPlayUrl(id) async {
    var res = await getMusicPlayUrl(id);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    var bgImg = currentPlayAudioMsg['al']['picUrl'];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentPlayAudioMsg['name']),
            Text(currentPlayAudioMsg['ar'][0]['name'], style: TextStyle(fontSize: 12.0),)
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            bgImg != null ? Image.network(
              bgImg,
              fit: BoxFit.fitWidth,
            ) : Container(),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 200, sigmaY: 140),
              child: new Container(
                color: Colors.black.withOpacity(0.25),
              )
            )
          ]
        )
      )
    );
  }
}