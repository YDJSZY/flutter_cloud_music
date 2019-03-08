import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

var dio = Dio();
const String apiPrefix = 'http://192.168.1.29:3000/';

getCarousels() async { // 获取首页轮播图
  try {
    Response response = await dio.get("${apiPrefix}banner");
    return response;
  } catch (e) {
    print(e);
  }
}

login() async {
  try {
    Response response = await dio.get("${apiPrefix}login/cellphone", queryParameters: {'phone': '18649685236', 'password': '1314520ZY'}, options: Options(extra: {'xhrFields': {'withCredentials': true}}));
    return response.headers['set-cookie'];
  } catch (e) {
    print(e);
  }
}

getRecommendMusicList(loginRes) async {
  try {
    Response response = await dio.get("${apiPrefix}recommend/resource", options: Options(extra: {'xhrFields': {'withCredentials': true}}, headers: {'cookie': loginRes}));
    print(response);
    return response;
  } catch (e) {
    print(e.error);
  }
}