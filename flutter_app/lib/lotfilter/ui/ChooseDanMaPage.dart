import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/lotfilter/blocs/ChooseHaoMaBloc.dart';
import 'package:flutterapp/lotfilter/blocs/ChooseHaoMaEvent.dart';
import 'package:flutterapp/lotfilter/blocs/ChooseHaoMaState.dart';

class ChooseDanMaPage extends StatefulWidget {
  static const int dan_ma = 1;
  static const int sha_ma = 2;
  static const int hewei = 3;
  static const int kuadu = 4;
  static const int ding_er_ma = 5;
  static const int sha_er_ma = 6;

  static const int duanzu_1 = 7;
  static const int duanzu_2 = 8;
  static const int duanzu_3 = 9;

  final int _requestCode;
  final List<String> _source;
  final List<String> _checked;

  const ChooseDanMaPage(this._requestCode, this._source, this._checked,
      {Key key})
      : super(key: key);

  static Route<List<String>> route(
      int requestCode, List<String> source, final List<String> checked) {
    return MaterialPageRoute<List<String>>(
        builder: (_) => ChooseDanMaPage(requestCode, source, checked));
  }

  @override
  State createState() {
    return _ChooseDanMaPageSt(_requestCode, _source, _checked);
  }
}

class _ChooseDanMaPageSt extends State<ChooseDanMaPage> {
  int _requestCode;

  final List<String> _source;
  final List<String> _checked;
  final _bloc = ChooseHaoMaBloc();

  _ChooseDanMaPageSt(this._requestCode, this._source, this._checked);

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    _bloc.add(LoadSourceEvent(_source, _checked, _requestCode));
  }

  @override
  void dispose() {
    print("bloc dispose");
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseHaoMaBloc, ChooseHaoMaState>(
        cubit: _bloc,
        builder: (context, state) {
          return Scaffold(
              body: _body(context, state),
              appBar: AppBar(
                title: Text("请选择"),
                actions: <Widget>[
                  GestureDetector(
                    child: Center(child: Text("清空选中")),
                    onTap: () {
                      _bloc.add(CheckedChangedEvent([], _requestCode));
                      //_clearChecked();
                    },
                  ),
                  GestureDetector(
                    child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 10),
                        child: Center(child: Text("确定"))),
                    onTap: () {
                      Navigator.of(context).pop(state.checked);
                      //_clearChecked();
                    },
                  ),
                ],
              ));
        });
  }

  Widget _body(BuildContext context, ChooseHaoMaState state) {
    return GridView.count(
      crossAxisCount: 5,
      children: List.generate(state.source.length, (index) {
        return Row(
          children: <Widget>[
            Checkbox(
              value: state.checked.contains(state.source[index]),
              onChanged: (v) => onChangedImpl(v, state.source[index], state),
            ),
            Text(state.source[index])
          ],
        );
      }),
    );
  }

  onChangedImpl(bool v, String index, ChooseHaoMaState state) {
    List<String> prechecked = List.of(state.checked);
    if (v) {
      prechecked.add(index);
    } else {
      prechecked.remove(index);
    }

    _bloc.add(CheckedChangedEvent(prechecked, _requestCode));
  }
}
