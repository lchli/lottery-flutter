import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/lotfilter/client/FilterAppService.dart';
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
    String dan = _formatMa(state.danmasChecked);
    print(dan);
    if (dan != null && dan.isNotEmpty) {
      conditons.add(DingDanMa(dan));
    }

    String sha = _formatMa(state.shamasChecked);
    print(sha);
    if (sha != null && sha.isNotEmpty) {
      conditons.add(ShaDanMa(sha));
    }

    String hewei = _formatMa(state.heweiChecked);
    print(hewei);
    if (hewei != null && hewei.isNotEmpty) {
      conditons.add(DingHewei(hewei));
    }

    String kuadu = _formatMa(state.kuaduChecked);
    print(kuadu);
    if (kuadu != null && kuadu.isNotEmpty) {
      conditons.add(DingKuadu(kuadu));
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

    print(state.rongcuoChecked.toString());

    Result<List<String>> result;
    if (state.rongcuoChecked.isEmpty) {
      result = await filterAppService.runFilter(
          List.of(DanMaSource.getZuXuanSource()), conditons);
    } else {
      result = await filterAppService.runRongCuoFilter(
          List.of(DanMaSource.getZuXuanSource()),
          conditons,
          state.rongcuoChecked);
    }
    List<String> data = result.data;

    if (!state.isZu3Checked) {
      Result<List<String>> r = await filterAppService.nozu3(data);
      data = r.data;
    }

    if (!state.isZu6Checked) {
      Result<List<String>> r = await filterAppService.nozu6(data);
      data = r.data;
    }
    if (!state.isZZZChecked) {
      Result<List<String>> r = await filterAppService.nozzz(data);
      data = r.data;
    }

    var newState = state.clone();
    newState.controller.text = _getFilterResultString(data);

    return newState;
  }

  String _getFilterResultString(List<String> filteredSource) {
    if (filteredSource.isNotEmpty) {
      return filteredSource.toString() + "\n(${filteredSource.length}注)";
    }
    return "点击开始缩水";
  }
}
