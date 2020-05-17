import 'package:flutter/material.dart';
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
  final List<Widget> _children = [HomePage(), AlbumPage(), Text("home 3")];
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
        title: Text('F Sky Music'),
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
        selectedItemColor: Colors.red,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Album'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }
}
