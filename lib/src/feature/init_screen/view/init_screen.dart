import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/src/feature/home/view/home_screen.dart';
import 'package:instagram_clone/src/feature/love/view/love_screen.dart';
import 'package:instagram_clone/src/feature/post/view/post_screen.dart';
import 'package:instagram_clone/src/feature/profile/view/profile_screen.dart';
import 'package:instagram_clone/src/feature/search/view/search_screen.dart';
import 'package:instagram_clone/src/save_data_user/save_data_user.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:provider/provider.dart';

class InitScreen extends StatefulWidget {
  static const String routeName = 'InitScreen';

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  List<Widget> widgetList = [
    HomeScreen(),
    SearchScreen(),
    PostScreen(),
    LoveScreen(),
    ProfileScreen(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SaveUserProvider>(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedFontSize: 13.sp,
        selectedFontSize: 13.sp,
        selectedItemColor: AppColors.primaryColor,
        enableFeedback: true,
        showSelectedLabels: true,
        useLegacyColorScheme: true,
        elevation: 0,
        currentIndex: index,
        onTap: (selectedIndex) {
          index = selectedIndex;

          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              index == 0
                  ? 'assets/icons/Icon-select-home.svg'
                  : 'assets/icons/Icon-unselect-home.svg',
              height: 23.h,
              width: 23.w,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              index == 1
                  ? 'assets/icons/Icon-select-search.svg'
                  : 'assets/icons/Icon-unselect-search.svg',
              height: 23.h,
              width: 23.w,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              index == 2
                  ? 'assets/icons/Icon-post.svg'
                  : 'assets/icons/Icon-post.svg',
              height: 23.h,
              width: 23.w,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              index == 3
                  ? 'assets/icons/Icon-select-love.svg'
                  : 'assets/icons/Icon-unselect-love.svg',
              height: 23.h,
              width: 23.w,
            ),
            label: '',
          ),
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(
            icon: index == 4
                ? circleAvatarProfile(w: 1, provider: provider)
                : circleAvatarProfile(w: 0, provider: provider),
            label: '',
          ),
        ],
      ),
      body: widgetList[index],
    );
  }

  //? container profile
  Container circleAvatarProfile({required double w, required var provider}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor,
          width: w,
        ),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 18.r,
        backgroundImage: provider.user?.photoUrl == null
            ? null
            : NetworkImage(provider.user?.photoUrl ?? ""),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
