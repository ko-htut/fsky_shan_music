import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/utils/utils.dart';
import 'package:flutter_fsky_music/widget/widget_music_list_header.dart';
import 'flexible_detail_bar.dart';

class AlbumAppBarWidget extends StatelessWidget {
  final double expandedHeight;
  final Widget content;
  final String backgroundImg;
  final double sigma;
  final String title;
  // final PlayModelCallback playOnTap;
  final int count;

  AlbumAppBarWidget({
    @required this.title,
    @required this.expandedHeight,
    @required this.content,
    @required this.backgroundImg,
    this.sigma = 2,
    // this.playOnTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      expandedHeight: expandedHeight,
      pinned: true,
      elevation: 0,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white),
      bottom: MusicListHeader(
        title: title,
        // onTap: playOnTap,
        count: count,
      ),
      flexibleSpace: FlexibleDetailBar(
        content: content,
        background: Stack(
          children: <Widget>[
            backgroundImg.startsWith('http')
                ? Utils.showNetImage(
                    '$backgroundImg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    backgroundImg,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: sigma,
                sigmaX: sigma,
              ),
              child: Container(
                color: Colors.black38,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
