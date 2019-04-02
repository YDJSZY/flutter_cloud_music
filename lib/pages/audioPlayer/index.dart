import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';
import '../../components/audioPlayer/index.dart';
import '../../apiRequest/index.dart';
import '../../components/playDisc/index.dart';
import '../../components/audioPlayHandle/index.dart';

class AudioPlayerPage extends StatefulWidget {
  final int currentPlayIndex; // 当前播放的音频是哪一个
  final List audioList; // 音频列表

  AudioPlayerPage(this.audioList, this.currentPlayIndex);

  @override
  State<StatefulWidget> createState() {
    return _AudioPlayerPage();
  }
}

class _AudioPlayerPage extends State<AudioPlayerPage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  CustomAudioPlayer audioPlayer = CustomAudioPlayer();
  Map currentPlayAudioMsg = {'name': '', 'ar': [{'name': ''}], 'al': {}};
  bool isPlaying = false;
  int currentPlayIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentPlayIndex = widget.currentPlayIndex;
    });
    _getCurrentPlayAudio(widget.currentPlayIndex); // 当前播放的音频信息
    _setPlayAnimation();
  }

  _setPlayStatus(bool status) {
    if (status) {
      controller.forward();
      audioPlayer.resume();
    } else {
      controller.reverse(); // 返回到初始的动画
      audioPlayer.pause(); // 暂停播放
    }
    setState(() {
      isPlaying = status;
    });
  }

  _setPlayAnimation() {
    controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));
    // 通过 Tween 对象 创建 Animation 对象
    animation = Tween(begin: 10.0, end: 100.0).animate(controller)
      ..addListener(() {
        // 注意：这句不能少，否则 widget 不会重绘，也就看不到动画效果
        setState(() {});
      });
    // 执行动画
  }

  void _getCurrentPlayAudio(int index) async {
    var data = widget.audioList[index]; // 当前播放的音频信息
    setState(() {
      currentPlayAudioMsg = data;
    });
    var audioDetaiMsg = await _getMusicPlayUrl(data['id']);
    var audioPlayUrl = audioDetaiMsg['data'][0]['url'];
    audioPlayer.play(audioPlayUrl);
    _setPlayStatus(true);
  }

  _getMusicPlayUrl(id) async {
    var res = await getMusicPlayUrl(id);
    return res;
  }

  _prev() {
    var len = widget.audioList.length;
    var index = currentPlayIndex;
    if (index == 0) {
      index = len - 1;
    } else {
      --index;
    }
    setState(() {
      currentPlayIndex = index;
    });
    _getCurrentPlayAudio(index);
  }

  _play() {
    bool status;
    if (isPlaying == true) {
      status = false;
    } else {
      status = true;
    }
    _setPlayStatus(status);
  }

  _next() {
    var len = widget.audioList.length;
    var index = currentPlayIndex;
    if (index == len - 1) {
      index = 0;
    } else {
      ++index;
    }
    setState(() {
      currentPlayIndex = index;
    });
    _getCurrentPlayAudio(index);
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
        // backgroundColor: Colors.transparent,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(
                      fit: StackFit.loose,
                      overflow: Overflow.visible, // 超出显示
                      alignment: Alignment.topCenter, //指定未定位或部分定位widget的对齐方式
                      children: <Widget>[
                        Positioned(
                          top: 70,
                          child: bgImg != null ? PlayDisc(bgImg, isPlaying) : Container()
                        ),
                        Positioned(
                          child: Transform.translate(
                            offset: Offset(50, 0),// 移动
                            child: Transform.rotate(
                              alignment: Alignment.topLeft,
                              angle: -math.pi / (animation != null ? animation.value : 10),
                              child: Container(
                                child: Image.asset(
                                  'lib/assets/images/play_needle.png',
                                  width: 150,
                                  height: 160
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: AudioPlayHandle(_prev, _play, _next, isPlaying)
                    )
                  ],
                )
              )
            )
          ]
        )
      )
    );
  }
}