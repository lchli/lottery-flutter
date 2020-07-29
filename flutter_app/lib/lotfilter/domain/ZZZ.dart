import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';

class ZZZ extends FilterCondition {
  @override
  void doFilter(List<String> source) {
    source.removeWhere((element) => !isInclude(element));
  }

  @override
  FilterCondition reverseCondition() {
    return _ZZZReverse();
  }

  bool isInclude(String element) {
    if (element[0] == element[1] && element[1] == element[2]) {
      return true;
    }

    return false;
  }
}

class _ZZZReverse extends ZZZ {
  @override
  bool isInclude(String element) {
    return !super.isInclude(element);
  }

  @override
  FilterCondition reverseCondition() {
    return ZZZ();
  }
}
