import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/user_model.dart';
import '../../utils/navigator_util.dart';
import '../../utils/net_utils.dart';
import '../../utils/utils.dart';
import '../../widget/common_button.dart';
import '../../widget/v_empty_view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    Future.delayed(Duration(milliseconds: 500), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text("Login")),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(80),
                right: ScreenUtil().setWidth(80),
                top: ScreenUtil().setWidth(130),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'images/fskylogo.png',
                          width: ScreenUtil().setWidth(200),
                          height: ScreenUtil().setWidth(200),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(),
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setWidth(100)),
                              child: Text(
                                'F Sky ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  _LoginAnimatedWidget(
                    animation: _animation,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginWidget extends StatefulWidget {
  @override
  __LoginWidgetState createState() => __LoginWidgetState();
}

class __LoginWidgetState extends State<_LoginWidget> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    NetUtils();
    return Theme(
      data: ThemeData(primaryColor: Colors.red),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          VEmptyView(30),
          TextField(
            textInputAction: TextInputAction.next,
            controller: _phoneController,
            keyboardType: TextInputType.emailAddress,
            decoration: _getInputDec(
                "Email or Phone number", Icon(AntIcons.phone_outline)),
          ),
          VEmptyView(25),
          TextField(
            textInputAction: TextInputAction.done,
            obscureText: true,
            controller: _pwdController,
            decoration: _getInputDec("Password", Icon(AntIcons.lock_outline)),
          ),
          VEmptyView(100),
          Consumer<UserModel>(
            builder: (BuildContext context, UserModel value, Widget child) {
              return CommonButton(
                color: Colors.amber,
                callback: () {
                  String email = _phoneController.text;
                  String pwd = _pwdController.text;
                  if (email.isEmpty || pwd.isEmpty) {
                    Utils.showToast(
                        'ကျေးဇူးပြု၍ သင်၏အကောင့်နံပါတ်သို့မဟုတ်လျှို့ဝှက်နံပါတ်ကိုရိုက်ထည့်ပါ');
                    return;
                  }
                  value
                      .login(
                    context,
                    email,
                    pwd,
                  )
                      .then((value) {
                    if (value != null) {
                      NavigatorUtil.goindexPage(context);
                    }
                  });
                },
                content: 'Login',
                width: double.infinity,
              );
            },
          )
        ],
      ),
    );
  }
}

InputDecoration _getInputDec(String hint, Icon icon) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(0),
    hintText: hint,
    prefixIcon: icon,
    fillColor: Colors.grey[200],
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
}

class _LoginAnimatedWidget extends AnimatedWidget {
  final Tween<double> _opacityTween = Tween(begin: 0, end: 1);
  final Tween<double> _offsetTween = Tween(begin: 40, end: 0);
  final Animation animation;

  _LoginAnimatedWidget({
    @required this.animation,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        margin: EdgeInsets.only(top: _offsetTween.evaluate(animation)),
        child: _LoginWidget(),
      ),
    );
  }
}
