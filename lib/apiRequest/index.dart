import 'package:dio/dio.dart';
// import 'package:cookie_jar/cookie_jar.dart';
var dio = Dio();
var loginCookie;
const String apiPrefix = 'http://192.168.31.104:3000/';

login() async {
  dio.interceptors.add(InterceptorsWrapper(
    onRequest:(RequestOptions options){}
  ));
  try {
    Response response = await dio.get("${apiPrefix}login/cellphone", queryParameters: {'phone': '18649685236', 'password': '1314520ZY'}, options: Options(extra: {'xhrFields': {'withCredentials': true}}));
    loginCookie = response.headers['set-cookie'];
    return loginCookie;
  } catch (e) {
    print(e);
  }
}

getCarousels() async { // 获取首页轮播图
  try {
    Response response = await dio.get("${apiPrefix}banner");
    return response.data;
  } catch (e) {
    print(e);
  }
}

getRecommendMusicList() async {
  try {
    Response response = await dio.get(
      "${apiPrefix}recommend/resource", 
      options: Options(
        extra: {'xhrFields': {'withCredentials': true}}, 
        headers: {'cookie': loginCookie}
      ));
    return response.data;
  } catch (e) {
    print(e.error);
  }
}

getRecommendSongs() async {
  try {
    Response response = await dio.get(
      "${apiPrefix}recommend/songs", 
      options: Options(
        extra: {'xhrFields': {'withCredentials': true}}, 
        headers: {'cookie': loginCookie}
      ));
    return response.data;
  } catch (e) {
    print(e.error);
  }
}

getRecommendRadio() async {
  try {
    Response response = await dio.get(
      "${apiPrefix}personalized/djprogram", 
      options: Options(
        extra: {'xhrFields': {'withCredentials': true}}, 
        headers: {'cookie': loginCookie}
      ));
    return response.data;
  } catch (e) {
    print(e.error);
  }
}

getMusicListDetail(id) async {
  try {
    Response response = await dio.get(
      "${apiPrefix}playlist/detail", 
      queryParameters: {'id': id},
      options: Options(
        extra: {'xhrFields': {'withCredentials': true}}, 
        headers: {'cookie': loginCookie}
      ));
    return response.data;
  } catch (e) {
    print(e);
  }
}

getMusicPlayUrl(id) async {
  try {
    Response response = await dio.get(
      "${apiPrefix}song/url", 
      queryParameters: {'id': id},
      options: Options(
        extra: {'xhrFields': {'withCredentials': true}}, 
        // headers: {'cookie': loginCookie}
      ));
    return response.data;
  } catch (e) {
    print(e);
  }
}