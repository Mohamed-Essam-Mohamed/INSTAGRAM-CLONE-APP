// ignore_for_file: public_member_api_docs, sort_constructors_first
// model class post
class AppPost {
  static const String collection = "posts";
  final String decoration;
  final String uid;
  final String username;
  final String postId;
  final date;
  final String postImage;
  final String profileImage;
  final List likes;
  AppPost({
    required this.decoration,
    required this.uid,
    required this.username,
    required this.postId,
    required this.date,
    required this.postImage,
    required this.profileImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'decoration': decoration,
      'uid': uid,
      'username': username,
      'postId': postId,
      'date': date,
      'postImage': postImage,
      'profileImage': profileImage,
      'likes': likes,
    };
  }

  factory AppPost.fromJson(Map<String, dynamic> map) {
    return AppPost(
      decoration: map['decoration'] as String,
      uid: map['uid'] as String,
      username: map['username'] as String,
      postId: map['postId'] as String,
      date: map['date'],
      postImage: map['postImage'] as String,
      profileImage: map['profileImage'] as String,
      likes: List.from(map['likes']),
    );
  }
}
