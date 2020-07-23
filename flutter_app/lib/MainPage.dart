import 'package:flutter/material.dart';
import 'package:flutterapp/user/MyPage.dart';
import 'package:flutterapp/ToolsPage.dart';
import 'package:flutterapp/post/WritePostPage.dart';
import 'post/PostsPage.dart';
import 'user/register.dart';
import 'user/login.dart';
import 'package:english_words/english_words.dart';

class MainPage extends StatefulWidget {
  //open -a Simulator
  @override
  createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: '帖子'),
                Tab(text: '我的'),
              ],
            ),
            title: Text('3d彩票论坛'),
          ),
          body: TabBarView(
            children: [
              new PostsPage(),
              new MyPage(),
            ],
          ),

        ),
      ),
    );
  }


}
