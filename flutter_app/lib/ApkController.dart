import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';



class ApkController extends GetxController{
  var list="22222".obs;


  @override
  void onReady() {
    super.onReady();
    loadResult();
  }



  loadResult() async {
    var ret = await mock();
    list.value=ret;
  }

  Future<String> mock() async {
    var result = await Process.run('ls', ['-l']);
    print(result.stdout);
    return result.stdout;
  }

}