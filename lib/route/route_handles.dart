import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/model/album_model.dart';
import 'package:flutter_fsky_music/model/song_model.dart' as s;
import 'package:flutter_fsky_music/page/album/album_show.dart';
import 'package:flutter_fsky_music/page/download/download_page.dart';
import 'package:flutter_fsky_music/page/index.dart';
import 'package:flutter_fsky_music/page/login/login_page.dart';
import 'package:flutter_fsky_music/page/play/music_play_page.dart';
import 'package:flutter_fsky_music/page/search/search_page.dart';
import 'package:flutter_fsky_music/page/splash_page.dart';
import 'package:flutter_fsky_music/page/statement_page.dart';
import 'package:flutter_fsky_music/utils/fluro_convert_utils.dart';


var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return SplashPage();
});

var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return LoginPage();
});

var indexHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return IndexPage();
});
var searchHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return SearchPage();
});
var albumHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  String data = params['data'].first;
  return AlbumShow(data: Datum.fromJson(FluroConvertUtils.string2map(data)));
});
// MusicPlayPage
var playHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return MusicPlayPage();
});
var downloadHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return DownloadPage();
});
var stateHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return StatementPage();
});
