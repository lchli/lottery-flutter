import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/client/ApiUrl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MainPage.dart';
import '../Pref.dart';

class EditorPage extends StatefulWidget {
  final String _postId;
  EditorPage(this._postId);
  @override
  EditorPageState createState() => EditorPageState(_postId);
}

class EditorPageState extends State<EditorPage> {
  String _postId;
  EditorPageState(this._postId);

  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controllerTitle = new TextEditingController();


  @override
  void initState() {
    super.initState();

    if(_postId==null||_postId.isEmpty){
      return;
    }
    _getPostDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发帖"),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.save),
              onPressed: () => _saveDocument(context),
            ),
          )
        ],
      ),
      body:
      new Padding(padding:EdgeInsets.all(10),child:new Column(children:<Widget>[new TextField(
        controller: _controllerTitle,
        maxLines: 1,
        style:TextStyle(fontWeight: FontWeight.bold) ,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '输入标题',
        ),
      ),new Expanded(child: new TextField(
        controller: _controller,
        maxLines: 1000,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '输入内容'
        ),
      )),
      ]
    )));
  }


  void _saveDocument(BuildContext context) {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly:
    final contents = _controller.text;
    print(contents);

    _addPost(contents);
  }


  Future<void> _addPost(String content) async {
    Dio dio =  Dio();

    final SharedPreferences prefs = await Pref.prefs;
    String userId=prefs.getString("userId");
    String userToken=prefs.getString("userToken");

    FormData formData = new FormData.fromMap({
      "title": _controllerTitle.text,
      "url": content,
      "userId": userId,
      "token": userToken,
      "uid": _postId,
    });

    Response response = await dio.post(ApiUrl.add_post, data: formData);
    print(response);

    Map<String, dynamic> responseBody =await jsonDecode(response.toString());
    String code=responseBody['code'];
    print(code);

    if(code.compareTo("1")!=0){
      print(responseBody['errmsg']);
      Fluttertoast.showToast(
          msg: responseBody['errmsg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    Navigator.of(context).pop();
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


  Future<void> _getPostDetail() async {
    Dio dio = Dio();

    var formData = {
      "postId": _postId,
    };
    Response response = await dio.get(
        "http://192.168.111.227:8080/api/fav/queryPostDetail",
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
    _controllerTitle.text=responseBody['title'];
    _controller.text=responseBody['url'];
//    setState(() {
//      _document = responseBody['url'];
//      _title = responseBody['title'];
//    });
  }
}