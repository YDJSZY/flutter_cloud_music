import 'package:flutter/material.dart';
import 'dart:math' as math;

class PlayDisc extends StatefulWidget {
  final String rotateBgImg;
  final bool isPlaying;
  PlayDisc(this.rotateBgImg, this.isPlaying);
  @override
  State<StatefulWidget> createState() {
    return _PlayDisc();
  }
}

class _PlayDisc extends State<PlayDisc> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _setAnimation();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setPlayStatus(widget.isPlaying);
  }

  void dispose() {
    super.dispose();
    print('dispose');
    controller.stop();
  }

  _setAnimation() {
    /* 
      vsync对象会绑定动画的定时器到一个可视的widget，所以当widget不显示时，动画定时器将会暂停，当widget再次显示时，动画定时器重新恢复执行，这样就可以避免动画相关UI不在当前屏幕时消耗资源。
    */
    controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 15000));
    // 通过 Tween 对象 创建 Animation 对象
    animation = Tween(begin: 0.0, end: 2.0).animate(controller)
      ..addListener(() {
        if (animation.value == 2.0) { // 转完一圈后重置，接着运动
          controller.reset();
          controller.forward();
        }
        setState(() {});
      });
    controller.forward();
  }
  
  _setPlayStatus(status) {
    if (status) {
      controller.forward(); // 继续向前运动
    } else {
      controller.stop(); // 暂停
    }
  }

  @override
  Widget build(BuildContext context) {
    var rotateBgImg = widget.rotateBgImg;
    return Transform.rotate(
      alignment: Alignment.center,
      angle: math.pi * animation.value,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: 330,
            height: 330,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 6),
              borderRadius: BorderRadius.all(Radius.circular(330))
            ),
            child: Image.asset(
              'lib/assets/images/play_disc.png',
            ),
          ),
          Positioned(
            top: 60,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(210))
              ),
              child: ClipOval(
                child: rotateBgImg != null ? Image.network(
                rotateBgImg,
                // fit: BoxFit.fitWidth,
              ) : null,
              )
            ),
          )
        ],
      ),
    );
  }
}