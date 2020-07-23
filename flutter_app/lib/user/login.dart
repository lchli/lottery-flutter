import 'package:flutter/material.dart';
import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/ui/FilterPage.dart';
import 'package:flutterapp/user/UserModelVM.dart';
import 'package:flutterapp/user/domain/User.dart';
import 'package:provider/provider.dart';
import '../Pref.dart';
import 'register.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  createState() => new _LoginState();
}


/// State for [ExampleWidget] widgets.
class _LoginState extends State<Login> {
  final TextEditingController _controllerAccount = new TextEditingController();
  final TextEditingController _controllerPwd = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold( appBar: new AppBar(
      title: new Text('登录'),
      centerTitle: true,
    ), body:new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new TextField(
          controller: _controllerAccount,
          decoration: new InputDecoration(
            hintText: '输入账号',
          ),
        ),
        new TextField(
          controller: _controllerPwd,
          decoration: new InputDecoration(
            hintText: '输入密码',
          ),
        ),
        new Row(children: <Widget>[
        new RaisedButton(
          onPressed: () {
            _login();
          },
          child: new Text('登录'),
        ),
        new Padding(padding: const EdgeInsets.only(right: 50.0)),
        new RaisedButton(
          onPressed: () {
           _gotoRegister();
          },
          child: new Text('去注册'),
        )],
            mainAxisAlignment:MainAxisAlignment.center
        )
      ],
    ));
  }

  void _gotoRegister() {

    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new FilterPage(
          );
        },
      ),
    );
  }


  Future<void> _login() async {
    var account=_controllerAccount.text;
    var pwd=_controllerPwd.text;

    var userModel = Provider.of<UserModelVM>(context,listen: false);
    Result<User> responseBodyResult=await userModel.login(account, pwd);
    if(responseBodyResult.code!="0"){
      Fluttertoast.showToast(
          msg: responseBodyResult.msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    User responseBody=responseBodyResult.data;

    userModel.saveUserSession(responseBody);

    _gotoMain();
  }

  void _gotoMain() {

    Navigator.of(context).pushAndRemoveUntil(
      new MaterialPageRoute(
        builder: (context) {
          return new MainPage(
          );
        },
      ),
            (Route<dynamic> route) => false
    );
  }
}