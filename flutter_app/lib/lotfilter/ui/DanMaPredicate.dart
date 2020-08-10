import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaPreBloc.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaPreEvent.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaPreState.dart';

class DanMaPredicate extends StatefulWidget {
  @override
  State createState() {
    return _State();
  }
}

class _State extends State<DanMaPredicate> {
  DanMaPreBloc _bloc = DanMaPreBloc(DanMaPreState(TextEditingController(),TextEditingController(),TextEditingController(),
      DanMaPreState.rongcuo01,TextEditingController(),TextEditingController()," ",TextEditingController()));


  @override
  void dispose() {
    print("bloc dispose");
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DanMaPreBloc, DanMaPreState>(
      cubit: _bloc,
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
            title: Text("胆码预测"),
        ),body: Column(children: <Widget>[TextField(
          controller: state.preKaiJiangHaoController,
          decoration: new InputDecoration(
            hintText: '输入上期开奖号',
          ),
        ),TextField(
          maxLines: 2,
          controller: state.simao1Controller,
          decoration: new InputDecoration(
            hintText: '四码等于01格式3805/3576/678,[除以0.618得前四码；差5对码得四码；神仙姐姐断组得四码]',
          ),
        ),TextField(
          controller: state.duanzuSourceController,
          maxLines: 3,
          decoration: new InputDecoration(
            hintText: '输入断组123/456/789*578/689/1236',

          ),
        ),TextField(
          controller: state.danmaListController,
          maxLines: 2,
          decoration: new InputDecoration(
            hintText: '输入胆码123/456/789',

          ),
        ), Row(children: <Widget>[
          Radio<String>(
              value: DanMaPreState.rongcuo01,
              groupValue: state.groupValue,
              onChanged: (value) {
                _bloc.add(RongCuoChangedEvent(value));
              }),
          Text("容错01"),
          Radio<String>(
              value: DanMaPreState.rongcuo12,
              groupValue: state.groupValue,
              onChanged: (value) {
                _bloc.add(RongCuoChangedEvent(value));
              }),
          Text("容错12"),
        ]), RaisedButton(
          onPressed: () {
            _bloc.add(DanMaPreEvent());
          },
          child: new Text('开始预测'),
        ),Text(state.dudan),
          Expanded(child:TextField(controller: state.resultController,readOnly: true,maxLines: 100,
        ))],));
      },
    );
  }
}
