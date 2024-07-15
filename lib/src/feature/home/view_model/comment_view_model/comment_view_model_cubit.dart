import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:instagram_clone/src/data/model/app_comment.dart';
import 'package:instagram_clone/src/save_data_user/save_data_user.dart';
import 'package:meta/meta.dart';

part 'comment_view_model_state.dart';

class CommentViewModelCubit extends Cubit<CommentViewModelState> {
  CommentViewModelCubit({required this.dataUser})
      : super(CommentViewModelInitial());
  var commentController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late SaveUserProvider dataUser;
  List<AppComment> data = [];
  //? get bloc data

  //? function add comment in fire base database
  void addComment({required String postId}) {
    emit(CommentViewModelLoading());
    if (formKey.currentState!.validate()) {
      AppFirebase.addComments(
        postId: postId,
        profileUrl: dataUser.user?.photoUrl ?? "",
        userName: dataUser.user?.username ?? "",
        uid: dataUser.user?.uid ?? "",
        comment: commentController.text,
      );
      commentController.clear();
      emit(CommentViewModelSuccess());
    } else {
      emit(CommentViewModelError(message: "Please Enter Comment"));
    }
  }
}
