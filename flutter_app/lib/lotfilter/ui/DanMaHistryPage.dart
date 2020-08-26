import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaHistoryBloc.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaHistoryState.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaHistroyEvent.dart';
import 'package:flutterapp/lotfilter/domain/Utils.dart';

class DanMaHistryPage extends StatefulWidget {


  static Route route() {
    return MaterialPageRoute(
        builder: (_) => DanMaHistryPage());
  }

  @override
  State createState() {
    return _DanMaHistryPageSt();
  }
}

class _DanMaHistryPageSt extends State<DanMaHistryPage> {

  final _bloc = DanMaHistoryBloc();

  _DanMaHistryPageSt();

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    _bloc.add(DanMaHistroyEvent());
  }

  @override
  void dispose() {
    print("bloc dispose");
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DanMaHistoryBloc, DanMaHistoryState>(
        cubit: _bloc,
        builder: (context, state) {
          return Scaffold(
              body: _body(context, state),
              appBar: AppBar(
                title: Text("胆码历史记录"),
              ));
        });
  }

  Widget _body(BuildContext context, DanMaHistoryState state) {
    int itemcount=state.histroyRows!=null?state.histroyRows.length:0;

    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: itemcount, //数据的数量
      itemBuilder: (context, i) {
        return _buildRow(state.histroyRows[i], context);
      },
    );
  }

  Color _selectedColor = Color(0xFFDC143C);
  Color _normalColor = Color(0xFF000000);

  Widget _buildRow(HistroyRow item, BuildContext context) {
    return new ListTile(
      title: new Row(
        children: <Widget>[Text(item.qiHao),Padding(padding: EdgeInsets.only(left: 10)),Text(item.kaiJiangHao),
          Padding(padding: EdgeInsets.only(left: 20)),
          Text(item.duDan1,style:TextStyle(color: _getTextColor(item.duDan1,item))),Text(item.ciDan1, style: TextStyle(color: _getTextColor(item.ciDan1,item))),
          Padding(padding: EdgeInsets.only(left: 10)),
          Text(item.duDan2,style:TextStyle(color:_getTextColor(item.duDan2,item))),Text(item.ciDan2, style: TextStyle(color: _getTextColor(item.ciDan2,item))),
          Padding(padding: EdgeInsets.only(left: 10)),
          Text(item.duDan3,style:TextStyle(color: _getTextColor(item.duDan3,item))),Text(item.ciDan3, style: TextStyle(color:_getTextColor(item.ciDan3,item))),
          Padding(padding: EdgeInsets.only(left: 10)),
          Text(item.hewei0,style:TextStyle(color: _getHeweiTextColor(item.hewei0,item))),Text(item.hewei1, style: TextStyle(color:_getHeweiTextColor(item.hewei1,item))),
          Text(item.hewei2,style:TextStyle(color: _getHeweiTextColor(item.hewei2,item))),Text(item.hewei3, style: TextStyle(color:_getHeweiTextColor(item.hewei3,item))),
          Text(item.hewei4,style:TextStyle(color: _getHeweiTextColor(item.hewei4,item))),
          Padding(padding: EdgeInsets.only(left: 10)),
          Text(item.kuadu0,style:TextStyle(color: _getKuaduTextColor(item.kuadu0,item))),Text(item.kuadu1, style: TextStyle(color:_getKuaduTextColor(item.kuadu1,item))),
          Text(item.kuadu2,style:TextStyle(color: _getKuaduTextColor(item.kuadu2,item))),Text(item.kuadu3, style: TextStyle(color:_getKuaduTextColor(item.kuadu3,item))),
          Text(item.kuadu4,style:TextStyle(color: _getKuaduTextColor(item.kuadu4,item))),
        ],
         )
    );
  }

  Color _getTextColor(String number,HistroyRow item){
    if(item.qiHao=="期号"||item.qiHao=="0000000"){
      return _normalColor;
    }
    if(item.kaiJiangHao.contains(number)){
      return _selectedColor;
    }
    return _normalColor;
  }

  Color _getHeweiTextColor(String number,HistroyRow item){
    if(item.qiHao=="期号"||item.qiHao=="0000000"){
      return _normalColor;
    }
   String hewei=Utils.getItemHeWei(item.kaiJiangHao);

    if(hewei==number){
      return _selectedColor;
    }
    return _normalColor;
  }

  Color _getKuaduTextColor(String number,HistroyRow item){
    if(item.qiHao=="期号"||item.qiHao=="0000000"){
      return _normalColor;
    }
    String kuadu=Utils.getItemKuadu(item.kaiJiangHao);

    if(kuadu==number){
      return _selectedColor;
    }
    return _normalColor;
  }
}
