import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';

class Zu6 extends FilterCondition {
  @override
  void doFilter(List<String> source) {
    source.removeWhere((element) => !isInclude(element));
  }

  @override
  FilterCondition reverseCondition() {
    return _Zu6Reverse();
  }

  bool isInclude(String element) {
    if (element[0] != element[1] &&
        element[1] != element[2] &&
        element[0] != element[2]) {
      return true;
    }

    return false;
  }
}

class _Zu6Reverse extends Zu6 {
  @override
  bool isInclude(String element) {
    return !super.isInclude(element);
  }

  @override
  FilterCondition reverseCondition() {
    return Zu6();
  }
}
