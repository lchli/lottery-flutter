import 'package:flutterapp/user/login.dart';

class ApiUrl{
  static final DOMAIN="http://192.168.2.237:8080";
  static final REGISTER="$DOMAIN/api/user/register";
  static final Login="$DOMAIN/api/user/login";
  static final All_Posts="$DOMAIN/api/fav/queryAllFavs";
  static final My_Posts="$DOMAIN/api/fav/queryFavs";
  static final post_detail="$DOMAIN/api/fav/queryPostDetail";
  static final add_post="$DOMAIN/api/fav/add";
  static final delete_post="$DOMAIN/api/fav/delete";
}