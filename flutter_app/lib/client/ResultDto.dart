class Result<DATA>{
  String code;
  String msg;
  DATA data;

  Result({this.code,this.msg="",this.data});

  bool hasError(){
    return msg!=null&&msg!="";
  }
}