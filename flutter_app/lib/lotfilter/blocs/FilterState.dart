import 'package:flutter/cupertino.dart';

class FilterState {
  TextEditingController controller;
  TextEditingController controllerHis;


  List<String> danmasChecked;
  List<String> shamasChecked;
  List<String> heweiChecked;
  List<String> kuaduChecked;
  List<String> dingErMaChecked;
  List<String> shaErMaChecked;

  List<String> duanzu1Checked;
  List<String> duanzu2Checked;

  List<String> duanzu3Checked;

  List<int> rongcuoChecked;
  bool isZu3Checked;

  bool isZu6Checked;

  bool isZZZChecked;

  FilterState(
      this.danmasChecked,
      this.shamasChecked,
      this.heweiChecked,
      this.kuaduChecked,
      this.dingErMaChecked,
      this.shaErMaChecked,
      this.duanzu1Checked,
      this.duanzu2Checked,
      this.duanzu3Checked,
      this.isZu3Checked,
      this.isZu6Checked,
      this.isZZZChecked,
      this.rongcuoChecked,
      this.controller,this.controllerHis);

  static FilterState newFilterState() {
    return FilterState([], [], [], [], [], [], [], [], [], true, true, true, [],
        new TextEditingController(),new TextEditingController());
  }

  FilterState clone() {
    return FilterState(
        danmasChecked,
        shamasChecked,
        heweiChecked,
        kuaduChecked,
        dingErMaChecked,
        shaErMaChecked,
        duanzu1Checked,
        duanzu2Checked,
        duanzu3Checked,
        isZu3Checked,
        isZu6Checked,
        isZZZChecked,
        rongcuoChecked,
        controller,controllerHis);
  }
}
