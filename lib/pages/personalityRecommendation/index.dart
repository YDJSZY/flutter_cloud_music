import 'package:flutter/material.dart';
import 'carousel/index.dart';
import 'tabTypes/index.dart';

class RecommendParent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecommendParent();
  }
}

class _RecommendParent extends State<RecommendParent> with AutomaticKeepAliveClientMixin {
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
      child: Column(
        children: <Widget>[
          Carousels(),
          TabTypes()
        ],
      ),
    );
  }
}