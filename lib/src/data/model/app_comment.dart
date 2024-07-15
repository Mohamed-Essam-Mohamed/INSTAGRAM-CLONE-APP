// ignore_for_file: public_member_api_docs, sort_constructors_first
//? class comment
import 'package:flutter/material.dart';

class AppComment {
  String comment;
  String commentId;
  final date;
  String uid;
  String username;
  String profileUrl;
  AppComment({
    required this.comment,
    required this.commentId,
    required this.date,
    required this.uid,
    required this.username,
    required this.profileUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'comment': comment,
      'commentId': commentId,
      'date': date,
      'uid': uid,
      'userName': username,
      'profileUrl': profileUrl
    };
  }

  factory AppComment.fromJson(Map<String, dynamic> json) {
    return AppComment(
      comment: json['comment'] as String,
      commentId: json['commentId'] as String,
      date: json['date'],
      uid: json['uid'] as String,
      username: json['userName'] as String,
      profileUrl: json['profileUrl'] as String,
    );
  }
}
