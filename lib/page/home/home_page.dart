import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/model/album_model.dart';
import 'package:flutter_fsky_music/model/song_model.dart' as s;
import 'package:flutter_fsky_music/model/song_model.dart';
import 'package:flutter_fsky_music/model/song_play.dart';
import 'package:flutter_fsky_music/model/top_model.dart';
import 'package:flutter_fsky_music/provider/song_provider.dart';
import 'package:flutter_fsky_music/utils/navigator_util.dart';
import 'package:flutter_fsky_music/utils/net_utils.dart';
import 'package:flutter_fsky_music/widget/widget_future_builder.dart';
import 'package:flutter_fsky_music/widget/widget_music_list_item.dart';
import 'package:flutter_fsky_music/widget/widget_play.dart';
import 'package:flutter_fsky_music/widget/widget_play_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../widget/common_text_style.dart';
import '../../widget/h_empty_view.dart';
import '../../widget/v_empty_view.dart';
import 'package:flutter_fsky_music/model/banner.dart' as ba;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _count;
  Top data;
  Widget _buildBanner() {
    return CustomFutureBuilder<ba.Banner>(
      futureFunc: NetUtils.getBannerData,
      builder: (context, dataa) {
        return Card(
          elevation: 0,
          child: Container(
            height: ScreenUtil().setHeight(350),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(dataa.data.path)),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey),
          ),
        );
      },
    );
  }

  Widget _topSong() {
    return CustomFutureBuilder<Top>(
        futureFunc: NetUtils.getTopSong,
        builder: (context, snapshot) {
          this.data = snapshot;
          var data = snapshot.data;
          return Consumer<SongProvider>(
            builder: (context, model, child) {
              return Container(
                  height: ScreenUtil().setWidth(300),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return HEmptyView(ScreenUtil().setWidth(30));
                    },
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15)),
                    itemBuilder: (context, index) {
                      return PlayListWidget(
                        onTap: () {
                          playSongs(model, index);
                        },
                        text: data[index].name,
                        picUrl: data[index].cover,
                        subText: data[index].artist.artistName ?? "",
                        maxLines: 1,
                      );
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                  ));
            },
          );
        });
  }

  Widget _newssong() {
    return CustomFutureBuilder<Top>(
      futureFunc: NetUtils.getSong,
      builder: (context, data) {
        this.data = data;
        return Consumer<SongProvider>(builder: (context, model, child) {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return VEmptyView(ScreenUtil().setWidth(100));
            },
            itemCount: data.data.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var d = data.data[index];
              return WidgetMusicListItem(
                MusicData(
                  picUrl: d.cover,
                  mvid: d.id,
                  index: index + 1,
                  songName: d.name,
                  artists: "${d.artist.artistName} : ${d.album.albumName}",
                ),
                onTap: () {
                  playSongs(model, index);
                },
              );
            },
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        height: ScreenUtil().setHeight(350),
                        child: _buildBanner())),
                VEmptyView(20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(15),
                  ),
                  child: Text(
                    'Top Song',
                    style: commonTextStyle,
                  ),
                ),
                VEmptyView(20),
                _topSong(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(15),
                  ),
                  child: Text(
                    'New Song',
                    style: commonTextStyle,
                  ),
                ),
                VEmptyView(20),
                _newssong(),
              ],
            ),
          ),
          // PlayWidget()
        ],
      ),
    );
  }

  void playSongs(SongProvider model, int index) {
    model.playSongs(
      data.data
          .map((r) => s.Song(
              name: r.name,
              artist: r.artist.artistName,
              album: r.album.albumName,
              source: r.source,
              id: 1,
              cover: r.cover,
              lyric: r.lyric))
          .toList(),
      index: index,
    );
    NavigatorUtil.goplay(context);
  }

  void setCount(int count) {
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _count = count;
        });
      }
    });
  }
}
