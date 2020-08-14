class Utils {
  static String getItemHeWei(String item) {
    int ret = 0;
    int len = item.length;
    for (int i = 0; i < len; i++) {
      ret += int.parse(item.substring(i, i + 1));
    }
    ret %= 10;
    return ret.toString();
  }

  static String getItemKuadu(String item) {
    int len = item.length;
    int max = -1;
    int min = 10;
    for (int i = 0; i < len; i++) {
      int temp = int.parse(item.substring(i, i + 1));
      if (temp > max) max = temp;
      if (temp < min) min = temp;
    }
    int ret = max - min;
    ret %= 10;
    return ret.toString();
  }

  static List<String> danmaToList(String item) {
    List<String> list = [];
    int len = item.length;
    for (int i = 0; i < len; i++) {
      list.add(item[i]);
    }

    return list;
  }

  static List<int> danmaToListInt(String item) {
    List<int> list = [];
    int len = item.length;
    for (int i = 0; i < len; i++) {
      list.add(int.parse(item[i]));
    }

    return list;
  }
}
