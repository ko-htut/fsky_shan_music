import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/model/album_model.dart';
import 'package:flutter_fsky_music/model/song_model.dart' as s;
import 'package:flutter_fsky_music/route/routes.dart';
import 'package:flutter_fsky_music/utils/fluro_convert_utils.dart';

import '../application.dart';

class NavigatorUtil {
  static _navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder}) {
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        transition: TransitionType.material);
  }

  /// Login
  static void goLoginPage(BuildContext context) {
    _navigateTo(context, Routes.login, clearStack: true);
  }

  /// Index
  static void goindexPage(BuildContext context) {
    _navigateTo(context, Routes.index, clearStack: true);
  }

  /// Search
  static void goSearchPage(BuildContext context) {
    _navigateTo(context, Routes.search);
  }
   static void gostatePage(BuildContext context) {
    _navigateTo(context, Routes.state);
  }
  ///muic player page
   static void goplay(BuildContext context) {
    _navigateTo(context,Routes.play);
  }

  static void godownload(BuildContext context){
    _navigateTo(context, Routes.download);
  }

  static void goAlbumShow(BuildContext context, Datum data) {
    _navigateTo(context,
        "${Routes.albums}?data=${FluroConvertUtils.object2string(data)}");
  }
}
