import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaHistoryBloc.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaHistoryState.dart';
import 'package:flutterapp/lotfilter/blocs/DanMaHistroyEvent.dart';

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



  Widget _buildRow(HistroyRow item, BuildContext context) {
    return new ListTile(
      title: new Row(
        children: <Widget>[Text(item.qiHao),Padding(padding: EdgeInsets.only(left: 10)),Text(item.kaiJiangHao),
          Padding(padding: EdgeInsets.only(left: 50)),
          Text(item.duDan1,style:TextStyle(color: item.duDan1Color)),Text(item.ciDan1, style: TextStyle(color: item.ciDan1Color)),
          Padding(padding: EdgeInsets.only(left: 40)),
          Text(item.duDan2,style:TextStyle(color: item.duDan2Color)),Text(item.ciDan2, style: TextStyle(color: item.ciDan2Color)),
          Padding(padding: EdgeInsets.only(left: 40)),
          Text(item.duDan3,style:TextStyle(color: item.duDan3Color)),Text(item.ciDan3, style: TextStyle(color:item.ciDan3Color)),
        ],
         )
    );
  }

}
