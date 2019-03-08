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
      var res = await _getRecommendMusicList();
      setState(() {
        musicList = res['recommend'];
      });
    })();
    
  }

  _getRecommendMusicList() async {
    return await getRecommendMusicList();
  }

  @override
  void didChangeDependencies () {
    super.didChangeDependencies();
/*     print('didChange');
    print(carousels); */
  }

  @override
  Widget build(BuildContext context) {
    print(musicList);
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