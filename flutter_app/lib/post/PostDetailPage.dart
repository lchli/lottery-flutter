import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapp/post/MyPostsPage.dart';
import 'package:flutterapp/client/ApiUrl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../MainPage.dart';
import '../Pref.dart';
import 'WritePostPage.dart';
import '../user/register.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PostDetailPage extends StatefulWidget {
  final String postId;

  PostDetailPage(this.postId);

  @override
  PostDetailState createState() => PostDetailState(postId);
}

class PostDetailState extends State<PostDetailPage> {
  /// Allows to control the editor and the document.
  /// Zefyr editor like any other input field requires a focus node.
  String _document = "";
  String postId;
  String _title = "";
  String _imgurl =
      "https://dss2.bdstatic.com/6Ot1bjeh1BF3odCf/it/u=2255085977,314744431&fm=74&app=80&f=JPEG&size=f121,121?sec=1880279984&t=f2b0553348e7440cefd8601f948d41e7";
  String _selectedOp = "";
  bool _isMyPost=false;

  PostDetailState(this.postId);

  @override
  void initState() {
    super.initState();
_getOPMenu();
    _getPostDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        actions: <Widget>[
          _getOPMenu(),
        ],
        expandedHeight: 200,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: new Text(_title),
          background: new GestureDetector(
              onTap: () {
                Fluttertoast.showToast(
                    msg: "test",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Image.network(_imgurl, fit: BoxFit.cover)),
        ),
      ),
      SliverFillRemaining(
          child: new Padding(
        padding: EdgeInsets.all(10),
        child: new Text(_document
            // imageDelegate: CustomImageDelegate(),
            ),
      ))
    ]));
  }

  Widget _operationMenu() {

    return PopupMenuButton<String>(
      onSelected: (String result) {
        if (result.compareTo("edit") == 0) {
          _gotoEditPost();
        } else if (result.compareTo("del") == 0) {
          _delPost();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: "edit",
          child: Text('编辑'),
        ),
        const PopupMenuItem<String>(
          value: "del",
          child: Text('删除'),
        ),
      ],
    );
  }

  Future<void> _getPostDetail() async {
    Dio dio = Dio();

    var formData = {
      "postId": postId,
    };
    Response response = await dio.get(
        ApiUrl.post_detail,
        queryParameters: formData);
    print(response);

    Map<String, dynamic> responseBody = await jsonDecode(response.toString());
    String code = responseBody['code'];
    print(code);

    if (code.compareTo("1") != 0) {
      print(responseBody['errmsg']);
      Fluttertoast.showToast(
          msg: responseBody['errmsg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    final SharedPreferences prefs = await Pref.prefs;
    String userId=prefs.getString("userId");
    bool mypost=false;
    if(userId.compareTo(responseBody['userId'])==0){
      mypost=true;
    }

    setState(() {
      _document = responseBody['url'];
      _title = responseBody['title'];
      _isMyPost= mypost;
    });
  }

  _gotoEditPost(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new EditorPage(postId
          );
        },
      ),
    ).then((value) => _getPostDetail());
  }






  Future<void> _delPost() async {
    final SharedPreferences prefs = await Pref.prefs;

    var formData = {
      "userId": prefs.getString("userId"),
      "token": prefs.getString("userToken"),
      "favId": postId,
    };

    Dio dio =  Dio();

    Response response = await dio.get(ApiUrl.delete_post,queryParameters: formData);
    print(response);

    Map<String, dynamic> responseBody = await jsonDecode(response.toString());
    String code = responseBody['code'];
    print(code);

    if (code.compareTo("1") != 0) {
      print(responseBody['errmsg']);
      Fluttertoast.showToast(
          msg: responseBody['errmsg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    Navigator.of(context).pop(
    );
  }

   _getOPMenu()  {
     if(_isMyPost){
       return _operationMenu();
     }else{
       return new Text("");
     }
  }
}
