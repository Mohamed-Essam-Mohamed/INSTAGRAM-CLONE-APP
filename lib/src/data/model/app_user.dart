// ignore_for_file: public_member_api_docs, sort_constructors_first
//? data user instagram
import 'dart:io';
import 'dart:typed_data';

class AppUser {
  static const String collectionName = 'users';
  final String name;
  final String email;
  final String bio;
  final String username;
  final List<String> follwers;
  final List<String> following;
  final String photoUrl;
  final String uid;
  AppUser({
    required this.name,
    required this.email,
    required this.bio,
    required this.username,
    required this.uid,
    required this.follwers,
    required this.following,
    required this.photoUrl,
  });

  //? create from json
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      name: json['name'],
      email: json['email'],
      bio: json['bio'],
      username: json['username'],
      uid: json['uid'],
      follwers: [],
      following: [],
      photoUrl: json['photoUrl'],
    );
  }
  //? create to json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'bio': bio,
      'username': username,
      'uid': uid,
      'follwers': follwers,
      'following': following,
      'photoUrl': photoUrl,
    };
  }
}
