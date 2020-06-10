import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/model/song_model.dart' as s;
import 'package:flutter_fsky_music/model/album_model.dart';
import 'package:flutter_fsky_music/model/song_play.dart';
import 'package:flutter_fsky_music/utils/navigator_util.dart';
import 'package:flutter_fsky_music/widget/widget_album_appbar.dart';
import 'package:flutter_fsky_music/widget/widget_music_list_item.dart';
import 'package:flutter_read_more_text/flutter_read_more_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AlbumShow extends StatefulWidget {
  final Datum data;
  AlbumShow({Key key, @required this.data}) : super(key: key);

  @override
  _AlbumShowState createState() => _AlbumShowState();
}

class _AlbumShowState extends State<AlbumShow> {
  double _expandedHeight = ScreenUtil().setWidth(550);
  int _count;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            AlbumAppBarWidget(
              backgroundImg: widget.data.cover,
              count: _count,
              // playOnTap: (model) {},
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                    margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                    child: RichText(
                      text: TextSpan(
                        children: [],
                      ),
                    ),
                  ),
                ],
              ),
              expandedHeight: _expandedHeight,
              title: widget.data.name,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ReadMoreText(widget.data.about),
              ),
            ),
             SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var d = widget.data.songs[index];
                    return WidgetMusicListItem(
                      MusicData(
                          mvid: d.id,
                          picUrl: d.cover,
                          songName: d.name,
                          artists: "${d.artist.artistName}"),
                      onTap: () {
                         playSongs(s.Song(
                    name: d.name,
                    artist: d.artist.artistName,
                    album: d.album.albumName,
                    source: d.source,
                    id: index,
                    cover: d.cover,
                    lyric: d.lyric));
                      },
                    );
                  },
                  childCount: widget.data.songs.length,
                ),
              )
          ],
        )
      ],
    ));
  }
    void playSongs(s.Song songn) {
    print(songn.source);
    NavigatorUtil.goplay(context, songn);
  }
}