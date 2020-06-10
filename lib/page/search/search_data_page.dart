import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_fsky_music/model/song_play.dart';
import 'package:flutter_fsky_music/model/song_model.dart'as s;
import 'package:flutter_fsky_music/model/top_model.dart';
import 'package:flutter_fsky_music/utils/navigator_util.dart';
import 'package:flutter_fsky_music/utils/net_utils.dart';
import 'package:flutter_fsky_music/widget/widget_load_footer.dart';
import 'package:flutter_fsky_music/widget/widget_music_list_item.dart';

typedef LoadMoreWidgetBuilder<T> = Widget Function(T data);
class SearchDataPage extends StatefulWidget {
  final String data;
  SearchDataPage({Key key, @required this.data}) : super(key: key);

  @override
  _SearchDataPageState createState() => _SearchDataPageState();
}

class _SearchDataPageState extends State<SearchDataPage>
    with AutomaticKeepAliveClientMixin {
  int _count = -1;
  Map<String, String> _params;
  List<Datum> _songsData = []; // 单曲数据
  EasyRefreshController _controller;
  int offset = 1;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    WidgetsBinding.instance.addPostFrameCallback((d) {
      _params = {'name': widget.data};
      _request();
    });
  }

  void _request() async {
    if (offset > 1) _params['offset'] = offset.toString();
    var r = await NetUtils.getsearch(context,name: widget.data);
    _count = r.data.length;
    _songsData.addAll(r.data);
  }
  Widget _buildArtistsPage() {
    return _buildLoadMoreWidget<Datum>(_songsData, (curData) {
      return WidgetMusicListItem(
                MusicData(
                  picUrl: curData.cover,
                  mvid: curData.id,
                  index: curData.id + 1,
                  songName: curData.name,
                  artists: "${curData.artist.artistName} : ${curData.album.albumName}",
                ),
                onTap: () {
                   playSongs(s.Song(
                    name: curData.name,
                    artist: curData.artist.artistName,
                    album: curData.album.albumName,
                    source: curData.source,
                    id: 1,
                    cover: curData.cover,
                    lyric: curData.lyric));
                },
              );
    });
  }
   Widget _buildLoadMoreWidget<T>(
      List<T> data, LoadMoreWidgetBuilder<T> builder) {
    return EasyRefresh.custom(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return builder(data[index]);
        }, childCount: data.length))
      ],
      footer: LoadFooter(),
      controller: _controller,
      onLoad: () async {
        offset++;
        _request();
        _controller.finishLoad(noMore: _songsData.length >= _count);
      },
    );
  }


  void playSongs(s.Song songn) {
    print(songn.source);
    NavigatorUtil.goplay(context, songn);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
      if (_count == -1) {
      return Center(child: CupertinoActivityIndicator());
    }
    return Scaffold(body: Center(child: _buildArtistsPage()));
    
  }
   @override
  bool get wantKeepAlive => true;
}
