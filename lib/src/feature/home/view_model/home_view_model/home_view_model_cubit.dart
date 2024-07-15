import 'package:bloc/bloc.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:meta/meta.dart';

part 'home_view_model_state.dart';

class HomeViewModelCubit extends Cubit<HomeViewModelState> {
  HomeViewModelCubit() : super(HomeViewModelInitial());
  bool isLikeAnimating = false;
  //? delete post
  void deletePost({required String postId}) async {
    emit(HomeViewModelLoading());
    await AppFirebase.deletePost(postId: postId);
    emit(HomeViewModelSuccess());
  }
}
