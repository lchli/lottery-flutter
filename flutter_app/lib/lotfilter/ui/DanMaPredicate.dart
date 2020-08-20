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
      DanMaPreState.rongcuo01,TextEditingController(),TextEditingController()," ",TextEditingController(),true,
      TextEditingController(),TextEditingController()));


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
        ),body:SingleChildScrollView(child:ConstrainedBox(constraints: BoxConstraints(
          minHeight: 100,
        ), child:IntrinsicHeight(child:Column(children: <Widget>[TextField(
          controller: state.preKaiJiangHaoController,
          decoration: new InputDecoration(
            hintText: '输入上期开奖号',
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
        ),TextField(
          controller: state.heweiController,
          maxLines: 1,
          decoration: new InputDecoration(
            hintText: '输入和尾',

          ),
        ),TextField(
          controller: state.kuaduController,
          maxLines: 2,
          decoration: new InputDecoration(
            hintText: '输入跨度',

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
          Checkbox(
            value: state.sima01Checked,
            onChanged: (v) => _bloc.add(SiMa01ChangedEvent(v)),
          ),
          Text("是否使用四码01"),
        ]), RaisedButton(
          onPressed: () {
            _bloc.add(DanMaPreEvent());
          },
          child: new Text('开始预测'),
        ),Text(state.dudan),
          Expanded(child:TextField(controller: state.resultController,readOnly: true,maxLines: 100,
        ))],)))));
      },
    );
  }
}
