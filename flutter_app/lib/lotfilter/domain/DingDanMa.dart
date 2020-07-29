import 'FilterCondition.dart';
import 'ShaDanMa.dart';

class DingDanMa extends FilterCondition {
  final List<String> mdanMa;

  DingDanMa(this.mdanMa) ;

  @override
  void doFilter(List<String> source) {
    source.removeWhere((item) => !isInclude(item, mdanMa));
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
