import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provider/song_provider.dart';
import 'common_text_style.dart';

class SongProgressWidget extends StatelessWidget {
  final SongProvider model;

  SongProgressWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: StreamBuilder<String>(
        stream: model.curPositionStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.substring(snapshot.data.indexOf('-') + 1));
            var totalTime =
                snapshot.data.substring(snapshot.data.indexOf('-') + 1);
            var curTime = double.parse(
                snapshot.data.substring(0, snapshot.data.indexOf('-')));
            var curTimeStr =
                DateUtil.formatDateMs(curTime.toInt(), format: "mm:ss");
            return buildProgress(curTime, totalTime, curTimeStr);
          } else {
            return buildProgress(0, "0", "00:00");
          }
        },
      ),
    );
  }

  Widget buildProgress(double curTime, String totalTime, String curTimeStr) {
    return Container(
      height: ScreenUtil().setWidth(50),
      child: Row(
        children: <Widget>[
          Text(
            convertDurationToString(Duration(milliseconds: curTime.toInt())),
            style: smallWhiteTextStyle,
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: ScreenUtil().setWidth(2),
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: ScreenUtil().setWidth(10),
                ),
              ),
              child: Slider(
                value: curTime,
                onChanged: (data) {
                  model.sinkProgress(data.toInt());
                },
                onChangeStart: (data) {
                  model.pausePlay();
                },
                onChangeEnd: (data) {
                  model.seekPlay(data.toInt());
                },
                activeColor: Colors.white,
                inactiveColor: Colors.white30,
                min: 0,
                max: double.parse(totalTime),
              ),
            ),
          ),
          Text(
            convertDurationToString(
                Duration(milliseconds: int.parse(totalTime))),
            style: smallWhite30TextStyle,
          ),
        ],
      ),
    );
  }

  String convertDurationToString(Duration duration) {
    var minutes = duration.inMinutes.toString();
    if (minutes.length == 1) {
      minutes = '0' + minutes;
    }
    var seconds = (duration.inSeconds % 60).toString();
    if (seconds.length == 1) {
      seconds = '0' + seconds;
    }
    return "$minutes:$seconds";
  }
}
