import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:instagram_clone/src/data/model/app_post.dart';
import 'package:instagram_clone/src/data/model/app_user.dart';
import 'package:meta/meta.dart';

part 'profile_view_model_state.dart';

class ProfileViewModelCubit extends Cubit<ProfileViewModelState> {
  ProfileViewModelCubit({required this.uid}) : super(ProfileViewModelInitial());
  String? uid;
  int follwers = 0;
  int following = 0;
  int posts = 0;
  List<AppPost> postsList = [];
  bool isFollow = false;
  //? get posts and followers data
  void getData() async {
    emit(ProfileViewModelLoading());

    try {
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: uid)
          .get();
      postSnap.docs.forEach((element) {
        postsList.add(AppPost.fromJson(element.data()));
      });

      //? get followers and following
      Future<AppUser?> user = AppFirebase.getUser(uid!);

      //? get followers and following
      user.then((value) {
        follwers = value!.follwers.length;
        following = value.following.length;
        isFollow = value.following.contains(uid);
      });

      posts = postsList.length;
      emit(ProfileViewModelSuccess());
    } catch (e) {
      emit(ProfileViewModelError(message: e.toString()));
    }
  }

  //? add follow
  void addFollow() async {
    try {
      await AppFirebase.addFollowing(
          uid: FirebaseAuth.instance.currentUser!.uid, followingId: uid!);

      emit(ProfileViewModelSuccess());
    } catch (e) {
      emit(ProfileViewModelError(message: e.toString()));
    }
  }
}
