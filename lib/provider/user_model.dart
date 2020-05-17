import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_fsky_music/model/user.dart';
import '../application.dart';

class UserModel with ChangeNotifier {
  User _user;
  User get user => _user;

  void initUser() {
    if (Application.sp.containsKey('user')) {
      String s = Application.sp.getString('user');
      _user = User.fromJson(json.decode(s));
    }
  }

  Future<User> login(BuildContext context, String email, String pwd) async {
    // User user = await NetUtils.login(context, email, pwd);
    _saveUserInfo(user);
    return user;
  }

  _saveUserInfo(User user) {
    _user = user;
    Application.sp.setString('user', json.encode(user.toJson()));
  }
}
