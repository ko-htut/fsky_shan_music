import 'package:audioplayers/audioplayers.dart';
import 'package:common_utils/common_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fsky_music/page/splash_page.dart';
import 'package:flutter_fsky_music/provider/song_provider.dart';
import 'package:flutter_fsky_music/provider/user_model.dart';
import 'package:flutter_fsky_music/route/navigate_service.dart';
import 'package:flutter_fsky_music/route/routes.dart';
import 'package:provider/provider.dart';
import 'application.dart';

void main() {
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  Application.setupLocator();
  LogUtil.init(tag: 'F_SKY_MUSIC');
  AudioPlayer.logEnabled = true;
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserModel>(
        create: (_) => UserModel(),
      ),
       ChangeNotifierProvider<SongProvider>(
        create: (_) => SongProvider()..init(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
       statusBarColor: Colors.transparent,
       // statusBarIconBrightness: Brightness.light,
     ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F Sky',
      navigatorKey: Application.getIt<NavigateService>().key,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          splashColor: Colors.transparent,
          tooltipTheme: TooltipThemeData(verticalOffset: -100000)),
      home: SplashPage(),
      onGenerateRoute: Application.router.generator,
    );
  }
}
