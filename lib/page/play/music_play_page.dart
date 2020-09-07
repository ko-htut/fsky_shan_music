import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/provider/song_provider.dart';
import 'package:flutter_fsky_music/utils/utils.dart';
import 'package:flutter_fsky_music/widget/common_text_style.dart';
import 'package:flutter_fsky_music/widget/h_empty_view.dart';
import 'package:flutter_fsky_music/widget/widget_img_menu.dart';
import 'package:flutter_fsky_music/widget/widget_song_progress.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

import '../../application.dart';
import '../../model/user.dart';
import '../../provider/user_model.dart';

class MusicPlayPage extends StatefulWidget {
  MusicPlayPage({Key key}) : super(key: key);

  @override
  _MusicPlayPageState createState() => _MusicPlayPageState();
}

class _MusicPlayPageState extends State<MusicPlayPage> {
  User mydata;
  bool user = false;
  @override
  void initState() {
    super.initState();
    clickuser();
  }

  void clickuser() async {
    await Application.initSp();
    UserModel userModel = Provider.of<UserModel>(context);
    userModel.initUser(context);
    if (userModel.user != null) {
      setState(() {
        user = true;
        mydata = userModel.user;
      });
    } else {
      setState(() {
        user = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongProvider>(builder: (context, model, child) {
      var curSong = model.curSong;
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Utils.showNetImage(
              curSong.cover,
              width: ScreenUtil().setWidth(750),
              height: ScreenUtil().setWidth(750),
              fit: BoxFit.fitHeight,
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
                    curSong.name,
                    style: commonWhiteTextStyle,
                  ),
                  Text(
                    "${curSong.artist} : ${curSong.album}",
                    style: smallWhite70TextStyle,
                  ),
                ],
              ),
            ),
            // /
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(750)),
              child: Container(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(850),
              ),
              child: Container(
                height: 550,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: SongProgressWidget(model),
                ),
              ),
              // child: _buildPlayer(),
            ),
            Align(
                alignment: Alignment.bottomCenter, child: _buildPlayer(model)),
            // Align(
            //   alignment: Alignment.center,
            //   child: user == false
            //       ? Container()
            //       : Padding(
            //           padding:
            //               EdgeInsets.only(top: ScreenUtil().setHeight(180)),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               // _buildMuteButtons(),
            //               InkWell(
            //                 onTap: () {
            //                   model.downloadFile(context);
            //                 },
            //                 child: Row(
            //                   children: <Widget>[
            //                     Icon(
            //                       Icons.cloud_download,
            //                       color: Colors.cyan,
            //                     ),
            //                     HEmptyView(10),
            //                     Text("Download",
            //                         style: TextStyle(color: Colors.cyan)),
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            // ),
          ],
        ),
      );
    });
  }

  Widget _buildPlayer(SongProvider model) => Container(
        padding: EdgeInsets.all(ScreenUtil().setHeight(35)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.curSong.name,
              style: commonWhiteTextStyle,
            ),
            Text(
              "${model.curSong.artist} : ${model.curSong.album}",
              style: smallWhite70TextStyle,
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
              child: SongProgressWidget(model),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(35),
                  top: ScreenUtil().setHeight(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ImageMenuWidget(
                    'images/icon_song_left.png',
                    80,
                    onTap: () {
                      model.prePlay();
                    },
                  ),
                  ImageMenuWidget(
                    model.curState == AudioPlayerState.PLAYING
                        ? 'images/icon_song_pause.png'
                        : 'images/icon_song_play.png',
                    150,
                    onTap: () {
                      model.togglePlay();
                    },
                  ),
                  ImageMenuWidget(
                    'images/icon_song_right.png',
                    80,
                    onTap: () {
                      model.nextPlay();
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: user == false
                  ? Container()
                  : Padding(
                      padding:
                          EdgeInsets.only(top: ScreenUtil().setHeight(180)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              model.downloadFile(context);
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.cloud_download,
                                  color: Colors.cyan,
                                ),
                                HEmptyView(10),
                                Text("Download",
                                    style: TextStyle(color: Colors.cyan)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            )
          ],
        ),
      );
}
