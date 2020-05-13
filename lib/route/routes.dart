import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/page/login_page.dart';
import 'package:flutter_fsky_music/route/route_handles.dart';


class Routes {
  static String root = "/";
  static String index = "/index";
  static String login = "/login";
  static String playSongs = "/play_songs";
  static String search = "/search";
  static String lookImg = "/look_img";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return LoginPage();
    });
    router.define(root, handler: splashHandler);
    router.define(login, handler: loginHandler);
    router.define(index, handler: indexHandler);
    router.define(search, handler: searchHandler);
    // router.define(lookImg, handler: lookImgHandler);
  }
}
