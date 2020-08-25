abstract class FilterEvent {}

class DingDanMaChangedEvent extends FilterEvent {
  final List<String> checked;

  DingDanMaChangedEvent([this.checked = const []]);
}

class ShaMaChangedEvent extends FilterEvent {
  final List<String> checked;

  ShaMaChangedEvent([this.checked = const []]);
}

class HeWeiChangedEvent extends FilterEvent {
  final List<String> checked;

  HeWeiChangedEvent([this.checked = const []]);
}

class KuaduChangedEvent extends FilterEvent {
  final List<String> checked;

  KuaduChangedEvent([this.checked = const []]);
}

class DingErMaChangedEvent extends FilterEvent {
  final List<String> checked;

  DingErMaChangedEvent([this.checked = const []]);
}

class ShaErMaChangedEvent extends FilterEvent {
  final List<String> checked;

  ShaErMaChangedEvent([this.checked = const []]);
}

class DuanZu1ChangedEvent extends FilterEvent {
  final List<String> checked;

  DuanZu1ChangedEvent([this.checked = const []]);
}

class DuanZu2ChangedEvent extends FilterEvent {
  final List<String> checked;

  DuanZu2ChangedEvent([this.checked = const []]);
}

class DuanZu3ChangedEvent extends FilterEvent {
  final List<String> checked;

  DuanZu3ChangedEvent([this.checked = const []]);
}

class Zu6ChangedEvent extends FilterEvent {
  final bool checked;

  Zu6ChangedEvent(this.checked);
}

class Zu3ChangedEvent extends FilterEvent {
  final bool checked;

  Zu3ChangedEvent(this.checked);
}

class BaoZiChangedEvent extends FilterEvent {
  final bool checked;

  BaoZiChangedEvent(this.checked);
}

class StartFilterEvent extends FilterEvent {}

class AddRongCuoEvent extends FilterEvent {
  final int val;

  AddRongCuoEvent(this.val);
}

class RemoveRongCuoEvent extends FilterEvent {
  final int val;

  RemoveRongCuoEvent(this.val);
}
class ImportHisEvent extends FilterEvent {


  ImportHisEvent();
}
