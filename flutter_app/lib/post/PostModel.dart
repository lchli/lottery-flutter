import 'package:flutter/foundation.dart';
import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/post/PostMiddleWareImpl.dart';

import 'PostMiddleware.dart';

class PostModel with ChangeNotifier, PostMiddleWare {
  PostMiddleWare _PostMiddleWare = PostMiddleWareImpl();
  List<dynamic> _allPosts = [];
  List<dynamic> _myPosts = [];

  List<dynamic> get allPosts => _allPosts;

  List<dynamic> get myPosts => _myPosts;

  set userMiddleWare(PostMiddleWare v) => _PostMiddleWare = v;

  void loadPost() async {
    Result<List<dynamic>> res = await queryAllPosts();
    _allPosts = res.data;

    notifyListeners();
  }

  void loadMyPost(String userId, String userToken) async {
    Result<List<dynamic>> res = await queryMyPosts(userId, userToken);
    _myPosts = res.data;

    notifyListeners();
  }

  @override
  Future<Result<Function>> deletePost(String postId) {}

  @override
  Future<Result<Map<String, dynamic>>> queryPost(String postId) {}

  @override
  Future<Result<Function>> addPostOrUpdate(Map<String, dynamic> post) {}

  @override
  Future<Result<List<dynamic>>> queryMyPosts(
      String userId, String userToken) {
    return _PostMiddleWare.queryMyPosts(userId, userToken);
  }

  @override
  Future<Result<List<dynamic>>> queryAllPosts() {
    return _PostMiddleWare.queryAllPosts();
  }
}
