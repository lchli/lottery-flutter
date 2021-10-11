import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/lotfilter/DanMaPre1Controller.dart';
import 'package:flutterapp/lotfilter/infra/DanMaRepoImpl.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';

import 'models.dart';

class DanMaPre1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


   return  DataTableDemo();
  }


}



class DataTableDemo extends StatelessWidget {
  Widget build(BuildContext context) {
    final DanMaPre1Controller c = Get.put(DanMaPre1Controller(DanMaRepoImpl()));

    return Scaffold(
      appBar: AppBar(
        title: Text('胆码预测一'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
        Obx(()=>PaginatedDataTable(
               // header: Text('Header Text'),
                showCheckboxColumn: false,
               rowsPerPage: 20,
                columns: [
                  DataColumn(label: Text('期号')),
                  DataColumn(label: Text('开奖号')),
                  DataColumn(label: Text('预测号')),
                  DataColumn(label: Text('结果')),
                ],
                source: _DataSource(c.list()),
              ))

        ],
      ),
    );
  }
}


class _DataSource extends DataTableSource {
  _DataSource(this.rows) ;


  List<KjRow> rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    if(rows==null){
      return null;
    }
    assert(index >= 0);
    if (index >= rows.length) return null;
    final row = rows[index];
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
  int get rowCount =>rows!=null? rows.length:0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}