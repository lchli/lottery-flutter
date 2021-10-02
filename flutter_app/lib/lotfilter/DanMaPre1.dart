import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DanMaPre1Cubit.dart';
import 'DanMaPre1State.dart';
import 'models.dart';

class DanMaPre1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return BlocProvider<DanMaPre1Cubit>(
     create: (_) => DanMaPre1Cubit(DanMaPre1State([]))..loadResult(),
     child:  DataTableDemo(),
   );
  }


}





class DataTableDemo extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('胆码预测一'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          BlocBuilder<DanMaPre1Cubit, DanMaPre1State>(
            builder: (context, state) {
              return   PaginatedDataTable(
               // header: Text('Header Text'),
                showCheckboxColumn: false,
               rowsPerPage: 20,
                columns: [
                  DataColumn(label: Text('期号')),
                  DataColumn(label: Text('开奖号')),
                  DataColumn(label: Text('预测号')),
                  DataColumn(label: Text('结果')),
                ],
                source: _DataSource(context,state.list),
              );
            },
          ),

        ],
      ),
    );
  }
}


class _DataSource extends DataTableSource {
  _DataSource(this.context,this._rows) {

  }

  final BuildContext context;
  List<KjRow> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      //selected: row.selected,
      onSelectChanged: (value) {
        // if (row.selected != value) {
        //   _selectedCount += value ? 1 : -1;
        //   assert(_selectedCount >= 0);
        //   row.selected = value;
        //   notifyListeners();
        // }
      },
      cells: [
        DataCell(Text(row.qiHao)),
        DataCell(Text(row.kjHao)),
        DataCell(Text(row.pre)),
        DataCell(Text(row.result,style:TextStyle(color: Color(0xFFDC143C)))),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}