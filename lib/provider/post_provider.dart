import 'package:flutter/foundation.dart';
import 'package:gro_better/model/post.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  void setPosts(List<Post> posts) {
    _posts = posts;
    notifyListeners();
  }

  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }
}
