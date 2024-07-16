import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/src/feature/profile/view/widget/header_profile_widget.dart';
import 'package:instagram_clone/src/feature/profile/view_model/profile_view_model_cubit.dart';
import 'package:instagram_clone/src/save_data_user/save_data_user.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/widget/custom_follow_button_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.uid});
  final String? uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModelCubit viewModle;
  late SaveUserProvider dataUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModle = ProfileViewModelCubit(uid: widget.uid);
    dataUser = Provider.of<SaveUserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.mobileBackgroundColor,
        title: Text(
          dataUser.user?.name ?? '',
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<ProfileViewModelCubit, ProfileViewModelState>(
        bloc: viewModle..getData(),
        builder: (context, state) {
          if (state is ProfileViewModelError) {
            return Text(state.message,
                style: const TextStyle(color: Colors.red, fontSize: 50));
          }
          if (state is ProfileViewModelSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            backgroundImage:
                                NetworkImage(dataUser.user?.photoUrl ?? ''),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    HeaderProfileWidget(
                                        num: viewModle.posts, label: "posts"),
                                    HeaderProfileWidget(
                                        num: viewModle.follwers,
                                        label: "followers"),
                                    HeaderProfileWidget(
                                        num: viewModle.following,
                                        label: "following"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uid
                                        ? FollowButton(
                                            text: 'Sign Out',
                                            backgroundColor:
                                                AppColors.mobileBackgroundColor,
                                            textColor: AppColors.primaryColor,
                                            borderColor: Colors.grey,
                                            function: () async {
                                              //? sign out
                                              FirebaseAuth auth =
                                                  FirebaseAuth.instance;
                                              await auth.signOut();
                                            },
                                          )
                                        : viewModle.isFollow
                                            ? FollowButton(
                                                text: 'Unfollow',
                                                backgroundColor: Colors.white,
                                                textColor: Colors.black,
                                                borderColor: Colors.grey,
                                                function: () async {
                                                  viewModle.addFollow();
                                                },
                                              )
                                            : FollowButton(
                                                text: 'Follow',
                                                backgroundColor: Colors.blue,
                                                textColor: Colors.white,
                                                borderColor: Colors.blue,
                                                function: () async {
                                                  viewModle.addFollow();
                                                },
                                              )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text(
                          dataUser.user?.username ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          top: 1,
                        ),
                        child: Text(
                          dataUser.user?.bio ?? '',
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: viewModle.postsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 1.5,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: Image(
                          image: NetworkImage(
                              viewModle.postsList[index].postImage),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
