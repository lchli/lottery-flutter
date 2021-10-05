import 'package:bloc/bloc.dart';
import 'package:flutterapp/lotfilter/domain/DanMaRepo.dart';
import 'package:flutterapp/lotfilter/models.dart';

import 'DanMaPre1State.dart';
import 'SettingState.dart';
import 'blocs/DanPreUtils.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(this._danMaRepo) : super(SettingState(SettingState.loading));
  DanMaRepo _danMaRepo;

  importHis(String numbers) async {
    var list = await   _danMaRepo.importHistory(numbers);

    emit(SettingState(SettingState.finish));
  }

}
