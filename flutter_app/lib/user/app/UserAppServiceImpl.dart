import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/client/UserAppService.dart';
import 'package:flutterapp/user/domain/User.dart';
import 'package:flutterapp/user/domain/UserRepo.dart';

class UserAppServiceImpl with UserAppService {
  //api
  UserRepo _userRepo;

  UserAppServiceImpl(this._userRepo);

  @override
  Future<Result<User>> register(String name, String pwd) async {
    User user = User();
    user.name = name;
    user.pwd = pwd;

    return _userRepo.save(user);
  }

  @override
  Future<Result<User>> updateUser(User newUser) {
    return _userRepo.update(newUser);
  }

  @override
  Future<Result<User>> getUserInfo(String userId) async {
    Result<User> ret = Result<User>();
    Result<User> se = await _userRepo.getLoginUserSession();
    if (se == null || se.data == null) {
      ret.msg = "未登录";
      return ret;
    }

    return _userRepo.findById(userId, se.data);
  }

  @override
  Future<Result<User>> login(String name, String pwd) {
    return _userRepo.find(name, pwd);
  }

  @override
  Future<Result<User>> getLoginUserSession() {
    return _userRepo.getLoginUserSession();
  }

  @override
  Future<Result<Function>> saveLoginUserSession(User session) {
    return _userRepo.saveLoginUserSession(session);
  }

  @override
  Future<Result<void>> clearLoginUserSession() {
    return _userRepo.clearLoginUserSession();
  }
}
