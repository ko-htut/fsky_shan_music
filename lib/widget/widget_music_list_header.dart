import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'common_text_style.dart';
import 'h_empty_view.dart';

class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {
  MusicListHeader({this.title, this.count, this.tail});
  final String title;
  final int count;
  final Widget tail;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(ScreenUtil().setWidth(30))),
      child: Container(
          color: Colors.white,
          child: InkWell(
            onTap: () {},
            child: SizedBox.fromSize(
              size: preferredSize,
              child: Row(
                children: <Widget>[
                  HEmptyView(20),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      title,
                      style: mCommonTextStyle,
                    ),
                  ),
                  HEmptyView(5),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: count == null
                        ? Container()
                        : Text(
                            "(Star $count首)",
                            style: smallGrayTextStyle,
                          ),
                  ),
                  Spacer(),
                  tail ?? Container(),
                ],
              ),
            ),
          )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setWidth(100));
}
