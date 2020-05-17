import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/model/album_model.dart';
import 'package:flutter_fsky_music/model/song_play.dart';
import 'package:flutter_fsky_music/provider/play_songs_model.dart';
import 'package:flutter_fsky_music/widget/decription_widget.dart';
import 'package:flutter_fsky_music/widget/v_empty_view.dart';
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
              playOnTap: (model) {},
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
            Consumer<PlaySongsModel>(builder: (context, model, child) {
              return SliverList(
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
                        // playSongs(model, index);
                      },
                    );
                  },
                  childCount: widget.data.songs.length,
                ),
              );
            })
          ],
        )
      ],
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => child.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
