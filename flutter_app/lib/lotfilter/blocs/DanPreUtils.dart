import 'package:flutterapp/client/ResultDto.dart';
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
import 'package:flutterapp/main.dart';

import 'DanMaSource.dart';

class DanPreUtils {
  static final FilterAppService filterAppService =
      MyApp.provideFilterAppService();

  static String siMa01Pre(String preKaiJiangHao) {
    List<String> data = siMa01Result(preKaiJiangHao);
    return _getCountText(data);
  }

  static String siMa01PreHewei(String preKaiJiangHao) {
    List<String> data = siMa01Result(preKaiJiangHao);
    return _getCountTextHeWei(data);
  }

  static String siMa01PreKuadu(String preKaiJiangHao) {
    List<String> data = siMa01Result(preKaiJiangHao);
    return _getCountTextKuadu(data);
  }

  static String duanZuPre(String preKaiJiangHao) {
    List<String> data = duanZuResult(preKaiJiangHao);
    return _getCountText(data);
  }

  static String bsgePre(String preKaiJiangHao) {
    try {
      int sum = int.parse(preKaiJiangHao[0]) * 4 +
          int.parse(preKaiJiangHao[1]) * 9 +
          int.parse(preKaiJiangHao[2]) * 9 +
          3;
      sum = sum % 10;

      int sum2 = int.parse(preKaiJiangHao[0]) * 5 +
          int.parse(preKaiJiangHao[1]) * 8 +
          7;
      sum2 = sum2 % 10;

      if (sum2 == sum) {
        sum2 = sum + sum;
      }

      return "$sum$sum2";
    } catch (Exception) {
      return "-1-1";
    }
  }

  static List<String> sima01Number(String preKaiJiangHao) {
    List<String> sima01 = [];
    int ints = int.parse(preKaiJiangHao);

    sima01.add(SiMa01.get4HeadNumber((ints / 3.1415926).toString(),4)); //
    sima01.add(SiMa01.getByDivide0618(preKaiJiangHao));
    sima01.add(SiMa01.getByXueYinDuanzu(preKaiJiangHao));
    return sima01;
  }

  static String getLeftNumber(String input){
    String left="";
    for(int i=0;i<DanMaSource.getDanMaSource().length;i++){
      if(!input.contains(DanMaSource.getDanMaSource()[i])){
        left+=DanMaSource.getDanMaSource()[i];
      }
    }

    return left;
  }


  static List<String> siMa01Result(String preKaiJiangHao) {
    try {
      List<String> sima01 = sima01Number(preKaiJiangHao);

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

      List<FilterCondition> conditons = [];
      //4码=01
      sima01.forEach((element) {
        conditons.add(DingErMa(_getErMa(element)));
      });

      Result<List<String>> result = filterAppService.runRongCuoFilter(
          List.of(DanMaSource.getZuXuanSource()),
          conditons,
          [1, 2, 3]); //[2, 3]

      ///
      List<String> data = result.data;

      conditons.clear();
      sima01Reverse.forEach((element) {
        conditons.add(DingDanMa(Utils.danmaToList(element)));
      });
      result = filterAppService.runFilter(data, conditons);
      data = result.data;

      ///

      conditons.clear();
      sima01.forEach((element) {
        conditons.add(DingDanMa(Utils.danmaToList(element)));
      });
      result = filterAppService.runRongCuoFilter(data, conditons, [0, 1, 2]);
      data = result.data;

      return data;
    } catch (Exception) {
      return [];
    }
  }

  static List<String> _getErMa(String numberstr) {
    List<String> shaermaCondition = []; //4567/4567

    for (int i = 0; i < numberstr.length; i++) {
      for (int j = 0; j < numberstr.length; j++) {
        shaermaCondition.add("${numberstr[i]}${numberstr[j]}");
      }
    }

    return shaermaCondition;
  }

  static String _getCountText(List<String> data) {
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

  static int _count(List<String> filteredSource, String num) {
    int sum = 0;
    filteredSource.forEach((element) {
      if (element.contains(num)) {
        sum += 1;
      }
    });

    return sum;
  }

  static List<String> duanZuResult(String preKaiJiangHao) {
    List<FilterCondition> conditons = [];

    List<String> danMaList = Utils.danmaToList(preKaiJiangHao);

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
    rongcuo.add(0);
    rongcuo.add(1);

    Result<List<String>> result = filterAppService.runRongCuoFilter(
        DanMaSource.getZuXuanSource(), conditons, rongcuo);

    List<String> data = result.data;
    return data;
  }

  static String _getCountTextHeWei(List<String> data) {
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

  static String _getCountTextKuadu(List<String> data) {
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

  static String _getCountTextHezhi(List<String> data) {
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

  static List<String> getDaDiResult(String preKaiJiangHao) {
    // String firstCountText = DanPreUtils.duanZuPre(preKaiJiangHao);
    List<String> data = DanPreUtils.siMa01Result(preKaiJiangHao);
    String countText = _getCountText(data);
//    String countTextKuadu = _getCountTextKuadu(data);
//    String countHezhi = _getCountTextHezhi(data);
    String countHewei = _getCountTextHeWei(data);

    ///大底开始。
    ///
    List<FilterCondition> conditons = [];
    conditons.clear();
    conditons.add(DingDanMa([countText[0]]));
    // conditons.add(DingHewei([countHewei[0], countHewei[1], countHewei[2]]));
    Result<List<String>> result =
        filterAppService.runFilter(DanMaSource.getZuXuanSource(), conditons);
    data = result.data;

    ///去掉组三豹子。
    result = filterAppService.nozu3(data); ////////
    data = result.data;

    result = filterAppService.nozzz(data); ///////
    data = result.data;

    return data;
  }

  static List<String> getDaDiResultByKuadu(String preKaiJiangHao) {
    // String firstCountText = DanPreUtils.duanZuPre(preKaiJiangHao);
    List<String> data = DanPreUtils.siMa01Result(preKaiJiangHao);
    String countText = _getCountText(data);
    String countTextKuadu = _getCountTextKuadu(data);
//    String countHezhi = _getCountTextHezhi(data);
    // String countHewei = _getCountTextHeWei(data);
    ///大底开始。
    ///
    List<FilterCondition> conditons = [];
    conditons.clear();
    conditons.add(DingDanMa([countText[0], countText[1]]));
    //conditons.add(DingKuadu([countTextKuadu[2], countTextKuadu[3]]));
    Result<List<String>> result =
        filterAppService.runFilter(DanMaSource.getZuXuanSource(), conditons);
    data = result.data;

    ///去掉组三豹子。
    result = filterAppService.nozu3(data); ////////
    data = result.data;

    result = filterAppService.nozzz(data); ///////
    data = result.data;

    return data;
  }

  static List<String> getDaDi(String preKaiJiangHao) {
    // String firstCountText = DanPreUtils.duanZuPre(preKaiJiangHao);
    List<String> data = DanPreUtils.siMa01Result(preKaiJiangHao);
    String countText = _getCountText(data);
//    String countTextKuadu = _getCountTextKuadu(data);
//    String countHezhi = _getCountTextHezhi(data);
    // String countHewei = _getCountTextHeWei(data);
    ///大底开始。
    ///
    List<FilterCondition> conditons = [];
    conditons.clear();
    conditons.add(DingDanMa([countText[0], countText[1]]));
    Result<List<String>> result =
        filterAppService.runFilter(DanMaSource.getZuXuanSource(), conditons);
    data = result.data;

    ///去掉组三豹子。
    result = filterAppService.nozu3(data); ////////
    data = result.data;

    result = filterAppService.nozzz(data); ///////
    data = result.data;

    return data;
  }

  static List<String> getDadi2Wei(String preKaiJiangHao) {
     //return getDadiPreLast(preKaiJiangHao);

    List<String> data = DanPreUtils.siMa01Result(preKaiJiangHao);
    String bs = DanPreUtils.bsgePre(preKaiJiangHao);
    String duanzupre = DanPreUtils.duanZuPre(preKaiJiangHao);
    String countText = _getCountText(data);
    String countTextKuadu = _getCountTextKuadu(data);
    String countHezhi = _getCountTextHezhi(data);
    var hzarr = countHezhi.split(",");
    String countHewei = _getCountTextHeWei(data);

    ///大底开始。
    ///
    List<FilterCondition> conditons = [];

    print("hz:" + countHezhi);

    conditons.clear();
    // conditons.add(DingDanMa([countText[0],countText[1],countText[2],countText[9]]));
    //conditons.add(DingDanMa([bs[0],bs[1]]));
    // conditons.add(DingDanMa([duanzupre[0],duanzupre[9]]));
    // conditons.add(DingKuadu([countTextKuadu[0],countTextKuadu[1]]));
    //conditons.add(DingKuadu([countTextKuadu[0],countTextKuadu[1],countTextKuadu[2]]));
    Result<List<String>> result =
        filterAppService.runFilter(DanMaSource.getZuXuanSource(), conditons);
    data = result.data;

    ///去掉组三豹子。
    result = filterAppService.nozu3(data); ////////
    data = result.data;

    result = filterAppService.nozzz(data); ///////
    data = result.data;

    return data;
  }

  static List<String> getDadiPreLast(String preKaiJiangHao) {
    List<String> data = DanPreUtils.siMa01Result(preKaiJiangHao);
    String bs = DanPreUtils.bsgePre(preKaiJiangHao);
    String duanzupre = DanPreUtils.duanZuPre(preKaiJiangHao);
    String countText = _getCountText(data);
    String countTextKuadu = _getCountTextKuadu(data);
    String countHezhi = _getCountTextHezhi(data);
    var hzarr = countHezhi.split(",");
    String countHewei = _getCountTextHeWei(data);


    int ints = int.parse(preKaiJiangHao);
    String forhead = SiMa01.get4HeadNumber((ints / 3.1415926).toString(),3);
    String left6=getLeftNumber(forhead);
    List<String> aGaoYuanLangDuanzu=SiMa01.getByGaoYuanLangDuanzu(preKaiJiangHao);
    List<String>  sima01Numberlist=sima01Number(preKaiJiangHao);

    ///大底开始。
    ///
    List<FilterCondition> conditons = [];

    print("hz:" + countHezhi);
    print("forhead:" + forhead);
    print("left6:" + left6);
    print("aGaoYuanLangDuanzu:" + aGaoYuanLangDuanzu.toString());

    conditons.clear();
//
//    conditons.add(
//        Duanzu(Utils.danmaToList(aGaoYuanLangDuanzu[0]),
//            Utils.danmaToList(aGaoYuanLangDuanzu[1]),
//            Utils.danmaToList(aGaoYuanLangDuanzu[2])));
//
//    conditons.add(
//        Duanzu(["1","2","5"],
//            ["0","7","9"],
//            ["3","4","6","8"]));
//
    conditons.add(DingHewei(["1","4","7"]));
    conditons.add(
        Duanzu([countText[0],countText[1]],
            [countText[2],countText[3],countText[4],countText[5]],
            [countText[6],countText[7],countText[8],countText[9]]));

    //conditons.add(ShaDanMa([countText[0],countText[1],countText[2],countText[3],countText[8],countText[9]]));

   // conditons.add(DingDanMa([countText[0], countText[1]]));
//    conditons.add(DingHewei([
//      countHewei[0],
//      countHewei[1],
//      countHewei[2],
//      countHewei[7],
//      countHewei[8],
//      countHewei[9]
//    ]));
    // conditons.add(DingKuadu([countTextKuadu[0],countTextKuadu[1],countTextKuadu[2]]));


    Result<List<String>> result =
        filterAppService.runFilter(DanMaSource.getZuXuanSource(), conditons);
    data = result.data;
    List<String> res1 = data;

//    conditons.clear();
//    conditons.add(DingErMa(["${duanzupre[0]}${duanzupre[9]}"]));
//    result = filterAppService.runFilter(DanMaSource.getZuXuanSource(), conditons);
//    data = result.data;
//
//    data.forEach((element) {
//      if(!res1.contains(element)){
//        res1.add(element);
//      }
//    });

    data = res1;

    ///去掉组三豹子。
    result = filterAppService.nozu3(data); ////////
    data = result.data;

    result = filterAppService.nozzz(data); ///////
    data = result.data;

    return data;
  }
}
