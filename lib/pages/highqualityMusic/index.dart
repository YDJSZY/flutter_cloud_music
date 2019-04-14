import 'package:flutter/material.dart';
import '../../apiRequest/index.dart';
import '../musicListDetail/index.dart';

class MusicTypes extends StatelessWidget implements PreferredSizeWidget { // 实现这个widget，appbar bottom需要此类型的widget
  final List<String> types;
  final String selectType;
  final Function typeOnClick;
  MusicTypes(this.types, this.selectType, this.typeOnClick);
  
  @override
  Size get preferredSize {
    return new Size.fromHeight(40.0);
  }

  showBottomBorder(String type) {
    if (type == selectType) {
      return Border(bottom: BorderSide(
        color: Colors.white,
        width: 2.0
      ));
    }
    return null;
  }

  List<Widget> buildMusicType() {
    List<Widget> typeList = [];
    for (var i = 0; i < types.length; i++) {
      var content = GestureDetector(
        onTap: () => typeOnClick(types[i]),
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: showBottomBorder(types[i])
          ),
          child: Text(types[i], style: TextStyle(fontSize: 15.0, color: types[i] == selectType ? Color(0xFF434343) : Color(0xFFeeeeee))),
        ),
      );
      typeList.add(content);
    }
    return typeList;
  }
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: buildMusicType().toList(),
      ),
    );
  }
}

class HighqualityMusic extends StatefulWidget {
  final String musicType;

  HighqualityMusic(this.musicType);

  @override
  State<StatefulWidget> createState() {
    return _HighqualityMusic();
  }
}

class _HighqualityMusic extends State<HighqualityMusic> {
  String selectType = '全部';
  List<Widget> musicListWidget = [];
  List musicListData = [];
  List<String> musicTypes = ['全部', '精品', '华语', '电子', '影视原声', '民谣', '轻音乐'];
  Map<String, dynamic> requestParams = {'cat': '全部', 'limit': 20, 'before': ''};
  ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    listenScroll();
    requestParams['cat'] = widget.musicType;
    _getHighqualityMusic(requestParams);
  }

  listenScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == 
        _scrollController.position.maxScrollExtent) {
        requestParams['before'] = musicListData[musicListData.length - 1]['updateTime'];
        _getHighqualityMusic(requestParams);
      }
    });
  }

  _getHighqualityMusic(params) async {
    var res = await getHighqualityMusic(params);
    var list = [];
    if (params['before'] == '') {
      list = res['playlists'];
    } else {
      list = new List.from(musicListData)..addAll(res['playlists']);
    }
    setState(() {
      musicListData = list;
    });
  }

  typeOnClick(type) {
    requestParams['cat'] = type;
    requestParams['before'] = '';
    _getHighqualityMusic(requestParams);
    setState(() {
      selectType = type;
    });
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
                new Image.network(data[i]['coverImgUrl']),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('推荐歌单'),
        centerTitle: true,
        bottom: MusicTypes(musicTypes, selectType, typeOnClick),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15.0, left: 8.0),
        child: ListView(
          children: _createMuisicList(musicListData).toList(),
          controller: _scrollController,
        ),
      ),
    );
  }
}