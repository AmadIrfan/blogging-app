class Posts {
  String userId;
  String postId;
  String title;
  String body;
  String dateTime;
  String updatedTime;
  String imagePost;
  Posts({
    required this.body,
    required this.postId,
    required this.userId,
    required this.imagePost,
    required this.title,
    required this.dateTime,
    required this.updatedTime,
  });
}
