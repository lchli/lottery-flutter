import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaSource.dart';
import 'package:flutterapp/lotfilter/client/FilterAppService.dart';
import 'package:flutterapp/lotfilter/domain/DingDanMa.dart';
import 'package:flutterapp/lotfilter/domain/DingHewei.dart';
import 'package:flutterapp/lotfilter/domain/DingKuadu.dart';
import 'package:flutterapp/lotfilter/domain/Duanzu.dart';
import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';
import 'package:flutterapp/lotfilter/domain/ShaDanMa.dart';
import 'package:flutterapp/lotfilter/domain/ShaErMa.dart';
import 'package:flutterapp/lotfilter/domain/Utils.dart';

import '../../main.dart';
import 'DanMaPreEvent.dart';
import 'DanMaPreState.dart';

class DanMaPreBloc extends Bloc<DanMaPreEvent, DanMaPreState> {
  final FilterAppService filterAppService = MyApp.provideFilterAppService();

  DanMaPreBloc(initialState) : super(initialState);

  @override
  Stream<DanMaPreState> mapEventToState(DanMaPreEvent event) async* {
    if (event is RongCuoChangedEvent) {
      yield DanMaPreState(state.preKaiJiangHaoController, state.resultController,
          state.danmaController, event.groupValue, state.simao1Controller,state.duanzuSourceController,state.dudan,state.danmaListController);
    } else if (event is DanMaPreEvent) {
      yield await _startPredicate();
    }
  }


  Future<DanMaPreState> _startPredicate() async {
    String preKaiJiangHao = state.preKaiJiangHaoController.text;
    if (preKaiJiangHao == null || preKaiJiangHao.isEmpty) {
      return DanMaPreState(state.preKaiJiangHaoController, TextEditingController(text:"没有输入上期开奖号"),
          state.danmaController, state.groupValue, state.simao1Controller,state.duanzuSourceController,state.dudan,
      state.danmaListController);
    }
    List<String> danMaList = [];
    List<int> danMaListInt = [];

    for (int i = 0; i < preKaiJiangHao.length; i++) {
      danMaList.add(preKaiJiangHao[i]);
      danMaListInt.add(int.parse(preKaiJiangHao[i]));
    }

    //////
    int sum = int.parse(preKaiJiangHao[0]) * 4 +
        int.parse(preKaiJiangHao[1]) * 9 +
        int.parse(preKaiJiangHao[2]) * 9 +
        3;
    sum = sum % 10;

    int sum2 =
        int.parse(preKaiJiangHao[0]) * 5 + int.parse(preKaiJiangHao[1]) * 8 + 7;
    sum2 = sum2 % 10;
//
//    return DanMaPreState(state.preKaiJiangHaoController, "$sum($sum2)",
//        state.danmaController, state.groupValue);

    /////

    List<FilterCondition> conditons = [];

    String danmaText = state.danmaController.text;
    if (danmaText != null && danmaText.isNotEmpty) {
      conditons.add(DingDanMa(Utils.danmaToList(danmaText)));
    }

    List<String> d2 =
        List.of(danMaList).map((e) => (int.parse(e) + 1).toString()).toList();

    List<String> d3 = [];
    for (String e in DanMaSource.getDanMaSource()) {
      if (!danMaList.contains(e) && !d2.contains(e)) {
        d3.add(e);
      }
    }

    conditons.add(Duanzu(danMaList, d2, d3));

    String hewei = Utils.getItemHeWei(preKaiJiangHao);
    for (List<String> e in DanMaSource.x012) {
      if (e.contains(hewei)) {
        print(e);
        conditons.add(DingHeweiReverse(e));
        break;
      }
    }

    String kuadu = Utils.getItemKuadu(preKaiJiangHao);
    for (List<String> e in DanMaSource.x012) {
      if (e.contains(kuadu)) {
        print(e);
        conditons.add(DingKuaduReverse(e));
        break;
      }
    }

    final List<int> rongcuo = [];
    if (state.groupValue == DanMaPreState.rongcuo01) {
      rongcuo.add(0);
      rongcuo.add(1);
    } else if (state.groupValue == DanMaPreState.rongcuo12) {
      rongcuo.add(1);
      rongcuo.add(2);
    }

    Result<List<String>> result = await filterAppService.runRongCuoFilter(
        DanMaSource.getZuXuanSource(), conditons, rongcuo);

    List<String> data = result.data;

    // print("res data:" + data?.toString());


    String ret = _getCountText(data);

    ret += "\n$sum($sum2)";

    var suoshui="";


    String sima01 = state.simao1Controller.text;

    if (sima01.length > 0) {
      //4码=01
      var arr01 = sima01.split("/");
      print("arr01:$arr01");

      List<String> shaermaCondition = []; //4567/4567

      arr01.forEach((element) {
        for (int i = 0; i < element.length; i++) {
          for (int j = 0; j < element.length; j++) {
            shaermaCondition.add("${element[i]}${element[j]}");
          }
        }
      });

      print("shaermaCondition:$shaermaCondition");

      conditons.clear();
      conditons.add(ShaErMa(shaermaCondition));

     String duanzuSource= state.duanzuSourceController.text;
     if(duanzuSource.isNotEmpty){
       List<String> c=duanzuSource.split("*");
       if(c.isNotEmpty){
         c.forEach((element) {
          List<String> ddd= element.split("/");
          if(ddd.length==3){
            conditons.add(Duanzu(Utils.danmaToList(ddd[0]),Utils.danmaToList(ddd[1]),Utils.danmaToList(ddd[2])));
          }

         });
       }
     }

     String danmaStr=state.danmaListController.text;
     if(danmaStr.isNotEmpty){
       List<String> danmas=  danmaStr.split("/");
       if(danmas.isNotEmpty){
         danmas.forEach((element) {
           conditons.add(DingDanMa(Utils.danmaToList(element)));
         });
       }
     }

      Result<List<String>> result = await filterAppService.runFilter(
          List.of(DanMaSource.getZuXuanSource()), conditons);
      List<String> data = result.data;

      Result<List<String>> r = await filterAppService.nozu3(data);
      data = r.data;

      r = await filterAppService.nozzz(data);
      data = r.data;


      suoshui += "\n\n${data.toString()}";
      suoshui += "\n${data.length}注";

      ret += "\n\n${_getCountText(data)}";
    }

    print("ret:$ret");

    return DanMaPreState(state.preKaiJiangHaoController, TextEditingController(text: suoshui),
        state.danmaController, state.groupValue, state.simao1Controller,state.duanzuSourceController,ret,state.danmaListController);
  }

  int _count(List<String> filteredSource, String num) {
    int sum = 0;
    filteredSource.forEach((element) {
      if (element.contains(num)) {
        sum += 1;
      }
    });

    return sum;
  }

  String _getCountText(List<String>  data){
    List<Map> countMap = [];

    for (int i = 0; i < 10; i++) {
      countMap.add({"id": i, "count": _count(data, i.toString())});
    }
    countMap.sort((a, b) => b["count"].compareTo(a["count"]));

    print("res data sorted:" + countMap.toString());

    String ret = "";
    countMap.forEach((element) {
      ret += element["id"].toString();
    });

    return ret;
  }

}
