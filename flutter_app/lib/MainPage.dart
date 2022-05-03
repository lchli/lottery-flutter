import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'apk_manage.dart';
import 'lotfilter/MainPageController.dart';
import 'lotfilter/ui/LotSettingPage.dart';
import 'lotfilter/ui/LotToolsPage.dart';

class MainPage extends GetView<MainPageController> {
  final _pages = <Widget>[LotToolsPage(), ApkManage()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Obx(() => Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blueAccent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            currentIndex: controller.currentIndex(),
            onTap: (value) {
              controller.setIndex(value);
            },
            items: [
              BottomNavigationBarItem(
                label:'功能',
                icon: Icon(Icons.featured_play_list),
              ),
              BottomNavigationBarItem(
                label: '文件解压',
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          body: IndexedStack(
            index: controller.currentIndex(),
            children: _pages,
          ))),
    );
  }
}
