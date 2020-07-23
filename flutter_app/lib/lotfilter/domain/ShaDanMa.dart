import 'DingDanMa.dart';
import 'FilterCondition.dart';

class ShaDanMa extends DingDanMa {
  ShaDanMa(String danMa) : super(danMa);

  @override
  FilterCondition reverseCondition() {
    return DingDanMa(mdanMa);
  }

  bool isInclude(String item, List<String> dmList) {
    return !super.isInclude(item, dmList);
  }
}
