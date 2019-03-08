import 'package:flutter/material.dart';
import '../../../apiRequest/index.dart';

class RecommendMusicList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecommendMusicList();
  }
}

class _RecommendMusicList extends State<RecommendMusicList> {
  List musicList = [];

  @override
  void initState() {
    super.initState();
    (() async {
      final res = await _getRecommendMusicList();
      print(res);
      /* setState(() {
        musicList = res.data['banners'];
      }); */
    })();
  }

  _getRecommendMusicList() async {
    var loginRes = await login();
    return await getRecommendMusicList(loginRes);
  }

  @override
  void didChangeDependencies () {
    super.didChangeDependencies();
    _getRecommendMusicList();
/*     print('didChange');
    print(carousels); */
  }

  @override
  Widget build(BuildContext context) {
    _getRecommendMusicList();
    return Container(
      padding: EdgeInsets.fromLTRB(8.0, 15.0, 0, 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('推荐歌单'),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}