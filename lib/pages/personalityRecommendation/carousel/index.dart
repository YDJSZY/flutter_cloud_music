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
      print('carousels');
      setState(() {
        carousels = res.data['banners'];
      });
    })();
  }

  _getCarousels() async {
    return await getCarousels();
  }

  @override
  void didChangeDependencies () {
    super.didChangeDependencies();
/*     print('didChange');
    print(carousels); */
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            carousels[index]['imageUrl'],
            fit: BoxFit.fill,
            height: 170.0,
          );
        },
        itemCount: 9,
        viewportFraction: 0.8,
        scale: 0.9,
      )
    );
  }
}