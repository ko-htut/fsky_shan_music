import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/page/Profile/profile_page.dart';
import 'package:flutter_fsky_music/page/album/album_page.dart';
import 'package:flutter_fsky_music/page/home/home_page.dart';
import 'package:flutter_fsky_music/utils/navigator_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomePage(), AlbumPage(), ProfilePage()];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('F-Sky Music'),
        actions: <Widget>[
          Container(
            // color: Colors.green,
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: ScreenUtil().setWidth(50),
                color: Colors.black87,
              ),
              onPressed: () {
                NavigatorUtil.goSearchPage(context);
              },
            ),
          )
        ],
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.amber,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Image.asset(
              'images/musical.png',
              height: ScreenUtil().setHeight(45),
              width: ScreenUtil().setHeight(45),
            ),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Image.asset(
              'images/falbum.png',
              height: ScreenUtil().setHeight(45),
              width: ScreenUtil().setHeight(45),
            ),
            title: Text('Album'),
          ),
          new BottomNavigationBarItem(
              icon: Image.asset(
                'images/popeye.png',
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().setHeight(50),
              ),
              title: Text('Profile'))
        ],
      ),
    );
  }
}
