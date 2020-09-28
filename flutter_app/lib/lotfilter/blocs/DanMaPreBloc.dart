import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaSource.dart';
import 'package:flutterapp/lotfilter/client/FilterAppService.dart';
import 'package:flutterapp/lotfilter/domain/DingDanMa.dart';
import 'package:flutterapp/lotfilter/domain/DingErMa.dart';
import 'package:flutterapp/lotfilter/domain/DingHewei.dart';
import 'package:flutterapp/lotfilter/domain/DingHezhi.dart';
import 'package:flutterapp/lotfilter/domain/DingKuadu.dart';
import 'package:flutterapp/lotfilter/domain/Duanzu.dart';
import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';
import 'package:flutterapp/lotfilter/domain/FuShi.dart';
import 'package:flutterapp/lotfilter/domain/ShaDanMa.dart';
import 'package:flutterapp/lotfilter/domain/ShaErMa.dart';
import 'package:flutterapp/lotfilter/domain/SiMa01.dart';
import 'package:flutterapp/lotfilter/domain/Utils.dart';

import '../../main.dart';
import 'DanMaPreEvent.dart';
import 'DanMaPreState.dart';
import 'DanPreUtils.dart';

class DanMaPreBloc extends Bloc<DanMaPreEvent, DanMaPreState> {
  final FilterAppService filterAppService = MyApp.provideFilterAppService();

  DanMaPreBloc(initialState) : super(initialState);

  @override
  Stream<DanMaPreState> mapEventToState(DanMaPreEvent event) async* {
    if (event is RongCuoChangedEvent) {
      yield DanMaPreState(
          state.preKaiJiangHaoController,
          state.resultController,
          state.danmaController,
          event.groupValue,
          state.simao1Controller,
          state.duanzuSourceController,
          state.dudan,
          state.danmaListController,
          state.sima01Checked,
          state.heweiController,
          state.kuaduController,
          state.hzController);
    } else if (event is SiMa01ChangedEvent) {
      yield DanMaPreState(
          state.preKaiJiangHaoController,
          state.resultController,
          state.danmaController,
          state.groupValue,
          state.simao1Controller,
          state.duanzuSourceController,
          state.dudan,
          state.danmaListController,
          event.checked,
          state.heweiController,
          state.kuaduController,
          state.hzController);
    } else if (event is DanMaPreEvent) {
      yield await _startPredicate();
    }
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

  String _getCountText(List<String> data) {
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

  String _getCountTextHezhi(List<String> data) {
    List<Map> countMap = [];
    Map<int, int> hezhiMap = {};

    data.forEach((element) {
      int sum = int.parse(Utils.getItemHezhi(element));
      print("hz:$element=$sum");

      if (hezhiMap[sum] != null) {
        hezhiMap[sum] += 1;
      } else {
        hezhiMap[sum] = 1;
      }
    });

    hezhiMap.forEach((key, value) {
      countMap.add({"id": key, "count": value});
    });

    countMap.sort((a, b) => b["count"].compareTo(a["count"]));

    print("res data sorted:" + countMap.toString());

    String ret = "";
    countMap.forEach((element) {
      ret += element["id"].toString() + ",";
    });

    return ret;
  }

  String _getCountTextHeWei(List<String> data) {
    List<Map> countMap = [];
    Map<int, int> hezhiMap = {};

    data.forEach((element) {
      int sum = int.parse(Utils.getItemHeWei(element));

      if (hezhiMap[sum] != null) {
        hezhiMap[sum] += 1;
      } else {
        hezhiMap[sum] = 1;
      }
    });

    hezhiMap.forEach((key, value) {
      countMap.add({"id": key, "count": value});
    });

    countMap.sort((a, b) => b["count"].compareTo(a["count"]));

    print("res data sorted:" + countMap.toString());

    String ret = "";
    countMap.forEach((element) {
      ret += element["id"].toString();
    });

    return ret;
  }

  String _getCountTextKuadu(List<String> data) {
    List<Map> countMap = [];
    Map<int, int> hezhiMap = {};

    data.forEach((element) {
      int sum = int.parse(Utils.getItemKuadu(element));

      if (hezhiMap[sum] != null) {
        hezhiMap[sum] += 1;
      } else {
        hezhiMap[sum] = 1;
      }
    });

    hezhiMap.forEach((key, value) {
      countMap.add({"id": key, "count": value});
    });

    countMap.sort((a, b) => b["count"].compareTo(a["count"]));

    print("res data sorted:" + countMap.toString());

    String ret = "";
    countMap.forEach((element) {
      ret += element["id"].toString();
    });

    return ret;
  }

  Future<DanMaPreState> _startPredicate() async {
   final String preKaiJiangHao = state.preKaiJiangHaoController.text;
    if (preKaiJiangHao == null || preKaiJiangHao.isEmpty) {
      return DanMaPreState(
          state.preKaiJiangHaoController,
          TextEditingController(text: "没有输入上期开奖号"),
          state.danmaController,
          state.groupValue,
          state.simao1Controller,
          state.duanzuSourceController,
          state.dudan,
          state.danmaListController,
          state.sima01Checked,
          state.heweiController,
          state.kuaduController,
          state.hzController);
    }

    String firstCountText = DanPreUtils.duanZuPre(preKaiJiangHao);

    String ret = firstCountText;
    String bsgePre = DanPreUtils.bsgePre(preKaiJiangHao);
    ret += "\n$bsgePre";

    var suoshui = "";

    List<String> sima01 = [];
    //sima01.add(SiMa01.getByDuiMa(preKaiJiangHao));//
    int ints = int.parse(preKaiJiangHao);

    sima01.add(SiMa01.get4HeadNumber((ints / 3.1415926).toString(),4)); //
    sima01.add(SiMa01.getByDivide0618(preKaiJiangHao));
    sima01.add(SiMa01.getByXueYinDuanzu(preKaiJiangHao));

    print("sima01:" + sima01.toString());

    //4码=01
    ///
    List<String> data = DanPreUtils.siMa01Result(preKaiJiangHao);
    String countText = _getCountText(data);
    String countTextKuadu = _getCountTextKuadu(data);
    String countHezhi = _getCountTextHezhi(data);
    String countHewei = _getCountTextHeWei(data);

    print("countHezhi:" + countHezhi);

    ret += "\n\n胆码***${countText}***";
    ret += "\n\n四码01条件：${sima01.toString()}";
    ret += "\n\n和值高到低排序：${countHezhi}";
    ret += "\n\n和尾高到低排序：${countHewei}";
    ret += "\n\n跨度高到低排序：${countTextKuadu}";
    ///////////////

    ///大底开始。
    ///
    data = DanPreUtils.getDadi2Wei(preKaiJiangHao);
    ///大底结束。
    ///
    ///
    ///其它输入条件过滤============================================================
    ///
    List<FilterCondition> conditons = [];
    conditons.clear();
    String danmaStr = state.danmaListController.text;
    if (danmaStr.isNotEmpty) {
      List<String> danmas = danmaStr.split("/");
      if (danmas.isNotEmpty) {
        danmas.forEach((element) {
          conditons.add(DingDanMa(Utils.danmaToList(element)));
        });
      }
    }
    var result = filterAppService.runFilter(data, conditons); /////////
    data = result.data;

    conditons.clear();
    String duanzuSource = state.duanzuSourceController.text;
    if (duanzuSource.isNotEmpty) {
      List<String> c = duanzuSource.split("*");
      if (c.isNotEmpty) {
        c.forEach((element) {
          List<String> ddd = element.split("/");
          if (ddd.length == 3) {
            conditons.add(Duanzu(Utils.danmaToList(ddd[0]),
                Utils.danmaToList(ddd[1]), Utils.danmaToList(ddd[2])));
          }
        });
      }
    }
    result = filterAppService.runFilter(data, conditons); ///////////
    data = result.data;

    ///
    conditons.clear();
    String heweiStr = state.heweiController.text;
    String kuaduStr = state.kuaduController.text;
    String hzStr = state.hzController.text;
    if (heweiStr.isNotEmpty) {
      conditons.add(DingHewei(Utils.danmaToList(heweiStr)));
    }
    if (kuaduStr.isNotEmpty) {
      conditons.add(DingKuadu(Utils.danmaToList(kuaduStr)));
    }
    if (hzStr.isNotEmpty) {
      conditons.add(DingHezhi(hzStr.split("/")));
    }

    if (conditons.isNotEmpty) {
      result = filterAppService.runFilter(data, conditons); ///////////
      data = result.data;
    }

    suoshui += "\n\n${data.toString()}";
    suoshui += "\n${data.length}注";

    // print("ret:$ret");

    return DanMaPreState(
        state.preKaiJiangHaoController,
        TextEditingController(text: suoshui),
        state.danmaController,
        state.groupValue,
        state.simao1Controller,
        state.duanzuSourceController,
        ret,
        state.danmaListController,
        state.sima01Checked,
        state.heweiController,
        state.kuaduController,
        state.hzController);
  }

  List<String> _getErMa(String numberstr) {
    List<String> shaermaCondition = []; //4567/4567

    for (int i = 0; i < numberstr.length; i++) {
      for (int j = 0; j < numberstr.length; j++) {
        shaermaCondition.add("${numberstr[i]}${numberstr[j]}");
      }
    }

    return shaermaCondition;
  }
}
