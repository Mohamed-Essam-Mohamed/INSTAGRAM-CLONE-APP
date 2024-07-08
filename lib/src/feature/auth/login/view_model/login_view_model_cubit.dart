import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        emit(LoginViewModelSuccess());
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
