
import 'package:get/get.dart';

import 'blocs/DanPreUtils.dart';
import 'domain/DanMaRepo.dart';
import 'models.dart';

class DanMaPre1Controller extends GetxController{

  DanMaPre1Controller(this._danMaRepo);

  DanMaRepo _danMaRepo;
  var currentIndex = 0.obs;
  var list=<KjRow>[].obs;

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

