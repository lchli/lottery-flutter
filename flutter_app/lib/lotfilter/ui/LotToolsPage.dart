
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../DanMaPre1.dart';
import '../Routes.dart';

class LotToolsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("缩水"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Icon(Icons.arrow_drop_down_circle),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ),
                      onTap: () {
                        final snackBar =
                            SnackBar(content: Text('Yay! A SnackBar!'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      })),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("大底推荐"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Icon(Icons.arrow_drop_down_circle),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ),
                      onTap: () {

                      })),

            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("胆码预测一"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Icon(Icons.arrow_drop_down_circle),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.danma_pre);
                      })),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("胆码预测二"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Icon(Icons.arrow_drop_down_circle),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.danma_pre2);
                      })),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("胆码预测三"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Icon(Icons.arrow_drop_down_circle),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.danma_pre3);
                      })),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("和尾预测"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Icon(Icons.arrow_drop_down_circle),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.hewei_pre);
                      })),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("跨度预测"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Icon(Icons.arrow_drop_down_circle),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.kuadu_pre);
                      })),

            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("广告开关"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Icon(Icons.arrow_drop_down_circle),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.danma_pre3);
                      })),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("apk管理"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Icon(Icons.arrow_drop_down_circle),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.hewei_pre);
                      })),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      child: Card(
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("协议管理"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Icon(Icons.arrow_drop_down_circle),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.danma_pre3);
                      })),

            ],
          ),
        ]));
  }

  void _gotoMain(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (context) {
        return new DanMaPre1();
      },
    ));
  }


}
