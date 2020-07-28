abstract class ChooseHaoMaEvent{

}

class LoadSourceEvent extends ChooseHaoMaEvent{
  final  List<String> source;
  final  List<String> checked;
  final int requestCode;

  LoadSourceEvent(this.source,this.checked, this.requestCode);


}


class CheckedChangedEvent extends ChooseHaoMaEvent{

  final  List<String> checked;
  final int requestCode;

  CheckedChangedEvent(this.checked, this.requestCode);


}