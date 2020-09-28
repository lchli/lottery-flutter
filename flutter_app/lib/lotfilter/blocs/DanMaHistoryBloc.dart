import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutterapp/lotfilter/domain/DanMaRepo.dart';
import 'package:flutterapp/lotfilter/domain/Utils.dart';

import '../../main.dart';
import 'DanMaHistoryState.dart';
import 'DanMaHistroyEvent.dart';
import 'DanPreUtils.dart';

class DanMaHistoryBloc extends Bloc<DanMaHistroyEvent, DanMaHistoryState> {
  DanMaRepo _danMaRepo = MyApp.provideDanMaRepo();

  DanMaHistoryBloc() : super(DanMaHistoryState([]));

  @override
  Stream<DanMaHistoryState> mapEventToState(DanMaHistroyEvent event) async* {
    yield await _startPredicate();
  }

  Future<DanMaHistoryState> _startPredicate() async {
    var result = await _danMaRepo.queryKaiJiangHao();
    if (result.hasError() || result.data == null || result.data.isEmpty) {
      return DanMaHistoryState([]);
    }

    var data = result.data;
    List<HistroyRow> histroyRows = [];
    HistroyRow rowHeader = HistroyRow();
    rowHeader.kaiJiangHao = "开奖";
    rowHeader.qiHao = "期---号";
    rowHeader.id = "head";

    rowHeader.duDan1 = "01";
    rowHeader.ciDan1 = "";
    rowHeader.sanDan1 = "";
    rowHeader.siDan1 = "";
    rowHeader.wuDan1 = "";

    rowHeader.duDan2 = "bs";
    rowHeader.ciDan2 = "";

    rowHeader.duDan3 = "duz";
    rowHeader.ciDan3 = "";

    rowHeader.hewei0 = "h---w";
    rowHeader.hewei1 = "";
    rowHeader.hewei2 = "";
    rowHeader.hewei3 = "";
    rowHeader.hewei4 = "";
    rowHeader.hewei5 = "";

    rowHeader.kuadu0 = "k---d";
    rowHeader.kuadu1 = "";
    rowHeader.kuadu2 = "";
    rowHeader.kuadu3 = "";
    rowHeader.kuadu4 = "";
    rowHeader.daDi = "1+3";
    rowHeader.daDiK = "daDk";
    rowHeader.daDi2wei = "3w";

    histroyRows.add(rowHeader);

    for (int i = 0; i < data.length; i++) {
      var element = data[i];

      if (i == 0) {
        continue;
      }
      String preKaiJiangHao = data[i - 1].kaiJiangHao;
      print("pre:$preKaiJiangHao");
      if (preKaiJiangHao == null ||
          preKaiJiangHao.isEmpty ||
          preKaiJiangHao.length != 3) {
        continue;
      }
      try {
        int.parse(preKaiJiangHao);
      } catch (Exception) {
        continue;
      }

      HistroyRow row = HistroyRow();
      row.kaiJiangHao = element.kaiJiangHao;
      row.qiHao = element.qiHao;

      var r1 = DanPreUtils.siMa01Pre(preKaiJiangHao);
      var r2 = DanPreUtils.bsgePre(preKaiJiangHao);
      row.duDan1 = r1[0];
      row.ciDan1 = r1[1];
      row.sanDan1 = r1[2];
      row.siDan1 = r1[9];
      row.wuDan1 = r1[8];


      row.duDan2 = r2[0];
      row.ciDan2 = r2[1];

      var r3 = DanPreUtils.duanZuPre(preKaiJiangHao);
      row.duDan3 = r3[0];
      row.ciDan3 = r3[9];

      var hw = DanPreUtils.siMa01PreHewei(preKaiJiangHao);
      row.hewei0 = hw[0];
      row.hewei1 = hw[1];
      row.hewei2 = hw[2];
      row.hewei3 = hw[7];
      row.hewei4 = hw[8];
      row.hewei5 = hw[9];


      var kuadu = DanPreUtils.siMa01PreKuadu(preKaiJiangHao);
      row.kuadu0 = kuadu[0];
      row.kuadu1 = kuadu[1];
      row.kuadu2 = kuadu[2];
      row.kuadu3 = kuadu[3];
      row.kuadu4 = kuadu[4];


      row.daDi = DanPreUtils.getDaDiResult(preKaiJiangHao)
              .contains(Utils.getSortedDanMa(element.kaiJiangHao))
          ? "对"
          : "错";

      row.daDiK = DanPreUtils.getDaDiResultByKuadu(preKaiJiangHao)
              .contains(Utils.getSortedDanMa(element.kaiJiangHao))
          ? "对"
          : "错";

      row.daDi2wei = DanPreUtils.getDadiPreLast(preKaiJiangHao)
              .contains(Utils.getSortedDanMa(element.kaiJiangHao))
          ? "对"
          : "错";

      histroyRows.add(row);
    }

    HistroyRow rowNext = HistroyRow();
    rowNext.kaiJiangHao = "000";
    rowNext.qiHao = "0000000";
    rowNext.id = "tail";

    String preKaiJiangHao = data[data.length - 1].kaiJiangHao;

    var r1 = DanPreUtils.siMa01Pre(preKaiJiangHao);
    var r2 = DanPreUtils.bsgePre(preKaiJiangHao);
    rowNext.duDan1 = r1[0];
    rowNext.ciDan1 = r1[1];
    rowNext.sanDan1 = r1[2];
    rowNext.siDan1 = r1[9];
    rowNext.wuDan1 = r1[8];



    rowNext.duDan2 = r2[0];
    rowNext.ciDan2 = r2[1];

    var r3 = DanPreUtils.duanZuPre(preKaiJiangHao);
    rowNext.duDan3 = r3[0];
    rowNext.ciDan3 = r3[9];

    var hw = DanPreUtils.siMa01PreHewei(preKaiJiangHao);
    rowNext.hewei0 = hw[0];
    rowNext.hewei1 = hw[1];
    rowNext.hewei2 = hw[2];
    rowNext.hewei3 = hw[7];
    rowNext.hewei4 = hw[8];
    rowNext.hewei5 = hw[9];

    var kuadu = DanPreUtils.siMa01PreKuadu(preKaiJiangHao);
    rowNext.kuadu0 = kuadu[0];
    rowNext.kuadu1 = kuadu[1];
    rowNext.kuadu2 = kuadu[2];
    rowNext.kuadu3 = kuadu[3];
    rowNext.kuadu4 = kuadu[4];


    rowNext.daDi = "?";
    rowNext.daDiK = "?";
    rowNext.daDi2wei = "?";

    histroyRows.add(rowNext);

    return DanMaHistoryState(histroyRows);
  }
}
