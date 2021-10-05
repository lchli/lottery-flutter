import 'package:bloc/bloc.dart';
import 'package:flutterapp/lotfilter/domain/DanMaRepo.dart';
import 'package:flutterapp/lotfilter/models.dart';

import 'DanMaPre1State.dart';
import 'blocs/DanPreUtils.dart';

class DanMaPre1Cubit extends Cubit<DanMaPre1State> {
  DanMaPre1Cubit(this._danMaRepo) : super(DanMaPre1State([]));
  DanMaRepo _danMaRepo;

  loadResult() async {
    var list = await mock();

    emit(DanMaPre1State(list));
  }

  Future<List<KjRow>> mock() async {
    var result = await _danMaRepo.queryKaiJiangHao();
    if (result.hasError() || result.data == null || result.data.isEmpty) {
      return [];
    }
    print("result:${result.data.length}");

    var data = result.data;

    List<KjRow> list = [];

    String preKaiJiangHao = null;

    for (int i = 0; i < data.length; i++) {
      if (preKaiJiangHao != null) {
        var r1 = DanPreUtils.siMa01Pre(preKaiJiangHao);
        var res = data[i].kaiJiangHao.contains(r1[0]) ||
            data[i].kaiJiangHao.contains(r1[1]);
        list.add(KjRow(data[i].qiHao, data[i].kaiJiangHao, "${r1[0]}${r1[1]}",
            res ? "对" : "错"));
      }

      preKaiJiangHao = data[i].kaiJiangHao;
    }

    print("list:${list.length}");

    return list;
  }
}
