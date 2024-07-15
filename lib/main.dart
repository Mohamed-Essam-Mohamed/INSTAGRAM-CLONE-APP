import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/src/feature/home/view/comment_screen.dart';
import 'package:instagram_clone/src/feature/init_screen/init_screen.dart';
import 'package:instagram_clone/src/feature/post/view/selected_image_screen.dart';
import 'package:instagram_clone/src/save_data_user/save_data_user.dart';
import 'package:instagram_clone/src/utils/app_shared_preferences.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'src/feature/auth/login/view/login_screen.dart';
import 'src/feature/auth/register/view/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesUtils.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String routeName = LoginScreen.routeName;
  var checkToken = SharedPreferencesUtils.getData(key: 'TokenId');
  if (checkToken != null) {
    routeName = InitScreen.routeName;
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => SaveUserProvider(),
      child: MyApp(routeName: routeName),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.routeName});
  String routeName;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: "Instagram Clone",
        theme: ThemeData.dark().copyWith(),
        initialRoute: routeName,
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          InitScreen.routeName: (context) => InitScreen(),
          SelectedImageScreen.routeName: (context) => SelectedImageScreen(),
          CommentScreen.routeName: (context) => CommentScreen(),
        },
      ),
    );
  }
}
