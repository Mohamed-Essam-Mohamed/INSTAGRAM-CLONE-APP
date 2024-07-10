import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:instagram_clone/src/data/model/app_user.dart';
import 'package:instagram_clone/src/utils/app_shared_preferences.dart';
import 'package:meta/meta.dart';

part 'login_view_model_state.dart';

class LoginViewModelCubit extends Cubit<LoginViewModelState> {
  static const String defultUrl =
      "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg";
  LoginViewModelCubit() : super(LoginViewModelInitial());
  var emailController = TextEditingController(text: "esam7@gmail.com");
  var passwordController = TextEditingController(text: "Mohamed@2003");
  var formKey = GlobalKey<FormState>();
  void login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginViewModelLoading());
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //? save user in provider
        var userObject = await AppFirebase.getUser(credential.user!.uid);
        //? save token in shared preferences
        if (SharedPreferencesUtils.getData(key: 'TokenId') == null) {
          await SharedPreferencesUtils.saveData(
            key: 'TokenId',
            value: credential.user!.uid,
          );
          await SharedPreferencesUtils.saveData(
            key: 'profileImageUrl',
            value: userObject?.photoUrl ?? defultUrl,
          );
        }

        emit(LoginViewModelSuccess(userObject: userObject!));
      } on FirebaseAuthException catch (e) {
        print(e.message.toString());
        if (e.code == 'user-not-found') {
          emit(LoginViewModelError(
            errorMessage: e.message.toString(),
          ));
        } else if (e.code == 'wrong-password') {
          emit(LoginViewModelError(
            errorMessage: e.message.toString(),
          ));
        }
      }
    }
  }
}
