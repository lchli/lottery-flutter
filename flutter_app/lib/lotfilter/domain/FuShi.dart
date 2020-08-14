import 'FilterCondition.dart';
import 'ShaDanMa.dart';

class FuShi extends FilterCondition {
  //n码复试=3
  final List<String> mdanMa;

  FuShi(this.mdanMa);

  @override
  void doFilter(List<String> source) {
    source.removeWhere((item) => !isInclude(item, mdanMa));
  }

  @override
  FilterCondition reverseCondition() {
    return FuShiReverse(mdanMa);
  }

  bool isInclude(String item, List<String> dmList) {
    //123   1234567
    for (int i = 0; i < item.length; i++) {
      if (!dmList.contains(item[i])) {
        return false;
      }
    }

    return true;
  }
}

class FuShiReverse extends FuShi {
  FuShiReverse(List<String> mdanMa) : super(mdanMa);

  @override
  bool isInclude(String item, List<String> dmList) {
    return !super.isInclude(item, dmList);
  }

  @override
  FilterCondition reverseCondition() {
    return FuShi(mdanMa);
  }
}
