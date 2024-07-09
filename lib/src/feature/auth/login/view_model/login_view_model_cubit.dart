import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:instagram_clone/src/data/model/app_user.dart';
import 'package:instagram_clone/src/utils/app_shared_preferences.dart';
import 'package:meta/meta.dart';

part 'login_view_model_state.dart';

class LoginViewModelCubit extends Cubit<LoginViewModelState> {
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
        //? save token in shared preferences
        if (SharedPreferencesUtils.getData(key: 'TokenId') == null) {
          SharedPreferencesUtils.saveData(
            key: 'TokenId',
            value: credential.user!.uid,
          );
        }
        //? save user in provider
        var userObject = await AppFirebase.getUser(credential.user!.uid);
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
