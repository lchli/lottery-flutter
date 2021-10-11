import 'package:flutter/material.dart';
import 'package:flutterapp/user/MyPage.dart';
import 'package:flutterapp/ToolsPage.dart';
import 'package:flutterapp/post/WritePostPage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'lotfilter/DanMaPre1Controller.dart';
import 'lotfilter/infra/DanMaRepoImpl.dart';
import 'lotfilter/ui/FilterPage.dart';
import 'lotfilter/ui/LotSettingPage.dart';
import 'lotfilter/ui/LotToolsPage.dart';
import 'post/PostsPage.dart';
import 'user/register.dart';
import 'user/login.dart';
import 'package:english_words/english_words.dart';

class MainPage extends StatelessWidget {
  //int _currentIndex = 0;
  List<Widget> _pages = <Widget>[LotToolsPage(),LotSettingPage()];
  @override
  Widget build(BuildContext context) {
    final DanMaPre1Controller c = Get.put(DanMaPre1Controller(DanMaRepoImpl()));

    return DefaultTabController(
      length: 2,
      child: Obx(()=>Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blueAccent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            currentIndex: c.currentIndex.value,
            onTap: (value) {
              // Respond to item press.
             // setState(() => _currentIndex = value);
              c.currentIndex.value=value;
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
            index: c.currentIndex.value,
            children: _pages,
          )
      )),
    );

  }







}
