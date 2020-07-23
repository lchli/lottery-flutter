import 'DingDanMa.dart';
import 'FilterCondition.dart';

class DingKuadu extends DingDanMa {
  DingKuadu(String mdanMa) : super(mdanMa);

  bool isInclude(String item, List<String> dmList) {
    if (dmList.contains(getItemKuadu(item))) {
      return true;
    }
    return false;
  }

  String getItemKuadu(String item) {
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

  @override
  FilterCondition reverseCondition() {
    return  _DingKuaduReverse(mdanMa);
  }


}

class _DingKuaduReverse extends DingKuadu{
  _DingKuaduReverse(String mdanMa) : super(mdanMa);

  @override
  bool isInclude(String item, List<String> dmList) {
    return !super.isInclude(item, dmList);
  }
}
