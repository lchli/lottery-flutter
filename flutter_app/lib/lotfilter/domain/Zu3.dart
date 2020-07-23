import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';

class Zu3 extends FilterCondition {
  @override
  void doFilter(List<String> source) {
    source.removeWhere((element) => !isInclude(element));
  }

  @override
  FilterCondition reverseCondition() {
    return _ZuSanReverse();
  }

  bool isInclude(String element) {
    //002
    if (element[0] == element[1] && element[1] == element[2]) {
      return false;
    }

    if (element[0] != element[1] &&
        element[1] != element[2] &&
        element[0] != element[2]) {
      return false;
    }

    return true;
  }
}

class _ZuSanReverse extends Zu3 {
  @override
  bool isInclude(String element) {
    return !super.isInclude(element);
  }
}
