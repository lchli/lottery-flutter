import 'dart:math';

import 'package:flutterapp/lotfilter/blocs/DanMaSource.dart';

import 'Utils.dart';

class SiMa01 {
  static var _map = {
    "0156": "1567",
    "0257": "2579",
    "0358": "1358",
    "0459": "3459",
    "1267": "3789",
    "1368": "1479",
    "1469": "0357",
    "2378": "0159",
    "2479": "1369",
    "3489": "1237"
  };
  static var _list = ["18", "29", "34", "05", "67"];

  static String getByDuiMa(String kaijianghao) {
    List<int> ints = Utils.danmaToListInt(kaijianghao);
    if (ints[0] == ints[1] && ints[1] == ints[2]) {
      int v1 = ints[0];
      int v2 = (v1 + 5) % 10;
      int minx = min(v1, v2);
      if (minx == 0) {
        return "$v1${v2}16";
      }

      return "$v1${v2}05";
    }
    //909,949,945,917
    List<int> ret = [];

    int v1 = (ints[0] + 5) % 10;
    int v2 = (ints[1] + 5) % 10;
    int v3 = (ints[2] + 5) % 10;

    if (!ret.contains(ints[0])) {
      ret.add(ints[0]);
    }
    if (!ret.contains(ints[1])) {
      ret.add(ints[1]);
    }
    if (!ret.contains(ints[2])) {
      ret.add(ints[2]);
    }
    if (!ret.contains(v1)) {
      ret.add(v1);
    }
    if (!ret.contains(v2)) {
      ret.add(v2);
    }
    if (!ret.contains(v3)) {
      ret.add(v3);
    }

    if (ret.length == 4) {
      return "${ret[0]}${ret[1]}${ret[2]}${ret[3]}";
    }

    if (ret.length == 2) {
      int minx = min(ret[0], ret[1]);
      if (minx == 0) {
        return "${ret[0]}${ret[1]}16";
      }

      return "${ret[0]}${ret[1]}05";
    }

    if (ret.length == 6) {
      List<int> left = [];
      DanMaSource.getDanMaSourceInt().forEach((element) {
        if (!ret.contains(element)) {
          left.add(element);
        }
      });

      return "${left[0]}${left[1]}${left[2]}${left[3]}";
    }

    return "";
  }

  static String getByDivide0618(String kaijianghao) {
    int ints = int.parse(kaijianghao);
    double dr = ints / 0.618;
    String drstr = dr.toString();
    print(drstr);

    drstr = drstr.replaceAll(".", "");

    List<String> left = [];

    for (int i = 0; i < drstr.length; i++) {
      if (!left.contains(drstr[i])) {
        left.add(drstr[i]);
        if (left.length >= 4) {
          break;
        }
      }
    }

    String ret = "";

    left.forEach((element) {
      ret += element;
    });

    return ret;
  }

  static String getByXueYinDuanzu(String kaijianghao) {
    List<int> ints = Utils.danmaToListInt(kaijianghao);
    int v1 = (ints[1] - ints[2]).abs();
    int v2;
    if (v1 != ints[2]) {
      v2 = ints[2];
    } else {
      v2 = (v1 + 1) % 10;
      v1 = v1 == 0 ? 9 : v1 - 1;
    }

    int v3 = (v1 + 5) % 10;
    int v4 = (v2 + 5) % 10;

    if (min(v3, v4) == min(v1, v2) && max(v3, v4) == max(v1, v2)) {
      v3 = (v1 + 9) % 10;
      v4 = (v2 + 9) % 10;
    }

    return "$v1$v2$v3$v4";
  }


  static String get4HeadNumber(String drstr) {

    print(drstr);

    drstr = drstr.replaceAll(".", "");

    List<String> left = [];

    for (int i = 0; i < drstr.length; i++) {
      if (!left.contains(drstr[i])) {
        left.add(drstr[i]);
        if (left.length >= 4) {
          break;
        }
      }
    }

    String ret = "";

    left.forEach((element) {
      ret += element;
    });

    return ret;
  }
}
