import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'models.dart';

class MainPageController extends GetxController{
  var currentIndex = 0.obs;

  setIndex(int index){
    currentIndex.value=index;
  }

}