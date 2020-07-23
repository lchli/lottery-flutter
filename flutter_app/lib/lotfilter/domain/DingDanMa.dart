import 'FilterCondition.dart';
import 'ShaDanMa.dart';

class DingDanMa extends FilterCondition {
  final List<String> danMaList = [];
  final String mdanMa;

  DingDanMa(this.mdanMa) {
    int len = mdanMa.length;
    for (int i = 0; i < len; i++) {
      danMaList.add(mdanMa.substring(i, i + 1));
    }
  }

  @override
  void doFilter(List<String> source) {
    source.removeWhere((item) => !isInclude(item, danMaList));
  }

  @override
  FilterCondition reverseCondition() {
    return ShaDanMa(mdanMa);
  }

  bool isInclude(String item, List<String> dmList) {
    for (String e in dmList) {
      if (item.contains(e)) {
        return true;
      }
    }

    return false;
  }
}
