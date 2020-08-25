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
  Color _selectedColor = Color(0xFFDC143C);
  Color _normalColor = Color(0xFF000000);

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
    rowHeader.kaiJiangHao = "开奖号";
    rowHeader.qiHao = "期号";

    rowHeader.duDan1 = "四码01";
    rowHeader.ciDan1 = "";
    rowHeader.duDan1Color = _normalColor;
    rowHeader.ciDan1Color = _normalColor;

    rowHeader.duDan2 = "百十";
    rowHeader.ciDan2 = "";
    rowHeader.duDan2Color = _normalColor;
    rowHeader.ciDan2Color = _normalColor;

    rowHeader.duDan3 = "断组";
    rowHeader.ciDan3 = "";
    rowHeader.duDan3Color = _normalColor;
    rowHeader.ciDan3Color = _normalColor;

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
      row.duDan1Color = element.kaiJiangHao.contains(row.duDan1)
          ? _selectedColor
          : _normalColor;
      row.ciDan1Color = element.kaiJiangHao.contains(row.ciDan1)
          ? _selectedColor
          : _normalColor;

      var r2 =  DanPreUtils.bsgePre(preKaiJiangHao);
      row.duDan2 = r2[0];
      row.ciDan2 = r2[1];
      row.duDan2Color = element.kaiJiangHao.contains(row.duDan2)
          ? _selectedColor
          : _normalColor;
      row.ciDan2Color = element.kaiJiangHao.contains(row.ciDan2)
          ? _selectedColor
          : _normalColor;

      var r3 =  DanPreUtils.duanZuPre(preKaiJiangHao);
      row.duDan3 = r3[0];
      row.ciDan3 = r3[9];
      row.duDan3Color = element.kaiJiangHao.contains(row.duDan3)
          ? _selectedColor
          : _normalColor;
      row.ciDan3Color = element.kaiJiangHao.contains(row.ciDan3)
          ? _selectedColor
          : _normalColor;

      histroyRows.add(row);
    }

    HistroyRow rowNext = HistroyRow();
    rowNext.kaiJiangHao = "xxx";
    rowNext.qiHao = "xxxxxxx";

    String preKaiJiangHao = data[data.length - 1].kaiJiangHao;

    var r1 =  DanPreUtils.siMa01Pre(preKaiJiangHao);
    rowNext.duDan1 = r1[0];
    rowNext.ciDan1 = r1[1];
    rowNext.duDan1Color = _normalColor;
    rowNext.ciDan1Color = _normalColor;

    var r2 =  DanPreUtils.bsgePre(preKaiJiangHao);
    rowNext.duDan2 = r2[0];
    rowNext.ciDan2 = r2[1];
    rowNext.duDan2Color =  _normalColor;
    rowNext.ciDan2Color = _normalColor;

    var r3 =  DanPreUtils.duanZuPre(preKaiJiangHao);
    rowNext.duDan3 = r3[0];
    rowNext.ciDan3 = r3[9];
    rowNext.duDan3Color = _normalColor;
    rowNext.ciDan3Color =  _normalColor;

    histroyRows.add(rowNext);

    return DanMaHistoryState(histroyRows);
  }
}
