import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/src/data/model/app_post.dart';
import 'package:uuid/uuid.dart';
import '../model/app_user.dart';

class AppFirebase {
  //! firebase firestore
  //? get collection data from firebase
  static CollectionReference<AppUser> getCollectionUsers() {
    return FirebaseFirestore.instance
        .collection(AppUser.collectionName)
        .withConverter<AppUser>(
          fromFirestore: (snapshot, options) =>
              AppUser.fromJson(snapshot.data()!),
          toFirestore: (AppUser value, options) => value.toJson(),
        );
  }

  //? add user to firebase
  static Future<void> addUser(AppUser user) {
    return getCollectionUsers().doc(user.uid).set(user);
  }

  //? update user to firebase
  static Future<void> updateUser(AppUser user) {
    return getCollectionUsers().doc(user.uid).update(user.toJson());
  }

  //? get user from firebase
  static Future<AppUser?> getUser(String uid) async {
    final snapshot = await getCollectionUsers().doc(uid).get();
    return snapshot.data();
  }

  //? check unique username from firebase
  static Future<bool> checkUniqueUsername(String username) {
    return getCollectionUsers()
        .where('username', isEqualTo: username)
        .get()
        .then((value) => value.docs.isEmpty);
  }

  //! firebase storage
  //? get collection images profile from firebase storage
  static Reference getCollectionImagesProfile() {
    return FirebaseStorage.instance.ref();
  }

  //? adding image profile to firebase storage
  static Future<void> addImageProfile({
    required String childName,
    required File path,
    required String authIdUser,
  }) {
    return getCollectionImagesProfile()
        .child(childName)
        .child(authIdUser)
        .putFile(path);
  }

  //? get url image profile from firebase storage
  static Future<String> getUrlImageProfile({
    required String childName,
    required Uint8List uint8List,
    required String currentUser,
  }) async {
    Reference ref =
        getCollectionImagesProfile().child(childName).child(currentUser);
    UploadTask uploadTask = ref.putData(uint8List);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //? delete image profile from firebase storage
  static Future<void> deleteImageProfile({
    required String childName,
    required String authIdUser,
  }) {
    return getCollectionImagesProfile()
        .child(childName)
        .child(authIdUser)
        .delete();
  }

  //? get image profile from firebase storage
  static Future<String> getImageProfile({
    required String childName,
    required String authIdUser,
  }) {
    return getCollectionImagesProfile()
        .child(childName)
        .child(authIdUser)
        .getDownloadURL();
  }

  //! post firebase storage
  //? add post image in app user
  static Future<String> addPostImage({
    required String childName,
    required String authIdUser,
    required String uid,
    required File path,
  }) async {
    UploadTask uploadTask = getCollectionImagesProfile()
        .child(childName)
        .child(authIdUser)
        .child(uid)
        .putFile(path);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //! save post fireBase firestore
  //? get collection data from firebase
  static CollectionReference<AppPost> getCollectionPosts() {
    return FirebaseFirestore.instance
        .collection(AppPost.collection)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              AppPost.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  //? add post to firebase
  static Future<void> addPost({
    required AppPost post,
    required String postId,
  }) async {
    return await getCollectionPosts().doc(postId).set(post);
  }

  //? delete post from firebase
  static Future<void> deletePost({required String postId}) {
    return getCollectionPosts().doc(postId).delete();
  }

  //? get post from firebase snapshot
  static Stream<QuerySnapshot<AppPost>> getPost() {
    return getCollectionPosts().orderBy('date', descending: true).snapshots();
  }

  //? update Likes
  static Future<void> updateLikes({
    required String postId,
    required List likes,
    required String uid,
  }) async {
    if (likes.contains(uid)) {
      await getCollectionPosts().doc(postId).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await getCollectionPosts().doc(postId).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  //! add comment firebase firestore
  //? get collection data from firebase
  static Future<void> addComments(
      {required String postId,
      required String profileUrl,
      required String userName,
      required String uid,
      required String comment}) async {
    var commentId = const Uuid().v4();
    return getCollectionPosts()
        .doc(postId)
        .collection("comments")
        .doc(commentId)
        .set({
      "profileUrl": profileUrl,
      "userName": userName,
      "uid": uid,
      "comment": comment,
      "date": DateTime.now().millisecondsSinceEpoch,
      "commentId": commentId,
      "likes": [],
    });
  }

  //? get comment from firebase snapshot
  static Stream<QuerySnapshot<Map<String, dynamic>>> getComment(String postId) {
    return getCollectionPosts()
        .doc(postId)
        .collection("comments")
        .orderBy("date", descending: true)
        .snapshots();
  }

  //? get length comment from firebase snapshot
  static Future<int> getLengthComment(String postId) {
    return getCollectionPosts()
        .doc(postId)
        .collection("comments")
        .get()
        .then((value) => value.size);
  }

  //? Update Likes Comment
  static Future<void> updateLikesComment({
    required String postId,
    required String commentId,
    required List likes,
    required String uid,
  }) async {
    if (likes.contains(uid)) {
      await getCollectionPosts()
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .update({
        "likes": FieldValue.arrayRemove([uid])
      });
    } else {
      await getCollectionPosts()
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .update({
        "likes": FieldValue.arrayUnion([uid])
      });
    }
  }
}
