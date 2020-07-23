
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/post/MyPostsPage.dart';
import 'package:flutterapp/user/UserModelVM.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pref.dart';
import 'login.dart';

class MyPage extends StatelessWidget {
  UserModelVM userModel;

  @override
  Widget build(BuildContext context) {
    if(userModel==null) {
      userModel = Provider.of<UserModelVM>(context, listen: false);
      userModel.loadUserSession();
    }
    return _buildSuggestions(context);
  }


  Widget _buildSuggestions(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.all(10),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Consumer<UserModelVM>(
              builder: (context, usermod, child) =>
                  new Text('用户名：${ usermod.user?.name}')),
          new Padding(padding: EdgeInsets.only(top: 30)),
          new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (context) {
                      return new MyPostsPage();
                    },
                  ),
                );
              },
              child: new Text('我的帖子')),
          new Padding(padding: EdgeInsets.only(top: 30)),
          new GestureDetector(
              child: new Text('退出登录'),
              onTap: () {
                _logout(context);
              })
        ],
      ),
    );
  }


  void _logout(BuildContext context) async {
   var ret=await userModel.clearLoginUserSession();

    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
      builder: (context) {
        return new Login();
      },
    ), (Route<dynamic> route) => false);
  }
}

