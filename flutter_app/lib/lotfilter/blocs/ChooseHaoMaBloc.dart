import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/lotfilter/blocs/ChooseHaoMaEvent.dart';
import 'package:flutterapp/lotfilter/blocs/ChooseHaoMaState.dart';
import 'package:flutterapp/lotfilter/ui/ChooseDanMaPage.dart';

import 'FilterEvent.dart';
import 'FilterState.dart';

class ChooseHaoMaBloc extends Bloc<ChooseHaoMaEvent, ChooseHaoMaState> {
  ChooseHaoMaBloc() : super(ChooseHaoMaState([],[],-1)){
    print("new ChooseHaoMaBloc");
  }

  @override
  Stream<ChooseHaoMaState> mapEventToState(ChooseHaoMaEvent event) async* {
    if (event is CheckedChangedEvent) {
      yield ChooseHaoMaState(state.source, event.checked,event.requestCode);
    }  else if (event is LoadSourceEvent) {
      yield ChooseHaoMaState(event.source, event.checked,event.requestCode);
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
