import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/utils/navigator_util.dart';
import 'package:flutter_fsky_music/widget/widget_play.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../application.dart';
import '../../model/user.dart';
import '../../provider/user_model.dart';
import '../../utils/navigator_util.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User mydata;
  bool user = false;
  @override
  void initState() {
    super.initState();
    clickuser();
  }

  void clickuser() async {
    await Application.initSp();
    UserModel userModel = Provider.of<UserModel>(context);
    userModel.initUser(context);
    if (userModel.user != null) {
      setState(() {
        user = true;
        mydata = userModel.user;
      });
    } else {
      setState(() {
        user = false;
      });
    }
  }

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
                    InkWell(
                      onTap: () async {
                        String fbProtocolUrl;
                        if (Platform.isIOS) {
                          fbProtocolUrl = 'fb://profile/190222684844743';
                        } else {
                          fbProtocolUrl = 'fb://page/190222684844743';
                        }
// https://www.facebook.com/190222684844743
                        String fallbackUrl =
                            'https://www.facebook.com/saifafsky422';
                        try {
                          bool launched =
                              await launch(fbProtocolUrl, forceSafariVC: false);

                          if (!launched) {
                            await launch(fallbackUrl, forceSafariVC: false);
                          }
                        } catch (e) {
                          await launch(fallbackUrl, forceSafariVC: false);
                        }
                        // Share.share('https://www.facebook.com/saifafsky422');
                      },
                      child: Container(
                          height: ScreenUtil().setHeight(80),
                          width: ScreenUtil().setWidth(500),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber[50]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text("content me"),
                            ),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        NavigatorUtil.goLoginPage(context);
                      },
                      child: Container(
                        // color: Colors.grey,
                        width: ScreenUtil().setWidth(500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.deepOrange[200]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("login"),
                                ),
                              ),
                            ),
                          ],
                        ),
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
        body: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              bottom: ScreenUtil().setWidth(110) + Application.bottomBarHeight),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                user == false
                    ? _login()
                    : ListTile(
                        title: Text("Name : ${mydata.success.details.name}"),
                        subtitle:
                            Text("Password : ${mydata.success.details.email}"),
                      ),
                ListTile(
                  onTap: () async {
                    String fbProtocolUrl;
                    if (Platform.isIOS) {
                      fbProtocolUrl = 'fb://profile/190222684844743';
                    } else {
                      fbProtocolUrl = 'fb://page/190222684844743';
                    }
// https://www.facebook.com/190222684844743
                    String fallbackUrl =
                        'https://www.facebook.com/saifafsky422';
                    try {
                      bool launched =
                          await launch(fbProtocolUrl, forceSafariVC: false);

                      if (!launched) {
                        await launch(fallbackUrl, forceSafariVC: false);
                      }
                    } catch (e) {
                      await launch(fallbackUrl, forceSafariVC: false);
                    }
                    // Share.share('https://www.facebook.com/saifafsky422');
                  },
                  leading: Icon(Icons.link),
                  title: Text("Facebook Page"),
                ),
                ListTile(
                  leading: Icon(Icons.cloud_download),
                  title: Text("Download"),
                  onTap: () {
                    NavigatorUtil.godownload(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About"),
                ),
                ListTile(
                  leading: Icon(Icons.insert_drive_file),
                  title: Text("Statement"),
                  onTap: () {
                    NavigatorUtil.gostatePage(context);
                  },
                )
              ],
            ),
          ),
        ),
        PlayWidget()
      ],
    ));
  }
}
