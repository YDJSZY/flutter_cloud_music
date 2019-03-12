import 'package:flutter/material.dart';
import 'containers/index.dart';
import 'apiRequest/index.dart';
import 'package:flutter/services.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return CloudMusic();
  }
}

class CloudMusic extends State<MyApp> {
  int _currentIndex = 0;
  bool loginSuccess = false;

  @override
  void initState() {
    super.initState();
    (() async {
      await login();
      setState(() {
        loginSuccess = true;
      });
    })();
  }

  setCurrentPageIndex (index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '网易云音乐',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: !loginSuccess ? Text('loading...') : IndexedStack(
          index: _currentIndex,
          children: mainPages
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: setCurrentPageIndex,
          fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('发现'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF8C8C8C),
              icon: new Icon(Icons.videocam),
              title: new Text('视频'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF8C8C8C),
              icon: new Icon(Icons.person),
              title: new Text('我的'),
            ),
          ]
        )
      ) 
    );
  }
}

/* TextField(
    cursorColor: Color(0xFFC20C0C),
    decoration: InputDecoration(
      fillColor: Color(0xFFDCDCDC),
      filled: true,
      focusedBorder: null,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFDCDCDC), width: 0),
        borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
      contentPadding: EdgeInsets.fromLTRB(30.0, 7.0, 30.0, 7.0),
    ),*/