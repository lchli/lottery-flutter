import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';

class Duanzu extends FilterCondition {
  final List<String> condition1;
  final List<String> condition2;
  final List<String> condition3;

  Duanzu(this.condition1, this.condition2, this.condition3);

  @override
  FilterCondition reverseCondition() {
    return _DuanzuReverse(condition1,condition2,condition3);
  }

  @override
  void doFilter(List<String> source) {
    List<String> duanzuDi = _makeZuXuan();

    source.removeWhere((item) => isInclude(item, duanzuDi));
  }

  bool isInclude(String item, List<String> condition) {
    return condition.contains(item);
  }

  List<String> _makeZuXuan() {
    List<String> list = [];
    Map<String, bool> map = {};

    for (int i = 0; i < condition1.length; i++) {
      for (int j = 0; j < condition2.length; j++) {
        for (int k = 0; k < condition3.length; k++) {
          String ijk =
              _getSortedIJK(condition1[i], condition2[j], condition3[k]);
          if (map[ijk] == null) {
            list.add(ijk);
            map[ijk] = true;
          }
        }
      }
    }

    return list;
  }

  String _getSortedIJK(String i, String j, String k) {
    List<String> list = List.of([i, j, k]);
    list.sort();

    String ret = "";
    list.forEach((element) {
      ret += element.toString();
    });

    return ret;
  }
}

class _DuanzuReverse extends Duanzu {
  _DuanzuReverse(
      List<String> condition1, List<String> condition2, List<String> condition3)
      : super(condition1, condition2, condition3);

  @override
  bool isInclude(String item, List<String> condition) {
    return !super.isInclude(item, condition);
  }

  @override
  FilterCondition reverseCondition() {
    return Duanzu(condition1,condition2,condition3);
  }
}
