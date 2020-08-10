import 'package:flutter/cupertino.dart';

class DanMaPreState{
  static const String rongcuo01="容错01";
  static const String rongcuo12="容错12";

  TextEditingController preKaiJiangHaoController;
  TextEditingController simao1Controller;
  TextEditingController danmaController;
  TextEditingController duanzuSourceController;
  TextEditingController danmaListController;
  TextEditingController resultController;
  String groupValue;
  String dudan;

  DanMaPreState(this.preKaiJiangHaoController, this.resultController,
      this.danmaController,this.groupValue,this.simao1Controller,this.duanzuSourceController,this.dudan,this.danmaListController);
}