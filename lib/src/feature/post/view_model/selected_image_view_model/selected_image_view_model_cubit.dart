import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:instagram_clone/src/data/model/app_post.dart';
import 'package:instagram_clone/src/utils/app_shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'selected_image_view_model_state.dart';

class SelectedImageViewModelCubit extends Cubit<SelectedImageViewModelState> {
  SelectedImageViewModelCubit() : super(SelectedImageViewModelInitial());
  var captionController = TextEditingController();
  String token = SharedPreferencesUtils.getData(key: 'TokenId') as String;

  String id = const Uuid().v1();
  //? function post image

  void postImage({
    required File pathImage,
    required String name,
    required String profileImage,
    required String userName,
  }) async {
    emit(SelectedImageViewModelLoading());
    try {
      //? upload image post

      var postUrlImag = await AppFirebase.addPostImage(
        childName: "posts",
        authIdUser: token,
        uid: id,
        path: pathImage,
      );

      //? add post to firebase
      await AppFirebase.addPost(
        post: AppPost(
          decoration: captionController.text ?? "",
          uid: token,
          username: name,
          postId: id,
          date: DateTime.now(),
          postImage: postUrlImag,
          profileImage: profileImage,
          likes: [],
        ),
        postId: id,
      );
      emit(SelectedImageViewModelSuccess());
    } catch (e) {
      emit(SelectedImageViewModelError(errorMessage: e.toString()));
    }
  }
}
