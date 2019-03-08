import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../apiRequest/index.dart';

class Carousels extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Carousels();
  }
}

class _Carousels extends State<Carousels> {
  var carousels = [];
  @override
  void initState() {
    super.initState();
    (() async {
      final res = await _getCarousels();
      setState(() {
        carousels = res['banners'];
      });
    })();
  }

  _getCarousels() async {
    return await getCarousels();
  }

  @override
  void didChangeDependencies () {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
      child: carousels.length == 0 ? null : Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            carousels[index]['imageUrl'],
            fit: BoxFit.fill,
            height: 170.0,
          );
        },
        itemCount: carousels.length,
        viewportFraction: 0.8,
        scale: 0.9,
      )
    );
  }
}