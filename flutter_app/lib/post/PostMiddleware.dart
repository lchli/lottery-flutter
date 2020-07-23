import 'package:flutterapp/client/ResultDto.dart';

abstract class PostMiddleWare{

   Future<Result<List<dynamic>>>  queryAllPosts();
   Future<Result<List<dynamic>>> queryMyPosts(String userId,String userToken);
   Future<Result<void>> addPostOrUpdate(Map<String, dynamic> post);
   Future<Result<Map<String, dynamic>>> queryPost(String postId);
   Future<Result<void>> deletePost(String postId);

}