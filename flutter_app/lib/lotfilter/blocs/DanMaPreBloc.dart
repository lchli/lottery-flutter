import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaSource.dart';
import 'package:flutterapp/lotfilter/client/FilterAppService.dart';
import 'package:flutterapp/lotfilter/domain/DingDanMa.dart';
import 'package:flutterapp/lotfilter/domain/DingErMa.dart';
import 'package:flutterapp/lotfilter/domain/DingHewei.dart';
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
          state.kuaduController);
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
          state.kuaduController);
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
    String preKaiJiangHao = state.preKaiJiangHaoController.text;
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
          state.kuaduController);
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
    String firstCountText = _getCountText(data);

    String ret = firstCountText;

    ret += "\n$sum($sum2)";

    var suoshui = "";

    List<String> sima01 = [];
    //sima01.add(SiMa01.getByDuiMa(preKaiJiangHao));//
    int ints = int.parse(preKaiJiangHao);

    if (state.sima01Checked) {
      sima01.add(SiMa01.get4HeadNumber((ints / 3.1415926).toString())); //
      sima01.add(SiMa01.getByDivide0618(preKaiJiangHao));
      sima01.add(SiMa01.getByXueYinDuanzu(preKaiJiangHao));
    }

    List<String> sima01Reverse = [];
    sima01.forEach((element) {
      String e = "";
      DanMaSource.getDanMaSource().forEach((d) {
        if (!element.contains(d)) {
          e += d;
        }
      });

      sima01Reverse.add(e);
    });

    print("sima01Reverse:" + sima01Reverse.toString());

    String sima01Input = state.simao1Controller.text;
    if (sima01Input.length > 0) {
      List<String> arr01 = sima01Input.split("/");
      if (arr01.isNotEmpty) {
        sima01.addAll(arr01);
      }
    }

    print("sima01:" + sima01.toString());
    conditons.clear();
    String countText = "";
    String countTextKuadu = "";

    if (sima01.length > 0) {
      //4码=01

      sima01.forEach((element) {
        List<String> shaermaCondition = []; //4567/4567

        for (int i = 0; i < element.length; i++) {
          for (int j = 0; j < element.length; j++) {
            shaermaCondition.add("${element[i]}${element[j]}");
          }
        }

        conditons.add(DingErMa(shaermaCondition));
      });

      Result<List<String>> result = await filterAppService.runRongCuoFilter(
          List.of(DanMaSource.getZuXuanSource()), conditons, [2, 3]);

      ///
      List<String> data = result.data;

      conditons.clear();
      sima01Reverse.forEach((element) {
        conditons.add(DingDanMa(Utils.danmaToList(element)));
      });
      result = await filterAppService.runFilter(data, conditons);
      data = result.data;

      ///

      conditons.clear();
      sima01.forEach((element) {
        conditons.add(DingDanMa(Utils.danmaToList(element)));
      });
      result =
          await filterAppService.runRongCuoFilter(data, conditons, [0, 1, 2]);
      data = result.data;

      ///

      countText = _getCountText(data);
      countTextKuadu = _getCountTextKuadu(data);

      ret += "\n\n胆码***${countText}***";
      ret += "\n\n四码01条件：${sima01.toString()}";
      ret += "\n\n和值高到低排序：${_getCountTextHezhi(data)}";
      ret += "\n\n和尾高到低排序：${_getCountTextHeWei(data)}";
      ret += "\n\n跨度高到低排序：${countTextKuadu}";
    } ///////////////

    ///大底开始。
    conditons.clear();
    conditons.add(FuShi([
      countText[1],
      countText[2],
      countText[3],
      countText[4],
      countText[9],
      countText[8]
    ]));
    conditons.add(FuShi([
      countText[1],
      countText[2],
      countText[3],
      countText[4],
      countText[5],
      countText[6]
    ]));
    conditons.add(FuShi([
      countText[4],
      countText[5],
      countText[6],
      countText[7],
      countText[8],
      countText[9]
    ]));

    result = await filterAppService.runRongCuoFilter(
        DanMaSource.getZuXuanSource(), conditons, [0, 1, 2]); /////////[0, 1, 2]
    data = result.data;

    conditons.clear();
    conditons.add(DingDanMa([countText[1]]));
    result = await filterAppService.runFilter(data, conditons); /////////复试结果。
    data = result.data;
    List<String> res1 = data;

    conditons.clear();
    conditons.add(DingDanMa([countText[0]]));
    result = await filterAppService.runFilter(
        DanMaSource.getZuXuanSource(), conditons); /////////独胆结果。
    data = result.data;

    //union与复试的结果合并。
    data.forEach((element) {
      if (!res1.contains(element)) {
        res1.add(element);
      }
    });

    data = res1;

    ///大底结束。

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
    result = await filterAppService.runFilter(data, conditons); /////////
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
    result = await filterAppService.runFilter(data, conditons); ///////////
    data = result.data;

    result = await filterAppService.nozu3(data); ////////
    data = result.data;

    result = await filterAppService.nozzz(data); ///////
    data = result.data;

    ///226断组容错过滤。
    conditons.clear();
    conditons.add(Duanzu([
      firstCountText[0],
      firstCountText[1]
    ], [
      firstCountText[2],
      firstCountText[3]
    ], [
      firstCountText[4],
      firstCountText[5],
      firstCountText[6],
      firstCountText[7],
      firstCountText[8],
      firstCountText[9]
    ]));

    conditons.add(Duanzu([
      firstCountText[0],
      firstCountText[1]
    ], [
      firstCountText[8],
      firstCountText[9]
    ], [
      firstCountText[4],
      firstCountText[5],
      firstCountText[6],
      firstCountText[7],
      firstCountText[2],
      firstCountText[3]
    ]));

    conditons.add(Duanzu([
      firstCountText[7],
      firstCountText[6]
    ], [
      firstCountText[8],
      firstCountText[9]
    ], [
      firstCountText[4],
      firstCountText[5],
      firstCountText[0],
      firstCountText[1],
      firstCountText[2],
      firstCountText[3]
    ]));

    result = await filterAppService
        .runRongCuoFilter(data, conditons, [0, 1]); ///////////
    data = result.data;

    ///
    ///
    conditons.clear();
    String heweiStr = state.heweiController.text;
    String kuaduStr = state.kuaduController.text;
    if (heweiStr.isNotEmpty) {
      conditons.add(DingHewei(Utils.danmaToList(heweiStr)));
    }
    if (kuaduStr.isNotEmpty) {
      conditons.add(DingKuadu(Utils.danmaToList(kuaduStr)));
    }
    if (conditons.isNotEmpty) {
      result = await filterAppService.runFilter(data, conditons); ///////////
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
        state.kuaduController);
  }
}
