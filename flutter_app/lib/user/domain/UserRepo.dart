import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/user/domain/User.dart';


abstract class UserRepo{
  Future<Result<User>> save(User user);
  Future<Result<User>> update(User user);
  Future<Result<User>> find(String name,String pwd);
  Future<Result<User>> findById(String userId,User se);
  Future<Result<User>> getLoginUserSession();
  Future<Result<void>> saveLoginUserSession(User session);
  Future<Result<void>> clearLoginUserSession();

}