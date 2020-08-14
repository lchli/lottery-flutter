import 'package:flutter/cupertino.dart';

class DanMaPreEvent{

}

class RongCuoChangedEvent extends DanMaPreEvent{
  final String groupValue;

  RongCuoChangedEvent(this.groupValue);

}


class SiMa01ChangedEvent extends DanMaPreEvent{
  final bool checked;

  SiMa01ChangedEvent(this.checked);

}
