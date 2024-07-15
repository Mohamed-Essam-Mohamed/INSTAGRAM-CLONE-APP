import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:instagram_clone/src/data/model/app_user.dart';

class SaveUserProvider extends ChangeNotifier {
  User? firebaseUser;
  AppUser? user;
  SaveUserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initUser();
  }
  initUser() async {
    if (firebaseUser != null) {
      user = await AppFirebase.getUser(firebaseUser?.uid ?? "");
      notifyListeners();
    }
  }
}
