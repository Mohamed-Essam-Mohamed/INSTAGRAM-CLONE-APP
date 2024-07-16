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
import 'package:instagram_clone/src/utils/app_shared_preferences.dart';
import 'package:provider/provider.dart';

class InitScreen extends StatefulWidget {
  static const String routeName = 'InitScreen';

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int index = 0;
  late PageController pageController;
  late String urlImage;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    urlImage = SharedPreferencesUtils.getData(key: 'profileImageUrl') as String;
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SaveUserProvider>(context);

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            this.index = index;
          });
        },
        children: [
          const HomeScreen(),
          const SearchScreen(),
          const PostScreen(),
          const LoveScreen(),
          ProfileScreen(
            uid: provider.user?.uid ?? "",
          ),
        ],
      ),
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
          navigationTapped(selectedIndex);

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
                ? circleAvatarProfile(w: 1, url: urlImage)
                : circleAvatarProfile(w: 0, url: urlImage),
            label: '',
          ),
        ],
      ),
    );
  }

  //? container profile
  Container circleAvatarProfile({required double w, required String url}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor,
          width: w,
        ),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: w == 1 ? 17.r : 18.r,
        backgroundImage: NetworkImage(url),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
