import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/client/FilterAppService.dart';
import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';
import 'package:flutterapp/lotfilter/domain/FilterManager.dart';
import 'package:flutterapp/lotfilter/domain/ZZZ.dart';
import 'package:flutterapp/lotfilter/domain/Zu3.dart';
import 'package:flutterapp/lotfilter/domain/Zu6.dart';

class FilterAppServiceImpl extends FilterAppService {
  @override
  Result<List<String>> runFilter(
      List<String> dataSource, List<FilterCondition> conditons)  {
    Result<List<String>> ret = Result<List<String>>();
    if (conditons == null || conditons.isEmpty) {
      ret.data = dataSource;
      return ret;
    }

    FilterManager filterManager = FilterManager();
    conditons.forEach((element) {
      filterManager.addFilter(element);
    });
    ret.data = filterManager.runFilter(dataSource);

    return ret;
  }

  @override
  Result<List<String>> runRongCuoFilter(List<String> dataSource,
      List<FilterCondition> conditons, List<int> rongCuoLevels)  {
    Result<List<String>> ret = Result<List<String>>();
    if (conditons == null || conditons.isEmpty) {
      ret.data = dataSource;
      return ret;
    }

    FilterManager filterManager = FilterManager();
    conditons.forEach((element) {
      filterManager.addFilter(element);
    });
    ret.data = filterManager.runRongCuoFilter(dataSource, rongCuoLevels);

    return ret;
  }

  @override
  Result<List<String>> nozzz(List<String> dataSource){
    Result<List<String>> ret = Result<List<String>>();

    FilterManager filterManager = FilterManager();
    filterManager.addFilter(ZZZ().reverseCondition());
    ret.data = filterManager.runFilter(dataSource);

    return ret;

  }

  @override
  Result<List<String>> nozu6(List<String> dataSource) {
    Result<List<String>> ret = Result<List<String>>();

    FilterManager filterManager = FilterManager();
    filterManager.addFilter(Zu6().reverseCondition());
    ret.data = filterManager.runFilter(dataSource);

    return ret;
  }

  @override
  Result<List<String>> nozu3(List<String> dataSource) {
    Result<List<String>> ret = Result<List<String>>();

    FilterManager filterManager = FilterManager();
    filterManager.addFilter(Zu3().reverseCondition());
    ret.data = filterManager.runFilter(dataSource);

    return ret;

  }
}
