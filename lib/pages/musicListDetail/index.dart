import 'package:flutter/material.dart';
import 'dart:ui';
import '../../apiRequest/index.dart';

class MusicListDetail extends StatefulWidget {
  final int musicListId;

  MusicListDetail(this.musicListId);

  @override
  State<StatefulWidget> createState() {
    return _MusicListDetail();
  }
}

class _MusicListDetail extends State<MusicListDetail> {
  Map songList = {'playlist': {'name': '', 'creator': {}, 'tracks': []}};

  @override
  void initState() {
    super.initState();
    _getMusicListDetail(widget.musicListId);
  }

  _getMusicListDetail(id) async {
    print(id);
    var res = await getMusicListDetail(id);
    print(res);
    setState(() {
      songList = res;
    });
  }

  Widget buildSongsItem(BuildContext context, int index) {
    var tracks = songList['playlist']['tracks'];
    var num = index + 1;
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Text(num.toString()),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 15.0, right: 15.0, bottom: 15.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xFFDCDCDC))
                )
              ),
              child: Text(tracks[index]['name'], style: TextStyle(fontSize: 14.0),),
            ),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var coverImgUrl = songList['playlist']['coverImgUrl'];
    var avatarUrl = songList['playlist']['creator']['avatarUrl'];
    var avatarName = songList['playlist']['creator']['nickname'];
    var musicCount = songList['playlist']['tracks'].length;
    return Scaffold(
      appBar: AppBar(
        title: Text('歌单'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  coverImgUrl != null ? Image.network(
                    coverImgUrl,
                    fit: BoxFit.fitWidth,
                  ) : Container(),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: new Container(
                      color: Colors.white.withOpacity(0.8),
                      height: 200.0,
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            coverImgUrl != null ? Image.network(songList['playlist']['coverImgUrl'], width: 150.0, height: 150.0,) : Container(),
                            Flexible( // 包装在Flexible控件中，使其填充Row主轴中的可用空间
                              child: Container(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(songList['playlist']['name'], style: TextStyle(fontSize: 18.0), overflow: TextOverflow.clip,),
                                    avatarUrl != null ? Container(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 40.0,
                                            height: 40.0,
                                            margin: EdgeInsets.only(right: 10.0),
                                            child: CircleAvatar( // 圆角头像
                                              backgroundImage: NetworkImage(songList['playlist']['creator']['avatarUrl']),
                                            ),
                                          ),
                                          Text(avatarName)
                                        ],
                                      )
                                    ) : Container()
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                itemCount: musicCount,
                itemBuilder: buildSongsItem,
              )
            )
          ],
        ),
      ),
    );
  }
}