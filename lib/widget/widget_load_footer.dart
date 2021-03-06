import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadFooter extends Footer {
  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulledExtent,
      double loadTriggerPullDistance,
      double loadIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteLoad,
      bool success,
      bool noMore) {
    if (noMore)
      return Container(
        height: ScreenUtil().setWidth(100),
        alignment: Alignment.center,
        child: Text('No more data'),
      );
    else
      return Container(
        height: ScreenUtil().setWidth(100),
        alignment: Alignment.center,
        child: Text('loading...'),
      );
  }
}
