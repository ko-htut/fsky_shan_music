import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../application.dart';
import '../model/song_model.dart';
import '../provider/song_provider.dart';
import '../utils/navigator_util.dart';
import 'common_text_style.dart';
import 'h_empty_view.dart';
import 'widget_round_img.dart';

class PlayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Consumer<SongProvider>(builder: (context, model, child) {
        Widget child;
        if (model.allSongs.isEmpty)
          child = Text('No song currently playing');
        else {
          Song curSong = model.curSong;
          child = GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              NavigatorUtil.goplay(context);
            },
            child: Row(
              children: <Widget>[
                RoundImgWidget(curSong.cover, 80),
                HEmptyView(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(curSong.name, style: Theme.of(context).textTheme.caption, maxLines: 1, overflow: TextOverflow.ellipsis,),
                      Text(curSong.artist, style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    if(model.curState == null){
                      model.play();
                    }else {
                      model.togglePlay();
                    }
                  },
                  child: Image.asset(
                    model.curState == AudioPlayerState.PLAYING
                        ? 'images/pause.png'
                        : 'images/play.png',
                    width: ScreenUtil().setWidth(50),
                  ),
                ),
                HEmptyView(15),
                // GestureDetector(
                //   onTap: (){},
                //   child: Image.asset(
                //     'images/list.png',
                //     width: ScreenUtil().setWidth(50),
                //   ),
                // ),
              ],
            ),
          );
        }

        return Container(
          width: Application.screenWidth,
          height: ScreenUtil().setWidth(125) + Application.bottomBarHeight,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[200])),
              color: Colors.white),
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
          child: Container(
            width: Application.screenWidth,
            height: ScreenUtil().setWidth(125),
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
            alignment: Alignment.center,
            child: child,
          ),
        );
      }),
    );
  }
}
