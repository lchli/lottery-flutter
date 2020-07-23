import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';

import 'ShaErMa.dart';

class DingErMa extends FilterCondition {

  final List<String> condition;

  DingErMa(this.condition);

  @override
  void doFilter(List<String> source) {
    source.removeWhere((item) => !isInclude(item, condition));
  }

  @override
  FilterCondition reverseCondition() {
    return ShaErMa(condition);
  }

  List<String> itemList = [];

  bool isInclude(String item, List<String> condition) {
    int len = item.length;
    itemList.clear();
    for (int i = 0; i < len; i++) {
      itemList.add(item.substring(i, i + 1));
    }

    for (int i = 0; i < len; i++) {
      for (int j = i + 1; j < len; j++) {
        if (condition.contains(itemList[i] + "" +
            itemList[j])) {
          return true;
        }
      }
    }

    return false;
  }
}
