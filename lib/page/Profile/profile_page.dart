import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _login() {
    return Card(
        elevation: 0,
        child: Container(
          height: ScreenUtil().setHeight(180),
          child: Row(
            children: <Widget>[
              Image.asset(
                'images/fskylogo.png',
                height: ScreenUtil().setHeight(170),
                width: ScreenUtil().setHeight(170),
              ),
              Container(
                height: ScreenUtil().setHeight(175),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(80),
                      width: ScreenUtil().setWidth(500),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber[50]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                                "content me"),
                          ),
                        )),
                    Container(
                      // color: Colors.grey,
                      width: ScreenUtil().setWidth(500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom:8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),color: Colors.deepOrange[200]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("login"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        _login(),
        ListTile(leading:Icon(Icons.link),title: Text("Facebook Page"),),
        ListTile(leading:Icon(Icons.info),title: Text("About"),),
        ListTile(leading:Icon(Icons.insert_drive_file),title: Text("Statement"),)
      ],
    )));
  }
}