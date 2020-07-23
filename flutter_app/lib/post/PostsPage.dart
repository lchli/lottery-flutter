import 'package:flutter/material.dart';
import 'package:flutterapp/post/PostDetailPage.dart';
import 'package:flutterapp/post/PostModel.dart';
import 'package:provider/provider.dart';

import 'WritePostPage.dart';


class PostsPage extends StatelessWidget {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  PostModel postModel;

  @override
  Widget build(BuildContext context) {
    if (postModel == null) {
      postModel = Provider.of<PostModel>(context, listen: true);
      postModel.loadPost();
    }
    return _buildSuggestions(context);
  }

  Widget _buildSuggestions(BuildContext context) {

    int itemcount=postModel.allPosts!=null?postModel.allPosts.length:0;

    return new Scaffold(
      body: new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: itemcount, //数据的数量
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();

          return _buildRow(postModel.allPosts[i], context);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          _gotoWritePost(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _gotoWritePost(BuildContext context) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new EditorPage(null);
        },
      ),
    ).then((value) => postModel.loadPost());
  }

  Widget _buildRow(Map pair, BuildContext context) {
    return new ListTile(
      title: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              pair['title'],
              style: _biggerFont,
            ),
            new Text(
              "作者：${pair['title']}",
              style: TextStyle(fontSize: 10.0),
            )
          ]),
      trailing: new Icon(
        Icons.favorite,
        color: Colors.red,
      ),
      onTap: () {
        _gotoPostDetail(pair["uid"], context);
//        setState(
//                () {
//              if (alreadySaved) {
//                _saved.remove(pair);
//              } else {
//                _saved.add(pair);
//              }
//            }
//        );
      },
    );
  }

  void _gotoPostDetail(String postId, BuildContext context) {

    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new PostDetailPage(postId);
        },
      ),
    ).then((value) => postModel.loadPost());
  }
}

