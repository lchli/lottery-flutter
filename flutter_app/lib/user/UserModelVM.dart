import 'package:flutter/foundation.dart';
import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/client/UserAppService.dart';

import '../main.dart';
import 'domain/User.dart';

class UserModelVM extends ChangeNotifier {
  UserAppService _userAppService = MyApp.provideUserAppService();
  User _user;


  User get user => _user;

  Future<Result<User>> register(String account, String pwd) {
    return _userAppService.register(account, pwd);
  }

  Future<Result<User>> login(String account, String pwd) {
    return _userAppService.login(account, pwd);
  }

  Future<Result<void>> saveUserSession(User se) {
    _user = se;

    notifyListeners();

    return _userAppService.saveLoginUserSession(se);
  }

  Future<Result<User>> getUserSession() {
    return _userAppService.getLoginUserSession();
  }

  void loadUserSession() async {
    Result<User> res = await getUserSession();
    User data = res.data;
    _user = data;

    notifyListeners();
  }

  Future<Result<void>> clearLoginUserSession(){
    return _userAppService.clearLoginUserSession();
  }


}
