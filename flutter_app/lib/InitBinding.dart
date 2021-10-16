import 'package:flutterapp/lotfilter/infra/DanMaRepoImpl.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'lotfilter/domain/DanMaRepo.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DanMaRepo>(DanMaRepoImpl());
  }
}