class Post {
  final String username;
  final String content;
  bool isLiked;
  int likeCount;
  bool isSaved;

  Post({
    required this.username,
    required this.content,
    this.isLiked = false,
    this.likeCount = 0,
    this.isSaved = false,
  });
}
