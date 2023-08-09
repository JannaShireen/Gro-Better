import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String authorId;
  final String username;
  final String content;
  final bool isAnonymous;
  final List likes;
  final Timestamp timeStamp;
  int likeCount;
  bool isSaved;

  Post({
    required this.postId,
    required this.authorId,
    required this.username,
    required this.content,
    required this.isAnonymous,
    required this.timeStamp,
    this.likeCount = 0,
    this.isSaved = false,
    required this.likes,
  });

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'authorId': authorId,
      'username': username,
      'content': content,
      'isAnonymous': isAnonymous,
      'timestamp': timeStamp,
      'likeCount': likeCount,
      'isSaved': isSaved,
      'likes': likes,
    };
  }

  static Post fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Post(
        postId: data['postId'],
        authorId: data['authorId'],
        username: data['username'] ?? " ",
        content: data['content'] ?? '',
        timeStamp: data['timestamp'],
        isAnonymous: data['isAnonymous'] ?? false,
        likeCount: data['likeCount'] ?? 0,
        isSaved: data['isSaved'] ?? false,
        likes: data['likes']);
  }
}
