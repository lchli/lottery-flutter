import 'dart:core';

import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/domain/DanMaRepo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Pref.dart';

class DanMaRepoImpl extends   GetConnect with DanMaRepo{


  Future<Response> getUser() => get('https://github.com/lchli/lottery-flutter/raw/master/flutter_app/raw/lot.txt');

  @override
  Future<Result<List<KJDto>>> queryKaiJiangHao() async {
    var r=await getUser();
    print(r.body);
    Result<List<KJDto>> res = Result<List<KJDto>>();

    SharedPreferences sp = await Pref.prefs;
    String lotteryHis = sp.getString("lottery_his");
    print("lotteryHis:"+lotteryHis);
    if (lotteryHis == null || lotteryHis.isEmpty) {
      return res;
    }
    List<KJDto> list = [];
    List<String> lines = lotteryHis.split("\n");
    lines.forEach((element) {
      if(element!=null&&element.isNotEmpty) {
        List<String> columns = element.split(" ");
        if (columns.length >= 3) {
          var item = KJDto();
          item.qiHao = columns[0];
          item.kaiJiangHao = columns[2];
          list.add(item);
        }
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
