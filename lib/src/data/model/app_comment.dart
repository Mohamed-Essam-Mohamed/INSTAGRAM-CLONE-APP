class AppComment {
  String comment;
  String commentId;
  DateTime date;
  String uid;
  String username;
  String profileUrl;
  List likes;
  AppComment(
      {required this.comment,
      required this.commentId,
      required this.date,
      required this.uid,
      required this.username,
      required this.profileUrl,
      required this.likes});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'comment': comment,
      'commentId': commentId,
      'date': date.millisecondsSinceEpoch,
      'uid': uid,
      'userName': username,
      'profileUrl': profileUrl,
      'likes': likes
    };
  }

  factory AppComment.fromJson(Map<String, dynamic> json) {
    return AppComment(
      comment: json['comment'] as String,
      commentId: json['commentId'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      uid: json['uid'] as String,
      username: json['userName'] as String,
      profileUrl: json['profileUrl'] as String,
      likes: json['likes'] as List,
    );
  }
}
