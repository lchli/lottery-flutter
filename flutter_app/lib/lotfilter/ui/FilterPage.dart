import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/lotfilter/vm/FilterVM.dart';
import 'package:provider/provider.dart';

import 'ChooseDanMaPage.dart';

class FilterPage extends StatelessWidget with WidgetsBindingObserver {
  FilterVM _filterVM;

  @override
  Widget build(BuildContext context) {
    if (_filterVM == null) {
      _filterVM = Provider.of<FilterVM>(context, listen: true);
      Provider.of<FilterVM>(context, listen: false).clearDanMaChecked();
      Provider.of<FilterVM>(context, listen: false).clearShaMaChecked();
      Provider.of<FilterVM>(context, listen: false).clearHeweiChecked();
      Provider.of<FilterVM>(context, listen: false).clearKuaduChecked();
      Provider.of<FilterVM>(context, listen: false).clearRongCuoChecked();
      Provider.of<FilterVM>(context, listen: false).resetFilteredSource();
      Provider.of<FilterVM>(context, listen: false).clearShaErMaChecked();

      Provider.of<FilterVM>(context, listen: false).clearDuanzu1Checked();
      Provider.of<FilterVM>(context, listen: false).clearDuanzu2Checked();
      Provider.of<FilterVM>(context, listen: false).clearDuanzu3Checked();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("缩水"),
        ),
        body: new Column(
          children: <Widget>[
            new Row(children: <Widget>[
              Text("定胆码", style: _getTipsTitleTextStyle()),
              _paddingRight(),
              _addContainer(Text(_filterVM.getDanMaCheckedString()), () {
                _filterVM.showChooseDanMa(context, ChooseDanMaPage.dan_ma);
              })
            ]),
            Divider(),
            new Row(children: <Widget>[
              Text("杀    码", style: _getTipsTitleTextStyle()),
              _paddingRight(),
              _addContainer(Text(_filterVM.getShaMaCheckedString()), () {
                _filterVM.showChooseDanMa(context, ChooseDanMaPage.sha_ma);
              })
            ]),
            Divider(),
            new Row(children: <Widget>[
              Text("定和尾", style: _getTipsTitleTextStyle()),
              _paddingRight(),
              _addContainer(Text(_filterVM.getHeweiCheckedString()), () {
                _filterVM.showChooseDanMa(context, ChooseDanMaPage.hewei);
              })
            ]),
            Divider(),
            new Row(children: <Widget>[
              Text("定跨度", style: _getTipsTitleTextStyle()),
              _paddingRight(),
              _addContainer(Text(_filterVM.getKuduCheckedString()), () {
                _filterVM.showChooseDanMa(context, ChooseDanMaPage.kuadu);
              })
            ]),
            Divider(),
            new Row(children: <Widget>[
              Text("定二码", style: _getTipsTitleTextStyle()),
              _paddingRight(),
              _addContainer(Text(_filterVM.getDingErMaCheckedString()), () {
                _filterVM.showChooseDanMa(context, ChooseDanMaPage.ding_er_ma);
              })
            ]),
            Divider(),
            new Row(children: <Widget>[
              Text("杀二码", style: _getTipsTitleTextStyle()),
              _paddingRight(),
              _addContainer(Text(_filterVM.getShaErMaCheckedString()), () {
                _filterVM.showChooseDanMa(context, ChooseDanMaPage.sha_er_ma);
              })
            ]),
            Divider(),
            new Row(children: <Widget>[
              Text("断    组", style: _getTipsTitleTextStyle()),
              _paddingRight(),
              _addContainer(Text(_filterVM.getDuanzu1CheckedString()), () {
                _filterVM.showChooseDanMa(context, ChooseDanMaPage.duanzu_1);
              }),
              _addContainer(Text(_filterVM.getDuanzu2CheckedString()), () {
                _filterVM.showChooseDanMa(context, ChooseDanMaPage.duanzu_2);
              }),
              _addContainer(Text(_filterVM.getDuanzu3CheckedString()), () {
                _filterVM.showChooseDanMa(context, ChooseDanMaPage.duanzu_3);
              })
            ]),
            Divider(),
            Row(children: <Widget>[ Checkbox(
              value: _filterVM.isZu6Checked,
              onChanged: (v) => _filterVM.setZu6(v),
            ),
              Text("组六"),Checkbox(
                value: _filterVM.isZu3Checked,
                onChanged: (v) => _filterVM.setZu3(v),
              ),
              Text("组三"),Checkbox(
                value: _filterVM.isZZZChecked,
                onChanged: (v) => _filterVM.setZZZ(v),
              ),
              Text("豹子"),]),
            Text("容错设置："),
            Row(children: _getRongCuoWidget()),
            RaisedButton(
              onPressed: () {
                _filterVM.startFilter();
              },
              child: new Text('开始缩水'),
            ),
    Expanded(child:Center(
                child: TextField(controller: _filterVM.controller,maxLines: 10000,readOnly: true,)))
          ],
        ));
  }

  List<Widget> _getRongCuoWidget(){
    List<Widget> widgets=[];
    for(int i=0;i<=_filterVM.getConditionCount();i++){
      widgets.add( Row(
        children: <Widget>[
          Checkbox(
            value: _isChecked(i),
            onChanged: (v) => onChangedImpl(v, i),
          ),
          Text("$i")
        ],
      ));
    }

    return widgets;

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
    if(v){
      _filterVM.addRongCuo(index);
    }else{
      _filterVM.removeRongCuo(index);
    }

  }

  _isChecked(int index) {
    return _filterVM.rongcuoChecked.contains(index);
  }
}
