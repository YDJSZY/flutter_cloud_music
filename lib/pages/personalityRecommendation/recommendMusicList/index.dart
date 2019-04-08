import 'package:flutter/material.dart';
import '../../../components/listTitle/index.dart';
import '../../../apiRequest/index.dart';
import '../../musicListDetail/index.dart';
import '../../highqualityMusic/index.dart';

class RecommendMusicList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecommendMusicList();
  }
}

class _RecommendMusicList extends State<RecommendMusicList> {
  List<Widget> recommendList = [];

  @override
  void initState() {
    super.initState();
    (() async {
      var res = await _getRecommendMusicList();
      var recommend = res['recommend'];
      var _tempRecommendList = _createMuisicList(recommend);
      setState(() {
        recommendList = _tempRecommendList;
      });
    })();
  }

  _gotoDetai(id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MusicListDetail(id)),
    );
  }

  List<Widget> _createMuisicList(data) {
    List<Widget> _tempRecommendList = [];
    List<Widget> _tempList = [];
    int len = data.length;
    for (var i = 0; i < len; i++) {
      var e = Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () => _gotoDetai(data[i]['id']),
          child: Container(
            padding: EdgeInsets.only(right: 8.0, bottom: 5.0),
            child: Column(
              children: <Widget>[
                new Image.network(data[i]['picUrl']),
                Text(
                  data[i]['name'],
                  maxLines: 2, // 最多两行文字
                  overflow: TextOverflow.ellipsis, // 超过点点点显示
                )
              ],
            )
          )
        )
      );
      _tempList.add(e);
      if ((i + 1) % 3 != 0) { // 每3个一行
        continue;
      } else {
        var tempRow =  Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _tempList.toList(),
        );
        _tempList = [];
        _tempRecommendList.add(tempRow);
      }
    }
    return _tempRecommendList;
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

  _checkMusicListMore() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HighqualityMusic('推荐')), // 查看更多推荐歌单
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.0, 0, 0, 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTitle(title: '推荐歌单', more: true, handleClick: _checkMusicListMore).build(),
          Container(
            child: Column(
              children: recommendList.toList(),
            ),
          )
        ],
      ),
    );
  }
}