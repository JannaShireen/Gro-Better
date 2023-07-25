import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String authorId;
  final String username;
  final String content;
  final bool isAnonymous;

  final Timestamp timeStamp; // Change the type to int

  bool isLiked;
  int likeCount;
  bool isSaved;

  Post({
    required this.authorId,
    required this.username,
    required this.content,
    required this.isAnonymous,
    required this.timeStamp,
    this.isLiked = false,
    this.likeCount = 0,
    this.isSaved = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'authorId': authorId,
      'username': username,
      'content': content,
      'isAnonymous': isAnonymous,
      'timestamp': timeStamp,
      'isLiked': isLiked,
      'likeCount': likeCount,
      'isSaved': isSaved,
    };
  }

  static Post fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Post(
      authorId: data['authorId'],
      username: data['username'] ?? " ",
      content: data['content'] ?? '',
      timeStamp: data['timestamp'], // Convert to int
      isAnonymous: data['isAnonymous'] ?? false,
      isLiked: data['isLiked'] ?? false,
      likeCount: data['likeCount'] ?? 0,
      isSaved: data['isSaved'] ?? false,
    );
  }
}
