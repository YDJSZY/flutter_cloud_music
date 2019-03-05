import 'package:dio/dio.dart';

getCarousels() async { // 获取首页轮播图
  try {
    Response response = await Dio().get("http://192.168.1.29:3000/banner");
    return response;
  } catch (e) {
    print(e);
  }
}