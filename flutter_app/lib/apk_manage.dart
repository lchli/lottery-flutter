import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/lotfilter/DanMaPre1Controller.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';

import 'ApkController.dart';


class ApkManage extends   GetView<ApkController>{


  @override
  Widget build(BuildContext context) {

    return Obx(()=>Center(child: Text(controller.list()),));
  }

}


class _ApkManageState extends State{
  final apkName=TextEditingController();
  final apkVersion=TextEditingController();
  final userName=TextEditingController();
  final userPwd=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('apk管理'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          TextField(controller: apkName),
          TextField(controller: apkVersion),
          TextField(controller: userName),
          TextField(controller: userPwd),

          ListTile(
            enableFeedback: true,
            title: Text('apk上传'),
            leading: Icon(Icons.update),
            onTap: (){

            },
          ),
        ],
      ),
    );
  }

}


