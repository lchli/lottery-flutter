import 'package:flutterapp/user/domain/User.dart';

import 'ResultDto.dart';

abstract class UserAppService{//api
  Future<Result<User>> register(String name,String pwd);
  Future<Result<User>> updateUser(User newUser);
  Future<Result<User>> login(String name,String pwd);
  Future<Result<User>> getUserInfo(String userId);

  Future<Result<User>> getLoginUserSession();
  Future<Result<void>> saveLoginUserSession(User session);
  Future<Result<void>> clearLoginUserSession();
}