import 'package:flutter/material.dart';
import '../../../components/listTitle/index.dart';
import '../../../apiRequest/index.dart';

class RecommendSongs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecommendSongs();
  }
}

class _RecommendSongs extends State<RecommendSongs> {
  List<Widget> recommendList = [];

  @override
  void initState() {
    super.initState();
    (() async {
      var res = await _getData();
      var recommend = res['recommend'];
      // print(recommend);
      var _tempRecommendList = _createMuisicList(recommend);
      setState(() {
        recommendList = _tempRecommendList;
      });
    })();
  }

  List<Widget> _createMuisicList(data) {
    List<Widget> _tempRecommendList = [];
    List<Widget> _tempList = [];
    for (var i = 0; i < 6; i++) {
      var imgUrl = data[i]['album']['blurPicUrl'] == null ? data[i]['album']['picUrl'] : data[i]['album']['blurPicUrl'];
      var e = Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.only(right: 8.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              new Image.network(imgUrl),
              Text(
                data[i]['name'],
                maxLines: 2, // 最多两行文字
                overflow: TextOverflow.ellipsis, // 超过点点点显示
              )
            ],
          )
        ),
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

  _getData() async {
    return await getRecommendSongs();
  }

  @override
  void didChangeDependencies () {
    super.didChangeDependencies();
/*     print('didChange');
    print(carousels); */
  }

  _checkMusicListMore() {
    print(123);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.0, 0, 0, 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTitle(title: '推荐音乐', more: true, handleClick: _checkMusicListMore).build(),
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