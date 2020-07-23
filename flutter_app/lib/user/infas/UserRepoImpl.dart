import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterapp/Pref.dart';
import 'package:flutterapp/client/ApiUrl.dart';
import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/user/domain/User.dart';
import 'package:flutterapp/user/domain/UserRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepoImpl extends UserRepo {
  @override
  Future<Result<User>> save(User user) async {
    Dio dio = Dio();

    FormData formData = new FormData.fromMap({
      "account": user.name,
      "pwd": user.pwd,
    });
    Response response = await dio.post(ApiUrl.REGISTER, data: formData);
    print(response);

    Map<String, dynamic> map = jsonDecode(response.toString());

    Result<User> res = Result<User>();
    User newUser = User();
    newUser.id = map["id"];
    newUser.name = map["account"];
    newUser.token = map["token"];
    res.data = newUser;

    return res;
  }

  @override
  Future<Result<void>> saveLoginUserSession(User session) async {
    SharedPreferences sp = await Pref.prefs;
    String json = jsonEncode(session);
    sp.setString("user_session", json);

    return Result<void>();
  }

  @override
  Future<Result<User>> getLoginUserSession() async {
    Result<User> res = Result<User>();

    SharedPreferences sp = await Pref.prefs;
    String json = sp.getString("user_session");
    if (json == null) {
      res.msg = "未登录";
      return res;
    }
    Map<String, dynamic> map = jsonDecode(json);

    User newUser = User();
    newUser.id = map["id"];
    newUser.name = map["account"];
    newUser.token = map["token"];
    res.data = newUser;

    return res;
  }

  @override
  Future<Result<User>> findById(String userId, User se) async {
    Dio dio = Dio();

    var formData = {
      "userId": userId,
      "sessionId": se.id,
      "sessionToken": se.token,
    };
    Response response = await dio.get(ApiUrl.Login, queryParameters: formData);
    print(response);

    Map<String, dynamic> map = jsonDecode(response.toString());

    Result<User> res = Result<User>();
    User newUser = User();
    newUser.id = map["id"];
    newUser.name = map["account"];
    res.data = newUser;

    return res;
  }

  @override
  Future<Result<User>> find(String name, String pwd) async {
    //pwd md5
    Dio dio = Dio();

    var formData = {
      "account": name,
      "pwd": pwd,
    };
    Response response = await dio.get(ApiUrl.Login, queryParameters: formData);
    print(response);

    Map<String, dynamic> map = jsonDecode(response.toString());

    Result<User> res = Result<User>();
    User newUser = User();
    newUser.id = map["id"];
    newUser.name = map["account"];
    res.data = newUser;

    return res;
  }

  @override
  Future<Result<User>> update(User user) async {
    Dio dio = Dio();

    FormData formData = new FormData.fromMap({
      "userId": user.id,
      "account": user.name,
      "token": user.token,
    });
    Response response = await dio.post(ApiUrl.REGISTER, data: formData);
    print(response);

    Map<String, dynamic> map = jsonDecode(response.toString());

    Result<User> res = Result<User>();
    User newUser = User();
    newUser.id = map["id"];
    newUser.name = map["account"];
    newUser.token = map["token"];
    res.data = newUser;

    return res;
  }

  @override
  Future<Result<void>> clearLoginUserSession() async {
    SharedPreferences sp = await Pref.prefs;
    sp.remove("user_session");
    Result<void> res = Result<User>();
    return res;
  }
}
