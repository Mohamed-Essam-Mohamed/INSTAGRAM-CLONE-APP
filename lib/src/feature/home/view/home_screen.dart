import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:instagram_clone/src/data/model/app_post.dart';
import 'package:instagram_clone/src/feature/home/view_model/home_view_model/home_view_model_cubit.dart';
import 'package:instagram_clone/src/save_data_user/save_data_user.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_shared_preferences.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';

import 'widget/post_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SaveUserProvider userApp;
  late String tokenUser =
      SharedPreferencesUtils.getData(key: 'TokenId') as String;
  HomeViewModelCubit viewModel = HomeViewModelCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mobileBackgroundColor,
      appBar: _appBarWidget(),
      body: BlocProvider(
        create: (context) => viewModel,
        child: StreamBuilder<QuerySnapshot<AppPost>>(
          stream: AppFirebase.getPost(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _circularProgressIndicatorWidget();
            }
            if (!snapshot.hasData) {
              return _textErrorWidget(snapshot);
            }
            var listAppPost = snapshot.data?.docs.map((e) => e.data()).toList();

            return _listViewGroupsWidget(context, listAppPost);
          },
        ),
      ),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      backgroundColor: const Color(0xff121212),
      elevation: 0,
      title: Image.asset(
        "assets/images/icon-instagram-logo.png",
        width: 120.w,
        height: 120.h,
      ),
      leading: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(
            top: 10.w,
            right: 10.w,
            bottom: 10.w,
            left: 5.w,
          ),
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset(
            "assets/icons/icon-camera.svg",
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/icon-icon.svg",
            width: 27.w,
            height: 27.h,
            fit: BoxFit.contain,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/icon-messanger.svg",
            width: 25.w,
            height: 25.h,
            fit: BoxFit.contain,
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  SizedBox _listViewGroupsWidget(
    BuildContext context,
    List<AppPost>? listAppPost,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10.0.w,
          mainAxisSpacing: 10.0.h,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) => PostCard(
          appPost: listAppPost?[index],
        ),
        itemCount: listAppPost?.length,
      ),
    );
  }

  Text _textErrorWidget(AsyncSnapshot<QuerySnapshot<AppPost>> snapshot) {
    return Text(
      snapshot.error.toString(),
      style: AppTextStyle.textStyle18,
    );
  }

  Center _circularProgressIndicatorWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.secondaryColor,
      ),
    );
  }
}
