import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';

abstract class FilterAppService{

  Result<List<String>> runFilter(List<String> dataSource,List<FilterCondition> conditons);

  Result<List<String>> runRongCuoFilter(List<String> dataSource,List<FilterCondition> conditons,
      List<int> rongCuoLevels);

  Result<List<String>> nozu3(List<String> dataSource);
  Result<List<String>> nozu6(List<String> dataSource);
  Result<List<String>> nozzz(List<String> dataSource);

}