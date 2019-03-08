import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Video();
  }
}

class _Video extends State<Video> {
  @override
  void initState() {
    super.initState();
    print('视频');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('视频')
        ],
      ),
    );
  }
}