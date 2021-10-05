import 'package:flutter/material.dart';
import 'package:flutterapp/user/MyPage.dart';
import 'package:flutterapp/ToolsPage.dart';
import 'package:flutterapp/post/WritePostPage.dart';
import 'lotfilter/ui/FilterPage.dart';
import 'lotfilter/ui/LotSettingPage.dart';
import 'lotfilter/ui/LotToolsPage.dart';
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
  int _currentIndex = 0;
  List<Widget> _pages = <Widget>[LotToolsPage(),LotSettingPage()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blueAccent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            currentIndex: _currentIndex,
            onTap: (value) {
              // Respond to item press.
              setState(() => _currentIndex = value);
            },
            items: [
              BottomNavigationBarItem(
                title: Text('功能'),
              icon: Icon(Icons.featured_play_list),
              ),
              BottomNavigationBarItem(
                title: Text('设置'),
                icon: Icon(Icons.settings),
              ),

            ],
          ),


          body: IndexedStack(
            index: _currentIndex,
            children: _pages,
          )
        ),
      ),
    );
  }




}
