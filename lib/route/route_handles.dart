import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/page/home/home_page.dart';
import 'package:flutter_fsky_music/page/index.dart';
import 'package:flutter_fsky_music/page/login_page.dart';
import 'package:flutter_fsky_music/page/splash_page.dart';


// splash 页面
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return SplashPage();
    });

// 登录页
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return LoginPage();
    });

// 跳转到主页
var indexHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return IndexPage();
    });


// 跳转到搜索页面
var searchHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      // return SearchPage();
    });

// var lookImgHandler = new Handler(
//     handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
//       List<String> imgs = FluroConvertUtils.fluroCnParamsDecode(params['imgs'].first).split(',');
//       String index = params['index'].first;
//       print(imgs);
//       print(index);
//       return LookImgPage(imgs, int.parse(index));
//     });
