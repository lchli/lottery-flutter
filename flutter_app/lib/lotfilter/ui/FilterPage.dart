import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/lotfilter/blocs/FilterBloc.dart';
import 'package:flutterapp/lotfilter/blocs/FilterEvent.dart';
import 'package:flutterapp/lotfilter/blocs/FilterState.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaSource.dart';
import 'package:flutterapp/lotfilter/ui/DanMaPredicate.dart';

import 'ChooseDanMaPage.dart';

class FilterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FilterPageState();
  }
}

class _FilterPageState extends State<FilterPage> {
  final FilterBloc _bloc = FilterBloc();

  @override
  void dispose() {
    print("bloc dispose");
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
        cubit: _bloc,
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text("缩水"),
              ),
              body: new Column(
                children: <Widget>[
                  new Row(children: <Widget>[
                    Text("定胆码", style: _getTipsTitleTextStyle()),
                    _paddingRight(),
                    _addContainer(Text(state?.danmasChecked?.toString()),
                        () async {
                      List<String> checkedList = await Navigator.of(context)
                          .push(ChooseDanMaPage.route(
                              ChooseDanMaPage.dan_ma,
                              DanMaSource.getDanMaSource(),
                              state.danmasChecked));

                      if (checkedList != null) {
                        _bloc.add(DingDanMaChangedEvent(checkedList));
                      }
                    })
                  ]),
                  Divider(),
                  new Row(children: <Widget>[
                    Text("杀    码", style: _getTipsTitleTextStyle()),
                    _paddingRight(),
                    _addContainer(Text(state.shamasChecked?.toString()),
                        () async {
                      List<String> checkedList = await Navigator.of(context)
                          .push(ChooseDanMaPage.route(
                              ChooseDanMaPage.sha_ma,
                              DanMaSource.getDanMaSource(),
                              state.shamasChecked));

                      if (checkedList != null) {
                        _bloc.add(ShaMaChangedEvent(checkedList));
                      }
                    })
                  ]),
                  Divider(),
                  new Row(children: <Widget>[
                    Text("定和尾", style: _getTipsTitleTextStyle()),
                    _paddingRight(),
                    _addContainer(Text(state.heweiChecked.toString()),
                        () async {
                      List<String> checkedList = await Navigator.of(context)
                          .push(ChooseDanMaPage.route(
                              ChooseDanMaPage.hewei,
                              DanMaSource.getDanMaSource(),
                              state.heweiChecked));

                      if (checkedList != null) {
                        _bloc.add(HeWeiChangedEvent(checkedList));
                      }
                    })
                  ]),
                  Divider(),
                  new Row(children: <Widget>[
                    Text("定跨度", style: _getTipsTitleTextStyle()),
                    _paddingRight(),
                    _addContainer(Text(state.kuaduChecked.toString()),
                        () async {
                      List<String> checkedList = await Navigator.of(context)
                          .push(ChooseDanMaPage.route(
                              ChooseDanMaPage.kuadu,
                              DanMaSource.getDanMaSource(),
                              state.kuaduChecked));

                      if (checkedList != null) {
                        _bloc.add(KuaduChangedEvent(checkedList));
                      }
                    })
                  ]),
                  Divider(),
                  new Row(children: <Widget>[
                    Text("定二码", style: _getTipsTitleTextStyle()),
                    _paddingRight(),
                    _addContainer(Text(state.dingErMaChecked.toString()),
                        () async {
                      List<String> checkedList = await Navigator.of(context)
                          .push(ChooseDanMaPage.route(
                              ChooseDanMaPage.ding_er_ma,
                              DanMaSource.getErMaSource(),
                              state.dingErMaChecked));

                      if (checkedList != null) {
                        _bloc.add(DingErMaChangedEvent(checkedList));
                      }
                    })
                  ]),
                  Divider(),
                  new Row(children: <Widget>[
                    Text("杀二码", style: _getTipsTitleTextStyle()),
                    _paddingRight(),
                    _addContainer(Text(state.shaErMaChecked.toString()),
                        () async {
                      List<String> checkedList = await Navigator.of(context)
                          .push(ChooseDanMaPage.route(
                              ChooseDanMaPage.sha_er_ma,
                              DanMaSource.getErMaSource(),
                              state.shaErMaChecked));

                      if (checkedList != null) {
                        _bloc.add(ShaErMaChangedEvent(checkedList));
                      }
                    })
                  ]),
                  Divider(),
                  new Row(children: <Widget>[
                    Text("断    组", style: _getTipsTitleTextStyle()),
                    _paddingRight(),
                    _addContainer(Text(state.duanzu1Checked.toString()),
                        () async {
                      List<String> checkedList = await Navigator.of(context)
                          .push(ChooseDanMaPage.route(
                              ChooseDanMaPage.duanzu_1,
                              DanMaSource.getDanMaSource(),
                              state.duanzu1Checked));

                      if (checkedList != null) {
                        _bloc.add(DuanZu1ChangedEvent(checkedList));
                      }
                    }),
                    _addContainer(Text(state.duanzu2Checked.toString()),
                        () async {
                      List<String> checkedList = await Navigator.of(context)
                          .push(ChooseDanMaPage.route(
                              ChooseDanMaPage.duanzu_2,
                              DanMaSource.getDanMaSource(),
                              state.duanzu2Checked));

                      if (checkedList != null) {
                        _bloc.add(DuanZu2ChangedEvent(checkedList));
                      }
                    }),
                    _addContainer(Text(state.duanzu3Checked.toString()),
                        () async {
                      List<String> checkedList = await Navigator.of(context)
                          .push(ChooseDanMaPage.route(
                              ChooseDanMaPage.duanzu_3,
                              DanMaSource.getDanMaSource(),
                              state.duanzu3Checked));

                      if (checkedList != null) {
                        _bloc.add(DuanZu3ChangedEvent(checkedList));
                      }
                    })
                  ]),
                  Divider(),
                  Row(children: <Widget>[
                    Checkbox(
                      value: state.isZu6Checked,
                      onChanged: (v) => _bloc.add(Zu6ChangedEvent(v)),
                    ),
                    Text("组六"),
                    Checkbox(
                      value: state.isZu3Checked,
                      onChanged: (v) => _bloc.add(Zu3ChangedEvent(v)),
                    ),
                    Text("组三"),
                    Checkbox(
                      value: state.isZZZChecked,
                      onChanged: (v) => _bloc.add(BaoZiChangedEvent(v)),
                    ),
                    Text("豹子"),
                  ]),
                  Text("容错设置："),
                  Container(
                      child: Expanded(
                          child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: false,
                    children: _getRongCuoWidget(state),
                  ))),
                  RaisedButton(
                    onPressed: () {
                      _bloc.add(StartFilterEvent());
                      //_filterVM.startFilter();
                    },
                    child: new Text('开始缩水'),
                  ),
                  RaisedButton(
                    onPressed: () {

                      Navigator.of(context)
                          .push(MaterialPageRoute<void>(
                          builder: (_) => DanMaPredicate()));
                    },
                    child: new Text('胆码预测'),
                  ),
                  Expanded(
                      flex: 5,
                      child: Center(
                          child: TextField(
                        controller: state.controller,
                        maxLines: 10000,
                        readOnly: true,
                      )))
                ],
              ));
        });
  }

  List<Widget> _getRongCuoWidget(FilterState state) {
    List<Widget> widgets = [];
    for (int i = 0; i <= _getConditionCount(state); i++) {
      widgets.add(Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Checkbox(
            value: state.rongcuoChecked.contains(i),
            onChanged: (v) => onChangedImpl(v, i),
          ),
          Text("$i")
        ],
      ));
    }

    return widgets;
  }

  int _getConditionCount(FilterState state) {
    int ct = 0;
    if (state.danmasChecked.isNotEmpty) {
      ct += 1;
    }
    if (state.shamasChecked.isNotEmpty) {
      ct += 1;
    }
    if (state.heweiChecked.isNotEmpty) {
      ct += 1;
    }
    if (state.kuaduChecked.isNotEmpty) {
      ct += 1;
    }
    if (state.dingErMaChecked.isNotEmpty) {
      ct += 1;
    }
    if (state.shaErMaChecked.isNotEmpty) {
      ct += 1;
    }

    if (state.duanzu1Checked.isNotEmpty &&
        state.duanzu2Checked.isNotEmpty &&
        state.duanzu3Checked.isNotEmpty) {
      ct += 1;
    }

    return ct;
  }

  TextStyle _getTipsTitleTextStyle() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  Widget _addContainer(Widget input, GestureTapCallback onTapImp) {
    return Expanded(child: GestureDetector(child: input, onTap: onTapImp));
  }

  Widget _paddingRight() {
    return Padding(padding: EdgeInsets.only(right: 30));
  }

  onChangedImpl(bool v, int index) {
    if (v) {
      _bloc.add(AddRongCuoEvent(index));
    } else {
      _bloc.add(RemoveRongCuoEvent(index));
    }
  }
}
