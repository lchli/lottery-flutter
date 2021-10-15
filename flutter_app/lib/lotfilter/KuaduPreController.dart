
import 'package:get/get.dart';

import 'PreController.dart';
import 'blocs/DanPreUtils.dart';
import 'domain/DanMaRepo.dart';
import 'domain/Utils.dart';
import 'models.dart';

class KuaduPreController extends PreController{

  DanMaRepo _danMaRepo=Get.find<DanMaRepo>();


  @override
  void onReady() {
    super.onReady();
   loadResult();
  }



  loadResult() async {
    var ret = await mock();
    list.value=ret;
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
        var r1 = DanPreUtils.siMa01PreKuadu(preKaiJiangHao);
        var pre="${r1[0]}${r1[1]}${r1[2]}${r1[3]}${r1[4]}";
        var res =pre.contains(Utils.getItemKuadu(data[i].kaiJiangHao));
        list.add(KjRow(data[i].qiHao, data[i].kaiJiangHao, pre,
            res ? "对" : "错"));
      }

      preKaiJiangHao = data[i].kaiJiangHao;
    }

    print("list:${list.length}");

    return list;
  }

}

