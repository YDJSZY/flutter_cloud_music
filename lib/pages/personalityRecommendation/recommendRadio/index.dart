import 'package:flutter/material.dart';
import '../../../components/listTitle/index.dart';
import '../../../apiRequest/index.dart';

class RecommendRadio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecommendRadio();
  }
}

class _RecommendRadio extends State<RecommendRadio> {
  List<Widget> recommendRadioList = [];

  @override
  void initState() {
    super.initState();
    (() async {
      var res = await _getData();
      var recommend = res['result'];
      var _temprecommendRadioList = _createMuisicList(recommend);
      setState(() {
        recommendRadioList = _temprecommendRadioList;
      });
    })();
  }

  List<Widget> _createMuisicList(data) {
    List<Widget> _temprecommendRadioList = [];
    List<Widget> _tempList = [];
    for (var i = 0; i < 6; i++) {
      var e = Expanded(
        flex: 1,
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
        _temprecommendRadioList.add(tempRow);
      }
    }
    return _temprecommendRadioList;
  }

  _getData() async {
    return await getRecommendRadio();
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
          ListTitle(title: '推荐电台', more: true, handleClick: _checkMusicListMore).build(),
          Container(
            child: Column(
              children: recommendRadioList.toList(),
            ),
          )
        ],
      ),
    );
  }
}