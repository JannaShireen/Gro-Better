import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gro_better/model/user_info.dart';

class Post {
  final String username;
  final String content;
  final bool isAnonymous;

  final Timestamp timeStamp;
  bool isLiked;
  int likeCount;
  bool isSaved;

  Post({
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
      'username': username,
      'content': content,
      'isAnonymous': isAnonymous,
      'timestamp': timeStamp.millisecondsSinceEpoch,
      'isLiked': isLiked,
      'likeCount': likeCount,
      'isSaved': isSaved,
    };
  }

  static Post fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Post(
      username: data['username'] ?? " ",
      content: data['content'] ?? '',
      timeStamp: data['timestamp'].toDate(),
      isAnonymous: data['isAnonymous'] ?? false,
      isLiked: data['isLiked'] ?? false,
      likeCount: data['likeCount'] ?? 0,
      isSaved: data['isSaved'] ?? false,
    );
  }
}
