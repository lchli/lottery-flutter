import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';

abstract class FilterAppService{

  Future<Result<List<String>>> runFilter(List<String> dataSource,List<FilterCondition> conditons);

  Future<Result<List<String>>> runRongCuoFilter(List<String> dataSource,List<FilterCondition> conditons,
      List<int> rongCuoLevels);

  Future<Result<List<String>>> nozu3(List<String> dataSource);
  Future<Result<List<String>>> nozu6(List<String> dataSource);
  Future<Result<List<String>>> nozzz(List<String> dataSource);

}