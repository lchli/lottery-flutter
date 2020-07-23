import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterapp/client/ApiUrl.dart';
import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/post/PostMiddleware.dart';

class PostMiddleWareImpl extends PostMiddleWare{


  @override
  Future<Result<List<dynamic>>> queryAllPosts() async{
    Dio dio =  Dio();

    Response response = await dio.get(ApiUrl.All_Posts);
    print(response);

    Map<String, dynamic> map= jsonDecode(response.toString());

    String code=map['code'];
    print(code);

    return Result<List<dynamic>>(code: "1",data: map['items']);
  }

  @override
  Future<Result<Function>> deletePost(String postId) {

  }

  @override
  Future<Result<Map<String, dynamic>>> queryPost(String postId) {

  }

  @override
  Future<Result<Function>> addPostOrUpdate(Map<String, dynamic> post) {

  }

  @override
  Future<Result<List<dynamic>>> queryMyPosts(
      String userId, String userToken) async {

    var formData = {
      "userId": userId,
      "token": userToken,
    };

    Dio dio =  Dio();

    Response response = await dio.get(ApiUrl.My_Posts,queryParameters: formData);
    print(response);

    Map<String, dynamic> map= jsonDecode(response.toString());

    String code=map['code'];
    print(code);

    return Result<List<dynamic>>(code: "1",data: map['items']);
  }
}