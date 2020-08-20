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

  bool isInclude(String item, List<String> condition) {//456

    if (condition.contains("${item[0]}${item[1]}") ||
        condition.contains("${item[1]}${item[0]}") ||
        condition.contains("${item[0]}${item[2]}") ||
        condition.contains("${item[2]}${item[0]}") ||
        condition.contains("${item[1]}${item[2]}") ||
        condition.contains("${item[2]}${item[1]}")) {
      return true;
    }

    return false;
  }
}
