import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/app_user.dart';

class AppFirebase {
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

  //? delete user to firebase
  static Future<void> deleteUser(AppUser user) {
    return getCollectionUsers().doc(user.uid).delete();
  }

  //? get user from firebase
  static Future<AppUser?> getUser(String uid) {
    return getCollectionUsers().doc(uid).get().then((value) => value.data());
  }

  //? check unique username
  static Future<bool> checkUniqueUsername(String username) {
    return getCollectionUsers()
        .where('username', isEqualTo: username)
        .get()
        .then((value) => value.docs.isEmpty);
  }

  //? get collection images profile from firebase storage
  static Reference getCollectionImagesProfile() {
    return FirebaseStorage.instance.ref();
  }

  //? adding image profile to firebase storage
  static Future<void> addImageProfile({
    required String childName,
    required File path,
    required bool isPost,
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
  // //? update image profile to firebase storage
  // static Future<void> updateImageProfile({
  //   required String childName,
  //   required String authIdUser,
  //   required File path,
  //   required bool isPost,
  // }) {
  //   return getCollectionImagesProfile()
  //       .child(childName)
  //       .child(authIdUser)
  //       .putFile(path);
  // }
}
