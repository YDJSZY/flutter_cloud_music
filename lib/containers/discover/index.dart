import 'package:flutter/material.dart';
import '../../pages/personalityRecommendation/index.dart';
import '../../pages/radio/index.dart';

class Discover extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Discover();
  }
}

class _Discover extends State<Discover> {
  @override
  void initState() {
    super.initState();
    print('发现');
  }

  gotoPlaying () async {
    
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0, // 默认显示的是TabBarView里的第几个child
      child: Scaffold(
        appBar: AppBar(
          elevation: 0, // 设置阴影辐射范围  可以去掉底部阴影
          centerTitle: true,
          backgroundColor: Color(0xFFC20C0C),
          title: Container(
            height: 34.0,
            // padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Color(0xFFDCDCDC),
              border: Border.all(
                color: Color(0xFFDCDCDC)
              )
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.search),
                      Text('搜索音乐', textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
                    ],
                  )
                )
              ],
            )
          ),
          leading: IconButton(icon: new Icon(Icons.mic_none, size: 28,), onPressed: gotoPlaying), // 出现在标题左边
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.equalizer, size: 28,), onPressed: gotoPlaying), // 出现在标题右边
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: '个性推荐'),
              Tab(text: '主播电台'),
            ],
          )
        ),
        body: TabBarView(
          children: [
            RecommendParent(),
            RadioParent()
          ],
        )
      )
    );
  }
}