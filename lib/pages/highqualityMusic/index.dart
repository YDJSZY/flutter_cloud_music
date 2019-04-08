import 'package:flutter/material.dart';
import '../../apiRequest/index.dart';

class HighqualityMusic extends StatefulWidget {
  final String musicType;

  HighqualityMusic(this.musicType);

  @override
  State<StatefulWidget> createState() {
    return _HighqualityMusic();
  }
}

class _HighqualityMusic extends State<HighqualityMusic> {
  List<Map> musicList = [];
  Map<String, dynamic> requestParams = {'musicType': '推荐', 'limit': 20, 'before': ''};
  @override
  void initState() {
    super.initState();
    requestParams['musicType'] = widget.musicType;
    _getHighqualityMusic(requestParams);
  }

  _getHighqualityMusic(params) async {
    print(params);
    var res = await getHighqualityMusic(params);
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('推荐歌单'),
        centerTitle: true
      )
    );
  }
}