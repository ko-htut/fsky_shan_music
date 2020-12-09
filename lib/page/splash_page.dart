import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/model/song_model.dart';
import 'package:flutter_fsky_music/provider/song_provider.dart';
import 'package:flutter_fsky_music/utils/fluro_convert_utils.dart';
import 'package:flutter_fsky_music/utils/navigator_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../application.dart';
import '../utils/net_utils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _logoController;
  Tween _scaleTween;
  CurvedAnimation _logoAnimation;

  @override
  void initState() {
    super.initState();
    _scaleTween = Tween(begin: 0, end: 1);
    _logoController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..drive(_scaleTween);
    Future.delayed(Duration(milliseconds: 500), () {
      _logoController.forward();
    });
    _logoAnimation =
        CurvedAnimation(parent: _logoController, curve: Curves.easeOutQuart);

    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 500), () {
          goPage();
        });
      }
    });
  }

  void goPage() async {
    await Application.initSp();
    SongProvider playSongsModel = Provider.of<SongProvider>(context);
    if (Application.sp.containsKey('playing_songs')) {
      List<String> songs = Application.sp.getStringList('playing_songs');
      playSongsModel.addSongs(songs
          .map((s) => Song.fromJson(FluroConvertUtils.string2map(s)))
          .toList());
      int index = Application.sp.getInt('playing_index');
      playSongsModel.curIndex = index;
    }
    // if (userModel.user != null) {
    //   await NetUtils.refreshLogin(context).then((value){
    //     if(value.data != -1){
    NavigatorUtil.goindexPage(context);
    //     }
    //   });
    //   Provider.of<PlayListModel>(context).user = userModel.user;
    // } else
    //   NavigatorUtil.goLoginPage(context);
  }

  @override
  Widget build(BuildContext context) {
    NetUtils();
    ScreenUtil.init(context, width: 750, height: 1334);
    final size = MediaQuery.of(context).size;
    Application.screenWidth = size.width;
    Application.screenHeight = size.height;
    Application.statusBarHeight = MediaQuery.of(context).padding.top;
    Application.bottomBarHeight = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ScaleTransition(
          scale: _logoAnimation,
          child: Hero(
            tag: 'logo',
            child: Image.asset('images/fskylogo.png'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _logoController.dispose();
  }
}
