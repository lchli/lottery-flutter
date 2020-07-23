
import 'DingErMa.dart';

class ShaErMa extends DingErMa {
  ShaErMa(List<String> condition) : super(condition);

  @override
  bool isInclude(String item, List<String> condition) {
    return !super.isInclude(item, condition);
  }

}