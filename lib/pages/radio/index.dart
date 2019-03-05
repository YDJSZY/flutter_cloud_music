import 'package:flutter/material.dart';

class RadioParent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RadioParent();
  }
}

class _RadioParent extends State<RadioParent> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text('1', textAlign: TextAlign.center)
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text('2', textAlign: TextAlign.center)
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text('3', textAlign: TextAlign.center)
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text('4', textAlign: TextAlign.center)
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text('5', textAlign: TextAlign.center)
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text('6', textAlign: TextAlign.center)
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text('7', textAlign: TextAlign.center)
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text('8', textAlign: TextAlign.center)
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text('9', textAlign: TextAlign.center)
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text('10', textAlign: TextAlign.center)
          ),
        ],
      ),
    );
  }
}