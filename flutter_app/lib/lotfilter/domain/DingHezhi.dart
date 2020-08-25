import 'DingDanMa.dart';
import 'FilterCondition.dart';

class DingHezhi extends DingDanMa {
  DingHezhi(List<String> mdanMa) : super(mdanMa);

  bool isInclude(String item, List<String> dmList) {
    if (dmList.contains(getItemHezhi(item))) {
      return true;
    }

    return false;
  }

  @override
  FilterCondition reverseCondition() {
    return DingHezhiReverse(mdanMa);
  }

  String getItemHezhi(String item) {
    int ret = 0;
    int len = item.length;
    for (int i = 0; i < len; i++) {
      ret += int.parse(item.substring(i, i + 1));
    }
    return ret.toString();
  }
}

class DingHezhiReverse extends DingHezhi {
  DingHezhiReverse(List<String> mdanMa) : super(mdanMa);

  @override
  bool isInclude(String item, List<String> dmList) {
    return !super.isInclude(item, dmList);
  }

  @override
  FilterCondition reverseCondition() {
    return DingHezhi(mdanMa);
  }
}
