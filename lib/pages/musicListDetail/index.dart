import 'package:flutter/material.dart';
import 'dart:ui';
import '../../apiRequest/index.dart';
import '../audioPlayer/index.dart';

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
    print(res['playlist']['tracks']);
    setState(() {
      songList = res;
    });
  }

  List<Widget> buildHandleIcon() {
    var icons = [[Icons.call_split, '123'], [Icons.screen_share, '123'], [Icons.file_download, '下载'], [Icons.check_circle, '多选']];
    List<Widget> list = [];
    for (var i = 0; i < icons.length; i++) {
      var col = Column(
        children: <Widget>[
          Icon(icons[i][0], color: Colors.white, size: 30.0),
          Text(icons[i][1], style: TextStyle(color: Colors.white),)
        ]
      );
      list.add(col);
    }
    return list;
  }

  List<Widget> buildSongsItem() {
    var tracks = songList['playlist']['tracks'];
    List<Widget> list = [];  
    for (var i = 0; i < tracks.length; i++) {
      var num = i + 1;
      var songItem = GestureDetector(
        onTap: () => _gotoPlay(tracks, i),
        child: Container(
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
                  child: Text(tracks[i]['name'], style: TextStyle(fontSize: 14.0),),
                ),
              )
            ],
          )
        )
      );
      list.add(songItem);
    }
    return list;
  }

  _gotoPlay(musicList, index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AudioPlayerPage(musicList, index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var coverImgUrl = songList['playlist']['coverImgUrl'];
    var avatarUrl = songList['playlist']['creator']['avatarUrl'];
    var avatarName = songList['playlist']['creator']['nickname'];
    return Scaffold(
      appBar: AppBar(
        title: Text('歌单'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Container(
            height: 260.0,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                coverImgUrl != null ? Image.network(
                  coverImgUrl,
                  fit: BoxFit.fitWidth,
                ) : Container(),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: new Container(
                    color: Colors.black.withOpacity(0.25),
                    height: 200.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              coverImgUrl != null ? 
                                Image.network(
                                  songList['playlist']['coverImgUrl'], 
                                  width: 150.0, 
                                  height: 150.0,
                                  // filterQuality: ,
                                )
                                : Container(),
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
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: buildHandleIcon()
                          ),
                        )
                      ],
                    )
                  )
                )
              ],
            ),
          ),
          Column(
            children: buildSongsItem(),
          ),
        ]
      ),
    );
  }
}