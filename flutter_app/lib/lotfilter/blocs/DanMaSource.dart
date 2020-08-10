import 'dart:math';

class DanMaSource {
  static List<List<String>> x012=[["1","4","7"],["2","5","8"],["0","3","6","9"]];

  static List<String> _makeDanXuan() {
    List<String> list = [];

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        for (int k = 0; k < 10; k++) {
          list.add("$i$j$k");
        }
      }
    }

    return list;
  }

  static List<String> _makeZuXuan() {
    List<String> list = [];
    Map<String, bool> map = {};

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        for (int k = 0; k < 10; k++) {
          String ijk = _getSortedIJK(i, j, k);
          if (map[ijk] == null) {
            list.add(ijk);
            map[ijk] = true;
          }
        }
      }
    }

    return list;
  }

  static List<String> _makeErMa() {
    List<String> list = [];
    Map<String, bool> map = {};

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        String ij = _getSortedIJ(i, j);
        if (map[ij] == null) {
          list.add(ij);
          map[ij] = true;
        }
      }
    }

    return list;
  }

  static String _getSortedIJK(int i, int j, int k) {
    List<int> list = List.of([i, j, k]);
    list.sort();

    String ret = "";
    list.forEach((element) {
      ret += element.toString();
    });

    return ret;
  }

  static String _getSortedIJ(int i, int j) {
    int mx = max(i, j);
    int mi = min(i, j);
    return "$mi$mx";
  }

  static List<String> _sources;
  static List<String> _sourcesZX;
  static List<String> _sourcesErMa;

  static List<String> getDanXuanSource() {
    if (_sources == null) {
      _sources = _makeDanXuan();
    }

    return _sources;
  }

  static List<String> getZuXuanSource() {
    if (_sourcesZX == null) {
      _sourcesZX = _makeZuXuan();
    }

    return _sourcesZX;
  }

  static List<String> getErMaSource() {
    if (_sourcesErMa == null) {
      _sourcesErMa = _makeErMa();
    }

    return _sourcesErMa;
  }

  static List<String> getDanMaSource() {
    return ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  }

  static List<int> getDanMaSourceInt() {
    return [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  }

}
