import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/client/FilterAppService.dart';
import 'package:flutterapp/lotfilter/domain/DingDanMa.dart';
import 'package:flutterapp/lotfilter/domain/DingErMa.dart';
import 'package:flutterapp/lotfilter/domain/DingHewei.dart';
import 'package:flutterapp/lotfilter/domain/DingKuadu.dart';
import 'package:flutterapp/lotfilter/domain/Duanzu.dart';
import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';
import 'package:flutterapp/lotfilter/domain/ShaDanMa.dart';
import 'package:flutterapp/lotfilter/domain/ShaErMa.dart';
import 'package:flutterapp/lotfilter/ui/ChooseDanMaPage.dart';

import '../../main.dart';
import 'DanMaSource.dart';

class FilterVM extends ChangeNotifier {
  final List<String> danmas = DanMaSource.getDanMaSource();
  final List<String> ermas = DanMaSource.getErMaSource();
  final FilterAppService filterAppService = MyApp.provideFilterAppService();
  final List<String> danmasChecked = [];
  final List<String> shamaChecked = [];
  final List<String> heweiChecked = [];
  final List<String> kuaduChecked = [];
  final List<String> dingErMaChecked = [];
  final List<String> shaErMaChecked = [];

  final List<String> duanzu1Checked = [];
  final List<String> duanzu2Checked = [];
  final List<String> duanzu3Checked = [];

  final List<int> rongcuoChecked = [];
  bool isZu3Checked = true;
  bool isZu6Checked = true;
  bool isZZZChecked = true;

  TextEditingController controller = new TextEditingController();

  List<String> filteredSource = [];

  int getConditionCount() {
    int ct = 0;
    if (danmasChecked.isNotEmpty) {
      ct += 1;
    }
    if (shamaChecked.isNotEmpty) {
      ct += 1;
    }
    if (heweiChecked.isNotEmpty) {
      ct += 1;
    }
    if (kuaduChecked.isNotEmpty) {
      ct += 1;
    }
    if (dingErMaChecked.isNotEmpty) {
      ct += 1;
    }
    if (shaErMaChecked.isNotEmpty) {
      ct += 1;
    }

    if (duanzu1Checked.isNotEmpty &&
        duanzu2Checked.isNotEmpty &&
        duanzu3Checked.isNotEmpty) {
      ct += 1;
    }

    return ct;
  }

  String getFilterResultString() {
    if (filteredSource.isNotEmpty) {
      return filteredSource.toString() + "\n(${filteredSource.length}注)";
    }
    return "点击开始缩水";
  }

  String getDanMaCheckedString() {
    if (danmasChecked.isNotEmpty) {
      return danmasChecked.toString();
    }
    return "点击选择";
  }

  String getShaMaCheckedString() {
    if (shamaChecked.isNotEmpty) {
      return shamaChecked.toString();
    }
    return "点击选择";
  }

  String getHeweiCheckedString() {
    if (heweiChecked.isNotEmpty) {
      return heweiChecked.toString();
    }
    return "点击选择";
  }

  String getKuduCheckedString() {
    if (kuaduChecked.isNotEmpty) {
      return kuaduChecked.toString();
    }
    return "点击选择";
  }

  String getDingErMaCheckedString() {
    if (dingErMaChecked.isNotEmpty) {
      return dingErMaChecked.toString();
    }
    return "点击选择";
  }

  String getShaErMaCheckedString() {
    if (shaErMaChecked.isNotEmpty) {
      return shaErMaChecked.toString();
    }
    return "点击选择";
  }

  String getDuanzu1CheckedString() {
    if (duanzu1Checked.isNotEmpty) {
      return duanzu1Checked.toString();
    }
    return "点击选择";
  }

  String getDuanzu2CheckedString() {
    if (duanzu2Checked.isNotEmpty) {
      return duanzu2Checked.toString();
    }
    return "点击选择";
  }

  String getDuanzu3CheckedString() {
    if (duanzu3Checked.isNotEmpty) {
      return duanzu3Checked.toString();
    }
    return "点击选择";
  }

  void clearDanMaChecked() {
    danmasChecked.clear();

    notifyListeners();
  }

  void clearShaMaChecked() {
    shamaChecked.clear();

    notifyListeners();
  }

  void clearRongCuoChecked() {
    rongcuoChecked.clear();

    notifyListeners();
  }

  void clearShaErMaChecked() {
    shaErMaChecked.clear();

    notifyListeners();
  }

  void resetFilteredSource() {
    filteredSource.clear();
    controller.text = getFilterResultString();
  }

  void addToDanMaChecked(int index) {
    if (!danmasChecked.contains(danmas[index])) {
      danmasChecked.add(danmas[index]);

      notifyListeners();
    }
  }

  void addToShaMaChecked(int index) {
    if (!shamaChecked.contains(danmas[index])) {
      shamaChecked.add(danmas[index]);

      notifyListeners();
    }
  }

  void removeFromDanMaChecked(int index) {
    danmasChecked.remove(danmas[index]);
    notifyListeners();
  }

  void removeFromShaMaChecked(int index) {
    shamaChecked.remove(danmas[index]);
    notifyListeners();
  }

  showChooseDanMa(BuildContext context, int requestCode) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new ChooseDanMaPage(requestCode);
        },
      ),
    );
  }

  String formatMa(List<String> input) {
    if (input == null || input.isEmpty) {
      return null;
    }
    String ret = "";
    input.forEach((element) {
      ret += element;
    });

    return ret;
  }

  void startFilter() async {
    List<FilterCondition> conditons = [];
    String dan = formatMa(danmasChecked);
    print(dan);
    if (dan != null && dan.isNotEmpty) {
      conditons.add(DingDanMa(dan));
    }

    String sha = formatMa(shamaChecked);
    print(sha);
    if (sha != null && sha.isNotEmpty) {
      conditons.add(ShaDanMa(sha));
    }

    String hewei = formatMa(heweiChecked);
    print(hewei);
    if (hewei != null && hewei.isNotEmpty) {
      conditons.add(DingHewei(hewei));
    }

    String kuadu = formatMa(kuaduChecked);
    print(kuadu);
    if (kuadu != null && kuadu.isNotEmpty) {
      conditons.add(DingKuadu(kuadu));
    }

    if (dingErMaChecked != null && dingErMaChecked.isNotEmpty) {
      conditons.add(DingErMa(dingErMaChecked));
    }

    if (shaErMaChecked != null && shaErMaChecked.isNotEmpty) {
      conditons.add(ShaErMa(shaErMaChecked));
    }

    if (duanzu1Checked.isNotEmpty &&
        duanzu2Checked.isNotEmpty &&
        duanzu3Checked.isNotEmpty) {
      conditons.add(Duanzu(duanzu1Checked, duanzu2Checked, duanzu3Checked));
    }

    print(rongcuoChecked.toString());

    Result<List<String>> result;
    if (rongcuoChecked.isEmpty) {
      result = await filterAppService.runFilter(
          List.of(DanMaSource.getZuXuanSource()), conditons);
    } else {
      result = await filterAppService.runRongCuoFilter(
          List.of(DanMaSource.getZuXuanSource()), conditons, rongcuoChecked);
    }
    List<String> data = result.data;

    if (!isZu3Checked) {
      Result<List<String>> r = await filterAppService.nozu3(data);
      data = r.data;
    }

    if (!isZu6Checked) {
      Result<List<String>> r = await filterAppService.nozu6(data);
      data = r.data;
    }
    if (!isZZZChecked) {
      Result<List<String>> r = await filterAppService.nozzz(data);
      data = r.data;
    }

    filteredSource = data;
    controller.text = getFilterResultString();

    //print(filteredSource);

    notifyListeners();
  }

  void addToHeweiChecked(int index) {
    if (!heweiChecked.contains(danmas[index])) {
      heweiChecked.add(danmas[index]);

      notifyListeners();
    }
  }

  void removeFromHeweiChecked(int index) {
    heweiChecked.remove(danmas[index]);
    notifyListeners();
  }

  void addToKuaduChecked(int index) {
    if (!kuaduChecked.contains(danmas[index])) {
      kuaduChecked.add(danmas[index]);

      notifyListeners();
    }
  }

  void removeFromKuaduChecked(int index) {
    kuaduChecked.remove(danmas[index]);
    notifyListeners();
  }

  void clearHeweiChecked() {
    heweiChecked.clear();
    notifyListeners();
  }

  void clearKuaduChecked() {
    kuaduChecked.clear();
    notifyListeners();
  }

  void addToDingErMaChecked(int index) {
    if (!dingErMaChecked.contains(ermas[index])) {
      dingErMaChecked.add(ermas[index]);

      notifyListeners();
    }
  }

  void removeFromDingErMaChecked(int index) {
    dingErMaChecked.remove(ermas[index]);
    notifyListeners();
  }

  void clearDingErMaChecked() {
    dingErMaChecked.clear();
    notifyListeners();
  }

  void addToShaErMaChecked(int index) {
    if (!shaErMaChecked.contains(ermas[index])) {
      shaErMaChecked.add(ermas[index]);

      notifyListeners();
    }
  }

  void removeFromShaErMaChecked(int index) {
    shaErMaChecked.remove(ermas[index]);
    notifyListeners();
  }

  void addRongCuo(int index) {
    rongcuoChecked.add(index);
    notifyListeners();
  }

  void removeRongCuo(int index) {
    rongcuoChecked.remove(index);
    notifyListeners();
  }

  setZu6(bool v) {
    isZu6Checked = v;

    notifyListeners();
  }

  setZu3(bool v) {
    isZu3Checked = v;

    notifyListeners();
  }

  setZZZ(bool v) {
    isZZZChecked = v;

    notifyListeners();
  }

  void addToDuanzu1Checked(int index) {
    if (!duanzu1Checked.contains(danmas[index])) {
      duanzu1Checked.add(danmas[index]);

      notifyListeners();
    }
  }

  void addToDuanzu2Checked(int index) {
    if (!duanzu2Checked.contains(danmas[index])) {
      duanzu2Checked.add(danmas[index]);

      notifyListeners();
    }
  }

  void addToDuanzu3Checked(int index) {
    if (!duanzu3Checked.contains(danmas[index])) {
      duanzu3Checked.add(danmas[index]);

      notifyListeners();
    }
  }

  void removeFromDuanzu1Checked(int index) {
    duanzu1Checked.remove(danmas[index]);
    notifyListeners();
  }

  void removeFromDuanzu2Checked(int index) {
    duanzu2Checked.remove(danmas[index]);
    notifyListeners();
  }

  void removeFromDuanzu3Checked(int index) {
    duanzu3Checked.remove(danmas[index]);
    notifyListeners();
  }

  void clearDuanzu1Checked() {
    duanzu1Checked.clear();
    notifyListeners();
  }

  void clearDuanzu2Checked() {
    duanzu2Checked.clear();
    notifyListeners();
  }

  void clearDuanzu3Checked() {
    duanzu3Checked.clear();
    notifyListeners();
  }
}
