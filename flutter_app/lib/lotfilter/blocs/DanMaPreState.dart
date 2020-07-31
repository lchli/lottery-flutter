import 'package:flutter/cupertino.dart';

class DanMaPreState{
  static const String rongcuo01="容错01";
  static const String rongcuo12="容错12";

  TextEditingController preKaiJiangHaoController;
  TextEditingController danmaController;
  String result;
  String groupValue;

  DanMaPreState(this.preKaiJiangHaoController, this.result,this.danmaController,this.groupValue);
}