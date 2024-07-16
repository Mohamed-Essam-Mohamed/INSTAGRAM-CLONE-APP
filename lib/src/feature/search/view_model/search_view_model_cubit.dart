import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:instagram_clone/src/data/model/app_post.dart';
import 'package:instagram_clone/src/data/model/app_user.dart';
import 'package:meta/meta.dart';

part 'search_view_model_state.dart';

class SearchViewModelCubit extends Cubit<SearchViewModelState> {
  SearchViewModelCubit() : super(SearchViewModelInitial());
  var searchController = TextEditingController();
  List<AppUser> users = [];
  late List<AppPost> postsPosts = [];

  void search({required String text}) async {
    emit(SearchViewModelLoading());
    users = await AppFirebase.searchUser(text);

    emit(SearchViewModelSuccess());
  }
  //? get all posts in firestore

  void getAllPosts() async {
    emit(SearchViewModelLoading());

    postsPosts = await AppFirebase.getPostInSearch();

    emit(SearchViewModelGetAllPost());
  }
}
