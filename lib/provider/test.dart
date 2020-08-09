// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_fsky_music/application.dart';
// import 'package:flutter_fsky_music/database/download_helper.dart';
// import 'package:flutter_fsky_music/model/song_model.dart';
// import 'package:audioplayer/audioplayer.dart';
// import 'package:flutter_fsky_music/utils/fluro_convert_utils.dart';
// import 'package:flutter_fsky_music/widget/download_alert.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// enum PlayerState { stopped, playing, paused }

// class SongProvider with ChangeNotifier {

//     bool downloaded = false;
//     var dlDB = DownloadsDB();
//   StreamController<String> _curPositionController =
//       StreamController<String>.broadcast();
//   bool isMuted = false;
//   List<Song> _songs = [];
//   List<Song> get allSongs => _songs;
//   Song get curSong => _songs[curIndex];
//   int curIndex = 0;
//   Duration duration;
//   Duration position;
//   AudioPlayerState _curState;
//   AudioPlayerState get curState => _audioPlayer.state;
//   StreamSubscription _positionSubscription;
//   StreamSubscription _audioPlayerStateSubscription;
//   Duration curSongDuration;
//   AudioPlayer _audioPlayer;
//   Stream<String> get curPositionStream => _curPositionController.stream;
//   String localFilePath;

//   get durationText =>
//       duration != null ? duration.toString().split('.').first : '';

//   get positionText =>
//       position != null ? position.toString().split('.').first : '';

//   void init() {
//     _audioPlayer = AudioPlayer();
//     _positionSubscription =
//         _audioPlayer.onAudioPositionChanged.listen((p) => position = p);
//     _audioPlayerStateSubscription =
//         _audioPlayer.onPlayerStateChanged.listen((s) {
//       if (s == AudioPlayerState.PLAYING) {
//         duration = _audioPlayer.duration;
//       } else if (s == AudioPlayerState.STOPPED) {
//         onComplete();
//         position = duration;
//       }
//       if (s == AudioPlayerState.COMPLETED) {
//         nextPlay();
//         notifyListeners();
//       }
//     }, onError: (msg) {
//       _curState = AudioPlayerState.STOPPED;
//       duration = Duration(seconds: 0);
//       position = Duration(seconds: 0);
//       notifyListeners();
//     });
//     // _audioPlayer.onAudioPositionChanged.listen((Duration p) {
//     //   sinkProgress(p.inMilliseconds > curSongDuration.inMilliseconds
//     //       ? curSongDuration.inMilliseconds
//     //       : p.inMilliseconds);
//     // });
//   }

//   void sinkProgress(int m) {
//     _curPositionController.sink.add('$m-${curSongDuration.inMilliseconds}');
//   }

//   void addSongs(List<Song> songs) {
//     this._songs.addAll(songs);
//   }

//   void playSongs(List<Song> songs, {int index}) {
//     this._songs = songs;
//     if (index != null) curIndex = index;
//     play();
//   }

//   void playSong(Song song) {
//     _songs.insert(curIndex, song);
//     play();
//   }

//   void togglePlay() {
//     if (_audioPlayer.state == AudioPlayerState.PAUSED) {
//       play();
//     } else {
//       pausePlay();
//     }
//   }

//   void resumePlay() {
//     play();
//   }

//   void nextPlay() {
//     if (curIndex >= _songs.length) {
//       curIndex = 0;
//     } else {
//       stop();
//       curIndex++;
//     }
//     play();
//   }

//   void prePlay() {
//     if (curIndex <= 0) {
//       curIndex = _songs.length - 1;
//     } else {
//       stop();
//       curIndex--;
//     }
//     play();
//   }

//   void saveCurSong() {
//     Application.sp.remove('playing_songs');
//     Application.sp.setStringList('playing_songs',
//         _songs.map((s) => FluroConvertUtils.object2string(s)).toList());
//     Application.sp.setInt('playing_index', curIndex);
//   }

//   void pausePlay() {
//     _audioPlayer.pause();
//   }

//   void play() async {
//     var url = this._songs[curIndex].source;
//     _audioPlayer.play(url);
//     _curState = AudioPlayerState.PLAYING;
//     saveCurSong();
//   }

//   Future pause() async {
//     await _audioPlayer.pause();
//     _curState = AudioPlayerState.PAUSED;
//   }

//   Future stop() async {
//     await _audioPlayer.stop();
//     _curState = AudioPlayerState.STOPPED;
//     position = Duration();
//   }

//   Future mute(bool muted) async {
//     await _audioPlayer.mute(muted);
//     isMuted = muted;
//   }

//   @override
//   void dispose() {
//     _positionSubscription.cancel();
//     _audioPlayerStateSubscription.cancel();
//     _audioPlayer.stop();
//     super.dispose();
//   }

//   Future downloadFile(BuildContext context) async {
//     PermissionStatus permission = await PermissionHandler()
//         .checkPermissionStatus(PermissionGroup.storage);

//     if (permission != PermissionStatus.granted) {
//       await PermissionHandler().requestPermissions([PermissionGroup.storage]);
//       startDownload(context);
//     } else {
//       startDownload(context);
//     }
//   }

//   void onComplete() {
//     _curState = AudioPlayerState.STOPPED;
//   }

//   void startDownload(BuildContext context,) async {
//     Directory appDocDir = Platform.isAndroid
//         ? await getExternalStorageDirectory()
//         : await getApplicationSupportDirectory();
//     if (Platform.isAndroid) {
//       Directory(appDocDir.path.split('Android')[0] + 'FSky')
//           .createSync();
//     }
//     String songname = curSong.name.replaceAll(' ', '_').replaceAll(r"\'", "'");

//     String path = Platform.isIOS
//         ? appDocDir.path + '/$songname.mp3'
//         : appDocDir.path.split('Android')[0] +
//             'FSky/$songname.mp3';
//     print(path);
//     File file = File(path);
//     if (!await file.exists()) {
//       await file.create();
//     } else {
//       await file.delete();
//       await file.create();
//     }

//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) => DownloadAlert(
//         url: curSong.source,
//         path: path,
//       ),
//     ).then((v) {
//       // When the download finishes, we then add the book
//       // to our local database
//       if (v != null) {
//         addDownload(
//           {
//             'id': curSong.id,
//             'path': path,
//             'image': '${curSong.cover}',
//             'size': v,
//             'name': curSong.name,
//           },
//         );
//       }
//     });
//   }
//     addDownload(Map body) async {
//     await dlDB.add(body);
//     checkDownload();
//   }
//    checkDownload() async {
//     List c = await dlDB.check({'id': curSong.id});
//     if (c.isNotEmpty) {
//       setDownloaded(true);
//     } else {
//       setDownloaded(false);
//     }
//   }
//   void setDownloaded(value) {
//     downloaded = value;
//     notifyListeners();
//   }

// }
