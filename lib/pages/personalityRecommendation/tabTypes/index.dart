import 'package:flutter/material.dart';
import '../../../apiRequest/index.dart';

class TabTypes extends StatelessWidget {
  final List<Map> tabs = [];
  final List<Widget> icons = [
    Icon(Icons.radio, color: Colors.white),
    Icon(Icons.calendar_today, color: Colors.white),
    Icon(Icons.queue_music, color: Colors.white),
    Icon(Icons.insert_chart, color: Colors.white)
  ];
  final List<String> iconText = [
    '私人FM',
    '每日推荐',
    '歌单',
    '排行榜'
  ];
  void generateTabIcon() {
    var len = iconText.length;
    for (var i = 0; i < len; i++) {
      final obj = {};
      final icon = icons[i];
      final container = generateTabContainer(icon);
      obj['icon'] = container;
      obj['text'] = iconText[i];
      tabs.add(obj);
    }
  }

  Widget generateTabContainer(Widget icon) {
    return Container(
      width: 50.0,
      height: 50.0,
      child: icon,
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(50.0))
      ),
    );
  }

  _test() {
    getCarousels();
  }

  @override
  Widget build(BuildContext context) {
    generateTabIcon();
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFDCDCDC)
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tabs.map((item) {
          return GestureDetector(
            onTap: _test,
            child: Column(
              children: <Widget>[
                item['icon'],
                Text(item['text'], style: TextStyle(color: Colors.red))
              ],
            )
          );
        }).toList()
      ),
    );
  }
}