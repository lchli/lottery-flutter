import 'DingDanMa.dart';
import 'FilterCondition.dart';

class DingHewei extends DingDanMa {
  DingHewei(String mdanMa) : super(mdanMa);

  bool isInclude(String item, List<String> dmList) {
    if (dmList.contains(getItemHeWei(item))) {
      return true;
    }

    return false;
  }

  @override
  FilterCondition reverseCondition() {
    return  _DingHeweiReverse(mdanMa);
  }

  String getItemHeWei(String item) {
    int ret = 0;
    int len = item.length;
    for (int i = 0; i < len; i++) {
      ret += int.parse(item.substring(i, i + 1));
    }
    ret %= 10;
    return ret.toString();
  }
}

class _DingHeweiReverse extends DingHewei{
  _DingHeweiReverse(String mdanMa) : super(mdanMa);

  @override
  bool isInclude(String item, List<String> dmList) {
    return !super.isInclude(item, dmList);
  }
}
