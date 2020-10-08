import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/application.dart';
import 'package:flutter_fsky_music/database/download_helper.dart';
import 'package:flutter_fsky_music/model/song_model.dart';
import 'package:flutter_fsky_music/utils/fluro_convert_utils.dart';
import 'package:flutter_fsky_music/widget/download_alert.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum PlayerState { stopped, playing, paused }

class SongProvider with ChangeNotifier {
  bool downloaded = false;
  var dlDB = DownloadsDB();
  AudioPlayer _audioPlayer = AudioPlayer();
  StreamController<String> _curPositionController =
      StreamController<String>.broadcast();

  List<Song> _songs = [];
  int curIndex = 0;
  Duration curSongDuration;
  AudioPlayerState _curState;

  List<Song> get allSongs => _songs;
  Song get curSong => _songs[curIndex];
  Stream<String> get curPositionStream => _curPositionController.stream;
  AudioPlayerState get curState => _curState;
  String localFilePath;

  void init() {
    _audioPlayer.setReleaseMode(ReleaseMode.STOP);
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _curState = state;

      if (state == AudioPlayerState.COMPLETED) {
        nextPlay();
      }
      notifyListeners();
    });
    _audioPlayer.onDurationChanged.listen((d) {
      curSongDuration = d;
    });
    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      sinkProgress(p.inMilliseconds > curSongDuration.inMilliseconds
          ? curSongDuration.inMilliseconds
          : p.inMilliseconds);
    });
  }

  void sinkProgress(int m) {
    _curPositionController.sink.add('$m-${curSongDuration.inMilliseconds}');
  }

  void playSong(Song song) {
    _songs.insert(curIndex, song);
    play();
  }

  void playSongs(List<Song> songs, {int index}) {
    this._songs = songs;
    if (index != null) curIndex = index;
    play();
  }

  void addSongs(List<Song> songs) {
    this._songs.addAll(songs);
  }

  void play() async {
    var url = this._songs[curIndex].source;
    _audioPlayer.play(url);
    saveCurSong();
  }

  void togglePlay() {
    if (_audioPlayer.state == AudioPlayerState.PAUSED) {
      resumePlay();
    } else {
      pausePlay();
    }
  }

  void pausePlay() {
    _audioPlayer.pause();
  }

  void seekPlay(int milliseconds) {
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
    resumePlay();
  }

  void resumePlay() {
    _audioPlayer.resume();
  }

  void nextPlay() {
    if (curIndex >= _songs.length) {
      curIndex = 0;
    } else {
      curIndex++;
    }
    play();
  }

  

  void prePlay() {
    if (curIndex <= 0) {
      curIndex = _songs.length - 1;
    } else {
      curIndex--;
    }
    play();
  }

  void clean() {
    _songs.clear();
  }

  void saveCurSong() {
    Application.sp.remove('playing_songs');
    Application.sp.setStringList('playing_songs',
        _songs.map((s) => FluroConvertUtils.object2string(s)).toList());
    Application.sp.setInt('playing_index', curIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _curPositionController.close();
    _audioPlayer.dispose();
  }

  Future downloadFile(BuildContext context) async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      startDownload(context);
    } else {
      startDownload(context);
    }
  }

  void onComplete() {
    _curState = AudioPlayerState.STOPPED;
  }

  void startDownload(
    BuildContext context,
  ) async {
    Directory appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    if (Platform.isAndroid) {
      Directory(appDocDir.path.split('Android')[0] + 'FSky').createSync();
    }
    String songname = curSong.name.replaceAll(' ', '_').replaceAll(r"\'", "'");

    String path = Platform.isIOS
        ? appDocDir.path + '/$songname.mp3'
        : appDocDir.path.split('Android')[0] + 'FSky/$songname.mp3';
    print(path);
    File file = File(path);
    if (!await file.exists()) {
      await file.create();
    } else {
      await file.delete();
      await file.create();
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => DownloadAlert(
        url: curSong.source,
        path: path,
      ),
    ).then((v) {
      // When the download finishes, we then add the book
      // to our local database
      if (v != null) {
        addDownload(
          {
            'id': curSong.id,
            'path': path,
            'image': '${curSong.cover}',
            'size': v,
            'name': curSong.name,
          },
        );
      }
    });
  }

  addDownload(Map body) async {
    await dlDB.add(body);
    checkDownload();
  }

  checkDownload() async {
    List c = await dlDB.check({'id': curSong.id});
    if (c.isNotEmpty) {
      setDownloaded(true);
    } else {
      setDownloaded(false);
    }
  }

  void setDownloaded(value) {
    downloaded = value;
    notifyListeners();
  }
}
