import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/model/song_model.dart';
import 'package:flutter_fsky_music/utils/utils.dart';
import 'package:flutter_fsky_music/widget/common_text_style.dart';
import 'package:flutter_fsky_music/widget/h_empty_view.dart';
import 'package:flutter_fsky_music/widget/widget_img_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef void OnError(Exception exception);

const kUrl = "https://eboxmovie.sgp1.digitaloceanspaces.com/849234502.mp3";

enum PlayerState { stopped, playing, paused }

class MusicPlayPage extends StatefulWidget {
  final Song song;
  MusicPlayPage({Key key, @required this.song}) : super(key: key);
  @override
  _MusicPlayPageState createState() => _MusicPlayPageState();
}

class _MusicPlayPageState extends State<MusicPlayPage> {
  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  void initAudioPlayer() {
    audioPlayer = AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() => duration = audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });
  }

// http://sayarkyee.rankistcma.com/saisai.MP3
// http://sayarkyee.rankistcma.com/saisai.mp3
// https://eboxmovie.sgp1.digitaloceanspaces.com/saisai.MP3
// https://eboxmovie.sgp1.digitaloceanspaces.com/849234502.mp3
  Future play() async {
    await audioPlayer.play(widget.song.source);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = Duration();
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Utils.showNetImage(
            widget.song.cover,
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
                  widget.song.name,
                  style: commonWhiteTextStyle,
                ),
                Text(
                  "${widget.song.artist} : ${widget.song.album}",
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
              child: (duration != null)
                  ? Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "${positionText ?? ''}",
                                style: commonWhiteTextStyle,
                              ),
                              Expanded(
                                child: Slider(
                                    value:
                                        position?.inMilliseconds?.toDouble() ??
                                            0.0,
                                    onChanged: (double value) {
                                      return audioPlayer
                                          .seek((value / 1000).roundToDouble());
                                    },
                                    min: 0.0,
                                    max: duration.inMilliseconds.toDouble()),
                              ),
                              Text(
                                "${durationText ?? ''}",
                                style: commonWhiteTextStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(
                      width: double.infinity,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              height: ScreenUtil().setWidth(200),
                              child: CupertinoActivityIndicator(),
                            ),
                            HEmptyView(10),
                            Text(
                              "Loading . . .",
                              style: smallWhite70TextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            // child: _buildPlayer(),
          ),
          Align(alignment: Alignment.bottomCenter, child: _buildPlayer()),
          Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(180)),
                child: (duration != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildMuteButtons(),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.cloud_download,
                                color: Colors.cyan,
                              ),
                              HEmptyView(10),
                              Text("Download",
                                  style: TextStyle(color: Colors.cyan)),
                            ],
                          )
                        ],
                      )
                    : Container()),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayer() => Container(
        padding: EdgeInsets.all(ScreenUtil().setHeight(35)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(35),
                  top: ScreenUtil().setHeight(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ImageMenuWidget('images/icon_songs_circle.png', 80),
                  ImageMenuWidget(
                    'images/icon_song_left.png',
                    80,
                    onTap: () {
                      // model.prePlay();
                    },
                  ),
                  ImageMenuWidget(
                    isPlaying
                        ? 'images/icon_song_pause.png'
                        : 'images/icon_song_play.png',
                    150,
                    onTap: () {
                      isPlaying ? pause() : play();
                    },
                  ),
                  ImageMenuWidget(
                    'images/icon_song_right.png',
                    80,
                    onTap: () {
                      // model.nextPlay();
                    },
                  ),
                  ImageMenuWidget('images/mute.png', 80),
                  // Image.asset(
                  //   'images/start.png',
                  //   width: ScreenUtil().setHeight(85),
                  //   height: ScreenUtil().setHeight(85),
                  // ),
                  // HEmptyView(10),

                  // Container(
                  //     child: isPlaying
                  //         ? Container(
                  //             width: ScreenUtil().setWidth(250),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: <Widget>[
                  //                 ImageMenuWidget(
                  //                   'images/pause.png',
                  //                   85,
                  //                   onTap: isPlaying ? () => pause() : null,
                  //                 ),
                  //                 ImageMenuWidget(
                  //                   'images/stop.png',
                  //                   85,
                  //                   onTap: isPlaying ? () => stop() : null,
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //         : InkWell(
                  //             onTap: () => play(),
                  //             child: Image.asset(
                  //               'images/play.png',
                  //               width: ScreenUtil().setHeight(85),
                  //               height: ScreenUtil().setHeight(85),
                  //             ))),
                  // HEmptyView(10),
                  // Image.asset(
                  //   'images/end.png',
                  //   width: ScreenUtil().setHeight(85),
                  //   height: ScreenUtil().setHeight(85),
                  // )
                ],
              ),
            ),
          ],
        ),
      );

  // Row _buildProgressView() => Row(mainAxisSize: MainAxisSize.min, children: [
  //       Padding(
  //         padding: EdgeInsets.all(12.0),
  //         child: CircularProgressIndicator(
  //           value: position != null && position.inMilliseconds > 0
  //               ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
  //                   (duration?.inMilliseconds?.toDouble() ?? 0.0)
  //               : 0.0,
  //           valueColor: AlwaysStoppedAnimation(Colors.cyan),
  //           backgroundColor: Colors.grey.shade400,
  //         ),
  //       ),
  //       Text(
  //         position != null
  //             ? "${positionText ?? ''} / ${durationText ?? ''}"
  //             : duration != null ? durationText : '',
  //         style: TextStyle(fontSize: 24.0),
  //       )
  //     ]);

  Row _buildMuteButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (!isMuted)
          FlatButton.icon(
            onPressed: () => mute(true),
            icon: Icon(
              Icons.headset_off,
              color: Colors.cyan,
            ),
            label: Text('Mute', style: TextStyle(color: Colors.cyan)),
          ),
        if (isMuted)
          FlatButton.icon(
            onPressed: () => mute(false),
            icon: Icon(Icons.headset, color: Colors.cyan),
            label: Text('Unmute', style: TextStyle(color: Colors.cyan)),
          ),
      ],
    );
  }
}
