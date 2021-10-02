import 'package:bloc/bloc.dart';
import 'package:flutterapp/lotfilter/models.dart';

import 'DanMaPre1State.dart';

class DanMaPre1Cubit extends Cubit<DanMaPre1State>{
  DanMaPre1Cubit(initialState) : super(initialState);

  loadResult() async{
   var list=await mock();

    emit(DanMaPre1State(list)) ;
  }

  Future<List<KjRow>> mock() async{
    List<KjRow> list=[];

    for(int i=0;i<100;i++){
      list.add(KjRow("111", "222", "23", "对"));
    }

    return list;
  }

}