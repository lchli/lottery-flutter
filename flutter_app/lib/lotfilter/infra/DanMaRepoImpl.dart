import 'dart:core';

import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/domain/DanMaRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Pref.dart';

class DanMaRepoImpl extends DanMaRepo {
  @override
  Future<Result<List<KJDto>>> queryKaiJiangHao() async {
    Result<List<KJDto>> res = Result<List<KJDto>>();

    SharedPreferences sp = await Pref.prefs;
    String lottery_his = sp.getString("lottery_his");
    if (lottery_his == null || lottery_his.isEmpty) {
      return res;
    }
    List<KJDto> list = [];
    List<String> lines = lottery_his.split("\n");
    lines.forEach((element) {
      List<String> columns = element.split(" ");
      if(columns.length>=3) {
        var item = KJDto();
        item.qiHao = columns[0];
        item.kaiJiangHao = columns[2];
        list.add(item);
      }
    });

    res.data = list;

    return res;
  }

  @override
  Future<Result<List<KJDto>>> importHistory(String his) async {
    SharedPreferences sp = await Pref.prefs;
    sp.setString("lottery_his", his);
  }
}
