import 'package:flutter/material.dart';

class ListTitle {
  String title = '';
  bool more = true; // 是否显示一个更多的箭头
  Function handleClick; // 点击回调

  ListTitle({this.title, this.more, this.handleClick});

  _handle() {
    handleClick();
  }

  Widget build() {
    return GestureDetector(
      onTap: _handle,
      child: Container(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0, 15.0),
        child: Row(
          children: <Widget>[
            Text(title),
            more ? Icon(Icons.chevron_right) : null
          ],
        )
      ),
    );
  }
}