import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LotSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.only(top: 50) ,child:Column(children: [
      Row(
        children: [
          Card(
            child: Column(
              children: [
                Text("setting"),
                Icon(Icons.arrow_drop_down_circle),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Text("setting"),
                Icon(Icons.arrow_drop_down_circle),
              ],
            ),
          ),
        ],
      )
    ]));
  }
}
