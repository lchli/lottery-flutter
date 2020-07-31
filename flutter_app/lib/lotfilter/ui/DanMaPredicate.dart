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
  DanMaPreBloc _bloc = DanMaPreBloc(DanMaPreState(TextEditingController(),"",TextEditingController(),DanMaPreState.rongcuo01));


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
        ]),Text(state.result), RaisedButton(
          onPressed: () {
            _bloc.add(DanMaPreEvent());
          },
          child: new Text('开始预测'),
        ),],));
      },
    );
  }
}
