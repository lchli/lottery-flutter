import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/client/FilterAppService.dart';
import 'package:flutterapp/lotfilter/domain/DanMaRepo.dart';
import 'package:flutterapp/lotfilter/domain/DingDanMa.dart';
import 'package:flutterapp/lotfilter/domain/DingErMa.dart';
import 'package:flutterapp/lotfilter/domain/DingHewei.dart';
import 'package:flutterapp/lotfilter/domain/DingKuadu.dart';
import 'package:flutterapp/lotfilter/domain/Duanzu.dart';
import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';
import 'package:flutterapp/lotfilter/domain/ShaDanMa.dart';
import 'package:flutterapp/lotfilter/domain/ShaErMa.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaSource.dart';

import '../../main.dart';
import 'FilterEvent.dart';
import 'FilterState.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final FilterAppService filterAppService = MyApp.provideFilterAppService();
  DanMaRepo _danMaRepo=MyApp.provideDanMaRepo();

  FilterBloc() : super(FilterState.newFilterState()) {
    print("new FilterBloc");
  }

  @override
  Stream<FilterState> mapEventToState(FilterEvent event) async* {
    if (event is DingDanMaChangedEvent) {
      FilterState newst = state.clone();
      newst.danmasChecked = event.checked;
      yield newst;
    } else if (event is ShaMaChangedEvent) {
      FilterState newst = state.clone();
      newst.shamasChecked = event.checked;
      yield newst;
    } else if (event is StartFilterEvent) {
      FilterState newst = await _startFilter();
      yield newst;
    } else if (event is HeWeiChangedEvent) {
      FilterState newst = state.clone();
      newst.heweiChecked = event.checked;
      yield newst;
    } else if (event is KuaduChangedEvent) {
      FilterState newst = state.clone();
      newst.kuaduChecked = event.checked;
      yield newst;
    } else if (event is DingErMaChangedEvent) {
      FilterState newst = state.clone();
      newst.dingErMaChecked = event.checked;
      yield newst;
    } else if (event is ShaErMaChangedEvent) {
      FilterState newst = state.clone();
      newst.shaErMaChecked = event.checked;
      yield newst;
    } else if (event is DuanZu1ChangedEvent) {
      FilterState newst = state.clone();
      newst.duanzu1Checked = event.checked;
      yield newst;
    } else if (event is DuanZu2ChangedEvent) {
      FilterState newst = state.clone();
      newst.duanzu2Checked = event.checked;
      yield newst;
    } else if (event is DuanZu3ChangedEvent) {
      FilterState newst = state.clone();
      newst.duanzu3Checked = event.checked;
      yield newst;
    } else if (event is Zu6ChangedEvent) {
      FilterState newst = state.clone();
      newst.isZu6Checked = event.checked;
      yield newst;
    } else if (event is Zu3ChangedEvent) {
      FilterState newst = state.clone();
      newst.isZu3Checked = event.checked;
      yield newst;
    } else if (event is BaoZiChangedEvent) {
      FilterState newst = state.clone();
      newst.isZZZChecked = event.checked;
      yield newst;
    } else if (event is AddRongCuoEvent) {
      FilterState newst = state.clone();
      newst.rongcuoChecked.add(event.val);
      yield newst;
    } else if (event is RemoveRongCuoEvent) {
      FilterState newst = state.clone();
      newst.rongcuoChecked.remove(event.val);
      yield newst;
    }else if (event is ImportHisEvent) {
      _danMaRepo.importHistory(state.controllerHis.text);
      yield state.clone();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

  String _formatMa(List<String> input) {
    if (input == null || input.isEmpty) {
      return null;
    }
    String ret = "";
    input.forEach((element) {
      ret += element;
    });

    return ret;
  }

  Future<FilterState> _startFilter() async {
    List<FilterCondition> conditons = [];
    if (state.danmasChecked != null && state.danmasChecked.isNotEmpty) {
      conditons.add(DingDanMa(state.danmasChecked));
    }


    if (state.shamasChecked != null && state.shamasChecked.isNotEmpty) {
      conditons.add(ShaDanMa(state.shamasChecked));
    }

    if (state.heweiChecked != null && state.heweiChecked.isNotEmpty) {
      conditons.add(DingHewei(state.heweiChecked));
    }

    if (state.kuaduChecked != null && state.kuaduChecked.isNotEmpty) {
      conditons.add(DingKuadu(state.kuaduChecked));
    }

    if (state.dingErMaChecked != null && state.dingErMaChecked.isNotEmpty) {
      conditons.add(DingErMa(state.dingErMaChecked));
    }

    if (state.shaErMaChecked != null && state.shaErMaChecked.isNotEmpty) {
      conditons.add(ShaErMa(state.shaErMaChecked));
    }

    if (state.duanzu1Checked.isNotEmpty &&
        state.duanzu2Checked.isNotEmpty &&
        state.duanzu3Checked.isNotEmpty) {
      conditons.add(Duanzu(
          state.duanzu1Checked, state.duanzu2Checked, state.duanzu3Checked));
    }

    print("rongcuo:"+state.rongcuoChecked.toString());

    Result<List<String>> result;
    if (state.rongcuoChecked.isEmpty) {
      result =  filterAppService.runFilter(
          List.of(DanMaSource.getZuXuanSource()), conditons);
    } else {
      result =  filterAppService.runRongCuoFilter(
          List.of(DanMaSource.getZuXuanSource()),
          conditons,
          state.rongcuoChecked);
    }
    List<String> data = result.data;

    if (!state.isZu3Checked) {
      Result<List<String>> r =  filterAppService.nozu3(data);
      data = r.data;
    }

    if (!state.isZu6Checked) {
      Result<List<String>> r =  filterAppService.nozu6(data);
      data = r.data;
    }
    if (!state.isZZZChecked) {
      Result<List<String>> r =  filterAppService.nozzz(data);
      data = r.data;
    }

    var newState = state.clone();
    newState.controller.text = _getFilterResultString(data);

    print("filter res:"+data.toString());

    return newState;
  }

  String _getFilterResultString(List<String> filteredSource) {
    if (filteredSource.isNotEmpty) {
     String  ret= filteredSource.toString() + "\n(${filteredSource.length}注)\n\n";
     for(int i=0;i<10;i++){
       ret=ret+"$i:${_count(filteredSource,"$i")}\n";
     }

     return ret;

    }
    return "点击开始缩水";
  }

  int _count(List<String> filteredSource,String num){
   int sum=0;
   filteredSource.forEach((element) {
     if(element.contains(num)){
       sum+=1;
     }
   });

   return sum;
  }
}
