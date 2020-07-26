import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/lotfilter/vm/FilterVM.dart';
import 'package:provider/provider.dart';

class ChooseDanMaPage extends StatelessWidget {
  FilterVM _filterVM;
  int _requestCode;
  static const int dan_ma = 1;
  static const int sha_ma = 2;
  static const int hewei = 3;
  static const int kuadu = 4;
  static const int ding_er_ma = 5;
  static const int sha_er_ma = 6;

  static const int duanzu_1 = 7;
  static const int duanzu_2 = 8;
  static const int duanzu_3 = 9;

  ChooseDanMaPage(this._requestCode);

  @override
  Widget build(BuildContext context) {
    if (_filterVM == null) {
      _filterVM = Provider.of<FilterVM>(context, listen: true);
    }

    return Scaffold(
        body: _body(context),
        appBar: AppBar(
          title: Text("请选择"),
          actions: <Widget>[
            GestureDetector(
              child: Center(child: Text("清空选中")),
              onTap: () {
                _clearChecked();
              },
            ),
          ],
        ));
  }

  Widget _body(BuildContext context) {
    return GridView.count(
      crossAxisCount: 5,
      children: List.generate(_gridCount(), (index) {
        return Row(
          children: <Widget>[
            Checkbox(
              value: _isChecked(index),
              onChanged: (v) => onChangedImpl(v, index),
            ),
            Text(_text(index))
          ],
        );
      }),
    );
  }

  int _gridCount(){
    if(_requestCode==ding_er_ma||_requestCode==sha_er_ma){
      return _filterVM.ermas.length;
    }
    return _filterVM.danmas.length;
  }

  String _text(int index){
    if(_requestCode==ding_er_ma||_requestCode==sha_er_ma){
      return _filterVM.ermas[index];
    }
    return _filterVM.danmas[index];
  }

  bool _isChecked(int index) {
    switch (_requestCode) {
      case dan_ma:
        return _filterVM.danmasChecked.contains(_filterVM.danmas[index]);
      case sha_ma:
        return _filterVM.shamaChecked.contains(_filterVM.danmas[index]);
      case hewei:
        return _filterVM.heweiChecked.contains(_filterVM.danmas[index]);
      case kuadu:
        return _filterVM.kuaduChecked.contains(_filterVM.danmas[index]);
        case ding_er_ma:
        return _filterVM.dingErMaChecked.contains(_filterVM.ermas[index]);
        case sha_er_ma:
        return _filterVM.shaErMaChecked.contains(_filterVM.ermas[index]);
        case duanzu_1:
        return _filterVM.duanzu1Checked.contains(_filterVM.danmas[index]);
        case duanzu_2:
        return _filterVM.duanzu2Checked.contains(_filterVM.danmas[index]);
      case duanzu_3:
        return _filterVM.duanzu3Checked.contains(_filterVM.danmas[index]);
    }

    return false;
  }

  onChangedImpl(bool v, int index) {
    switch (_requestCode) {
      case dan_ma:
        if (v) {
          _filterVM.addToDanMaChecked(index);
        } else {
          _filterVM.removeFromDanMaChecked(index);
        }
        break;
      case sha_ma:
        if (v) {
          _filterVM.addToShaMaChecked(index);
        } else {
          _filterVM.removeFromShaMaChecked(index);
        }
        break;
      case hewei:
        if (v) {
          _filterVM.addToHeweiChecked(index);
        } else {
          _filterVM.removeFromHeweiChecked(index);
        }
        break;
      case kuadu:
        if (v) {
          _filterVM.addToKuaduChecked(index);
        } else {
          _filterVM.removeFromKuaduChecked(index);
        }
        break;
      case ding_er_ma:
        if (v) {
          _filterVM.addToDingErMaChecked(index);
        } else {
          _filterVM.removeFromDingErMaChecked(index);
        }
        break;
      case sha_er_ma:
        if (v) {
          _filterVM.addToShaErMaChecked(index);
        } else {
          _filterVM.removeFromShaErMaChecked(index);
        }
        break;
      case duanzu_1:
        if (v) {
          _filterVM.addToDuanzu1Checked(index);
        } else {
          _filterVM.removeFromDuanzu1Checked(index);
        }
        break;
      case duanzu_2:
        if (v) {
          _filterVM.addToDuanzu2Checked(index);
        } else {
          _filterVM.removeFromDuanzu2Checked(index);
        }
        break;
      case duanzu_3:
        if (v) {
          _filterVM.addToDuanzu3Checked(index);
        } else {
          _filterVM.removeFromDuanzu3Checked(index);
        }
        break;
    }
  }

  void _clearChecked() {
    switch (_requestCode) {
      case dan_ma:
        _filterVM.clearDanMaChecked();
        break;
      case sha_ma:
        _filterVM.clearShaMaChecked();
        break;
      case hewei:
        _filterVM.clearHeweiChecked();
        break;
      case kuadu:
        _filterVM.clearKuaduChecked();
        break;
      case ding_er_ma:
        _filterVM.clearDingErMaChecked();
        break;
      case sha_er_ma:
      _filterVM.clearShaErMaChecked();
      break;
      case duanzu_1:
        _filterVM.clearDuanzu1Checked();
        break;
      case duanzu_2:
        _filterVM.clearDuanzu2Checked();
        break;
      case duanzu_3:
        _filterVM.clearDuanzu3Checked();
        break;
    }
  }
}
