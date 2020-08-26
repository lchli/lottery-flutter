import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutterapp/lotfilter/domain/DanMaRepo.dart';

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
    rowHeader.qiHao = "期号";

    rowHeader.duDan1 = "01";
    rowHeader.ciDan1 = "";


    rowHeader.duDan2 = "bs";
    rowHeader.ciDan2 = "";


    rowHeader.duDan3 = "duz";
    rowHeader.ciDan3 = "";

    rowHeader.hewei0 = "hw";
    rowHeader.hewei1 = "";
    rowHeader.hewei2 = "";
    rowHeader.hewei3 = "";
    rowHeader.hewei4 = "";

    rowHeader.kuadu0="kd";
    rowHeader.kuadu1="";
    rowHeader.kuadu2="";
    rowHeader.kuadu3="";
    rowHeader.kuadu4="";


    histroyRows.add(rowHeader);

    for (int i = 0; i < data.length; i++) {
      var element = data[i];

      if (i == 0) {
        continue;
      }
      String preKaiJiangHao = data[i - 1].kaiJiangHao;
      print("pre:$preKaiJiangHao");

      HistroyRow row = HistroyRow();
      row.kaiJiangHao = element.kaiJiangHao;
      row.qiHao = element.qiHao;

      var r1 =  DanPreUtils.siMa01Pre(preKaiJiangHao);
      row.duDan1 = r1[0];
      row.ciDan1 = r1[1];


      var r2 =  DanPreUtils.bsgePre(preKaiJiangHao);
      row.duDan2 = r2[0];
      row.ciDan2 = r2[1];

      var r3 =  DanPreUtils.duanZuPre(preKaiJiangHao);
      row.duDan3 = r3[0];
      row.ciDan3 = r3[9];

      var hw=  DanPreUtils.siMa01PreHewei(preKaiJiangHao);
      row.hewei0 = hw[0];
      row.hewei1 = hw[1];
      row.hewei2 = hw[2];
      row.hewei3 = hw[8];
      row.hewei4 = hw[9];

      var kuadu=  DanPreUtils.siMa01PreKuadu(preKaiJiangHao);
      row.kuadu0=kuadu[0];
      row.kuadu1=kuadu[1];
      row.kuadu2=kuadu[2];
      row.kuadu3=kuadu[3];
      row.kuadu4=kuadu[4];



      histroyRows.add(row);
    }

    HistroyRow rowNext = HistroyRow();
    rowNext.kaiJiangHao = "000";
    rowNext.qiHao = "0000000";

    String preKaiJiangHao = data[data.length - 1].kaiJiangHao;

    var r1 =  DanPreUtils.siMa01Pre(preKaiJiangHao);
    rowNext.duDan1 = r1[0];
    rowNext.ciDan1 = r1[1];


    var r2 =  DanPreUtils.bsgePre(preKaiJiangHao);
    rowNext.duDan2 = r2[0];
    rowNext.ciDan2 = r2[1];


    var r3 =  DanPreUtils.duanZuPre(preKaiJiangHao);
    rowNext.duDan3 = r3[0];
    rowNext.ciDan3 = r3[9];

    var hw=  DanPreUtils.siMa01PreHewei(preKaiJiangHao);
    rowNext.hewei0 = hw[0];
    rowNext.hewei1 = hw[1];
    rowNext.hewei2 = hw[2];
    rowNext.hewei3 = hw[3];
    rowNext.hewei4 = hw[4];

    var kuadu=  DanPreUtils.siMa01PreKuadu(preKaiJiangHao);
    rowNext.kuadu0=kuadu[0];
    rowNext.kuadu1=kuadu[1];
    rowNext.kuadu2=kuadu[2];
    rowNext.kuadu3=kuadu[3];
    rowNext.kuadu4=kuadu[4];

    histroyRows.add(rowNext);

    return DanMaHistoryState(histroyRows);
  }
}
