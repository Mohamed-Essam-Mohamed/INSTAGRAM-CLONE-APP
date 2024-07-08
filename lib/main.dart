import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/src/feature/auth/login/view/login_screen.dart';
import 'package:instagram_clone/src/feature/auth/register/view/register_screen.dart';
import 'package:instagram_clone/src/responsive/mobile_screen.dart';
import 'package:instagram_clone/src/responsive/responsive_ui.dart';
import 'package:instagram_clone/src/responsive/web_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: "Instagram Clone",
        theme: ThemeData.dark().copyWith(),
        // home: const ResponsiveUi(
        //   mobileScreen: MobileScreen(),
        //   webScreen: WebScreen(),
        // ),
        home: LoginScreen(),
      ),
    );
  }
}
