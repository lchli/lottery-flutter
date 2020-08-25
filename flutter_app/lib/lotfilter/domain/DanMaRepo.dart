import 'package:flutterapp/client/ResultDto.dart';

abstract class  DanMaRepo{



  Future<Result<List<KJDto>>> queryKaiJiangHao();
  Future<Result<List<KJDto>>> importHistory(String his);
}

class KJDto{
  String qiHao;
  String kaiJiangHao;
}