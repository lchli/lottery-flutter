import 'package:flutter/material.dart';
import 'package:flutterapp/post/PostDetailPage.dart';
import 'package:flutterapp/client/ApiUrl.dart';
import 'package:flutterapp/post/PostModel.dart';
import 'package:flutterapp/user/UserModelVM.dart';
import 'package:provider/provider.dart';
import '../Pref.dart';
import '../user/register.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:english_words/english_words.dart';

class MyPostsPage extends StatelessWidget {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  PostModel postModel;
  UserModelVM userModel;

  @override
  Widget build(BuildContext context) {
    if (postModel == null) {
      postModel = Provider.of<PostModel>(context, listen: true);
      userModel = Provider.of<UserModelVM>(context, listen: false);
      postModel.loadMyPost(userModel.user?.id, userModel.user?.token);
    }
    return Scaffold(body:_buildSuggestions(context), appBar: AppBar(
      title: Text('我的帖子'),
    ));
  }

  Widget _buildSuggestions(BuildContext context) {

    int itemcount=postModel.myPosts!=null?postModel.myPosts.length:0;

    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: itemcount, //数据的数量
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        return _buildRow(postModel.myPosts[i], context);
      },
    );
  }

  Widget _buildRow(Map pair, BuildContext context) {
    return new ListTile(
      title: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              pair['title'],
              style: _biggerFont,
            ),
            new Text(
              "作者：${pair['title']}",
              style: TextStyle(fontSize: 10.0),
            )
          ]),
      trailing: new Icon(
        Icons.favorite,
        color: Colors.red,
      ),
      onTap: () {
        _gotoPostDetail(pair["uid"], context);
//        setState(
//                () {
//              if (alreadySaved) {
//                _saved.remove(pair);
//              } else {
//                _saved.add(pair);
//              }
//            }
//        );
      },
    );
  }

  void _gotoPostDetail(String postId, BuildContext context) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new PostDetailPage(postId);
        },
      ),
    ).then(
        (value) => postModel.loadMyPost(userModel.user?.id, userModel.user?.token));
  }
}
