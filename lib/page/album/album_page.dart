import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/model/album_model.dart';
import 'package:flutter_fsky_music/utils/navigator_util.dart';
import 'package:flutter_fsky_music/utils/net_utils.dart';
import 'package:flutter_fsky_music/widget/common_text_style.dart';
import 'package:flutter_fsky_music/widget/rounded_net_image.dart';
import 'package:flutter_fsky_music/widget/v_empty_view.dart';
import 'package:flutter_fsky_music/widget/widget_future_builder.dart';
import 'package:flutter_screenutil/screenutil.dart';

class AlbumPage extends StatefulWidget {
  AlbumPage({Key key}) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  Widget _albumlist() {
    return CustomFutureBuilder<Album>(
        futureFunc: NetUtils.getAlbum,
        builder: (context, snapshot) {
          var data = snapshot.data;
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1 / 1.2),
            itemBuilder: (context, index) {
              var d = data[index];
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  NavigatorUtil.goAlbumShow(context, d);
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          RoundedNetImage(
                            '${d.cover}',
                            width: 200,
                            height: 200,
                          ),
                          Positioned(
                            bottom: 0,
                            child: Image.asset(
                              "images/ck.9.png",
                              width: ScreenUtil().setWidth(200),
                              height: ScreenUtil().setWidth(80),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            child: Text(
                              d.name,
                              style: smallWhiteTextStyle,
                            ),
                            left: ScreenUtil().setWidth(10),
                            bottom: ScreenUtil().setWidth(10),
                          )
                        ],
                      ),
                      VEmptyView(10),
                      Container(
                        child: Text(
                          d.name,
                          style: common13TextStyle,
                        ),
                        width: ScreenUtil().setWidth(200),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: data.length,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[_albumlist()],
      ),
    );
  }
}
