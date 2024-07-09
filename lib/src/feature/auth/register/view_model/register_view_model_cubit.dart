import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../data/firebase/app_firebase.dart';
import '../../../../data/model/app_user.dart';
import 'package:meta/meta.dart';

part 'register_view_model_state.dart';

class RegisterViewModelCubit extends Cubit<RegisterViewModelState> {
  RegisterViewModelCubit() : super(RegisterViewModelInitial());
  var emailController = TextEditingController(text: 'esam7@gmail.com');
  var passwordController = TextEditingController(text: "Mohamed@2003");
  var usernameController = TextEditingController(text: "mohamed_2003");
  var bioController = TextEditingController(text: "flutter developer");
  var nameController = TextEditingController(text: "mohamed");
  var formKey = GlobalKey<FormState>();
  File? image;

  //? function checking userName from fire base
  Future<bool> checkUniqueUsername(String username) async {
    return await AppFirebase.checkUniqueUsername(username);
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      try {
        if (await checkUniqueUsername(usernameController.text) == false) {
          emit(RegisterViewModelError(
              errorMessage: "The username is already exists."));
        } else {
          emit(RegisterViewModelLoading());
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          //? upload image
          AppFirebase.addImageProfile(
            childName: "profile",
            path: image ?? File(""),
            isPost: false,
            authIdUser: credential.user!.uid,
          );
          //? get url image
          String photoUrl = await AppFirebase.getUrlImageProfile(
            childName: "profile",
            uint8List: convertImageToUint8List(image),
            currentUser: credential.user!.uid,
          );
          //? add user to firestore
          AppFirebase.addUser(
            AppUser(
              name: nameController.text,
              email: emailController.text,
              username: usernameController.text,
              bio: bioController.text,
              uid: credential.user!.uid,
              photoUrl: photoUrl,
              following: [],
              follwers: [],
            ),
          );

          emit(RegisterViewModelSuccess());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(
            RegisterViewModelError(
              errorMessage: "The password provided is too weak.",
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          emit(
            RegisterViewModelError(
              errorMessage: "The account already exists for that email.",
            ),
          );
        } else {
          emit(RegisterViewModelError(errorMessage: e.toString()));
        }
      } catch (e) {
        emit(RegisterViewModelError(errorMessage: e.toString()));
      }
    }
  }

  //? convert image to Uint8List
  Uint8List convertImageToUint8List(File? image) {
    if (image != null) {
      return image.readAsBytesSync();
    }
    return Uint8List(0);
  }
}
