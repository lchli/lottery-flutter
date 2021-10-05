
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DanMaPre1.dart';

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
                            Text("胆码预测一"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Icon(Icons.arrow_drop_down_circle),
                            Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ),
                      onTap: () {})),
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
                            Text("大底推荐"),
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

                        _gotoMain(context);
                      })),
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
                      onTap: () {})),
            ],
          )
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
