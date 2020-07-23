import 'package:flutterapp/client/ResultDto.dart';
import 'package:flutterapp/user/domain/User.dart';

import 'Post.dart';

abstract class PostDomainService{
  Future<Result<void>> writeOrUpdatePost(Post post);
  Future<Result<void>> deletePost(Post post);
  Future<Result<Post>> queryPostById(String postId);
  Future<Result<List<Post>>> queryAllPosts();
  Future<Result<List<Post>>> queryUserPosts(User user);
}