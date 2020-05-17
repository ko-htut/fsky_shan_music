import 'dart:ui';
import 'package:flutter/material.dart' as prefix0;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/application.dart';
import 'package:flutter_fsky_music/provider/play_songs_model.dart';
import 'package:flutter_fsky_music/utils/utils.dart';
import 'package:flutter_fsky_music/widget/common_text_style.dart';
import 'package:flutter_fsky_music/widget/v_empty_view.dart';
import 'package:flutter_fsky_music/widget/widget_play_bottom_menu.dart';
import 'package:flutter_fsky_music/widget/widget_round_img.dart';
import 'package:flutter_fsky_music/widget/widget_song_progress.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class MusicPlayPage extends StatefulWidget {
  MusicPlayPage({Key key}) : super(key: key);

  @override
  _MusicPlayPageState createState() => _MusicPlayPageState();
}

class _MusicPlayPageState extends State<MusicPlayPage> 
  with TickerProviderStateMixin {
  AnimationController _controller; 
  AnimationController _stylusController;
  Animation<double> _stylusAnimation;
  int switchIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _stylusController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _stylusAnimation =
        Tween<double>(begin: -0.03, end: -0.10).animate(_stylusController);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaySongsModel>(builder: (context, model, child) {
      var curSong = model.curSong;
      if (model.curState == AudioPlayerState.PLAYING) {
        _controller.forward();
        _stylusController.reverse();
      } else {
        _controller.stop();
        _stylusController.forward();
      }
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Utils.showNetImage(
              '${curSong.cover}',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fitHeight,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 100,
                sigmaX: 100,
              ),
              child: Container(
                color: Colors.black38,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            AppBar(
              centerTitle: true,
              brightness: Brightness.dark,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    model.curSong.name,
                    style: commonWhiteTextStyle,
                  ),
                  Text(
                    model.curSong.artist,
                    style: smallWhite70TextStyle,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kToolbarHeight + Application.statusBarHeight),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        setState(() {
                          if(switchIndex == 0){
                            switchIndex = 1;
                          }else{
                            switchIndex = 0;
                          }
                        });
                      },
                      child: IndexedStack(
                        index: switchIndex,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(150)),
                                  child: RotationTransition(
                                    turns: _controller,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        prefix0.Image.asset(
                                          'images/bet.png',
                                          width: ScreenUtil().setWidth(550),
                                        ),
                                        RoundImgWidget('${curSong.cover}', 370),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Align(
                              //   child: RotationTransition(
                              //     turns: _stylusAnimation,
                              //     alignment: Alignment(
                              //         -1 +
                              //             (ScreenUtil().setWidth(45 * 2) /
                              //                 (ScreenUtil().setWidth(293))),
                              //         -1 +
                              //             (ScreenUtil().setWidth(45 * 2) /
                              //                 (ScreenUtil().setWidth(504)))),
                              //     child: Image.asset(
                              //       'images/bgm.png',
                              //       width: ScreenUtil().setWidth(205),
                              //       height: ScreenUtil().setWidth(352.8),
                              //     ),
                              //   ),
                              //   alignment: Alignment(0.25, -1),
                              // ),
                            ],
                          ),
                          // LyricPage(model),
                        ],
                      ),
                    ),
                  ),

                  // buildSongsHandle(model),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                    child: SongProgressWidget(model),
                  ),
                  PlayBottomMenuWidget(model),
                  VEmptyView(20),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _stylusController.dispose();
    super.dispose();
  }
}

 