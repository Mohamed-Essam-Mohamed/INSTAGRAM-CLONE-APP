import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/src/feature/init_screen/view/init_screen.dart';
import 'package:instagram_clone/src/feature/post/view/post_screen.dart';
import 'package:instagram_clone/src/feature/post/view_model/selected_image_view_model/selected_image_view_model_cubit.dart';
import 'package:instagram_clone/src/save_data_user/save_data_user.dart';
import 'package:instagram_clone/src/utils/app_shared_preferences.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';
import 'package:instagram_clone/src/utils/dialog_app.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_colors.dart';

class SelectedImageScreen extends StatefulWidget {
  static const String routeName = 'SelectedImageScreen';
  const SelectedImageScreen({super.key});

  @override
  State<SelectedImageScreen> createState() => _SelectedImageScreenState();
}

class _SelectedImageScreenState extends State<SelectedImageScreen> {
  SelectedImageViewModelCubit viewModel = SelectedImageViewModelCubit();
  late String urlImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    urlImage = SharedPreferencesUtils.getData(key: 'profileImageUrl') as String;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    viewModel.close();
  }

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)!.settings.arguments as ImageDataClass;
    var providerUser = Provider.of<SaveUserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Image', style: AppTextStyle.textStyle16),
        centerTitle: true,
        actions: [
          // icon post
          TextButton(
            onPressed: () async {
              viewModel.postImage(
                pathImage: arguments.image,
                nameUser: providerUser.user?.name ?? "",
                profileImage: urlImage,
              );
            },
            child: Text(
              'Post',
              style: AppTextStyle.textStyle16.copyWith(
                color: AppColors.blueColor,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<SelectedImageViewModelCubit,
          SelectedImageViewModelState>(
        bloc: viewModel,
        listener: (context, state) {
          if (state is SelectedImageViewModelError) {
            DialogApp.showMessage(
              context: context,
              message: state.errorMessage,
            );
          } else if (state is SelectedImageViewModelLoading) {
            DialogApp.showLoading(context, "Posting...");
          } else if (state is SelectedImageViewModelSuccess) {
            Navigator.of(context).pushReplacementNamed(InitScreen.routeName);
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(16.h),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(arguments.urlImageProfile),
                  radius: 25.h,
                ),
                Gap(5.h),
                Expanded(
                  child: TextFieldCommentWidget(
                    commentController: viewModel.captionController,
                  ),
                ),
                Gap(5.h),
                Container(
                  height: 73.h,
                  width: 73.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Image.file(
                    arguments.image,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class TextFieldCommentWidget extends StatelessWidget {
  const TextFieldCommentWidget({
    super.key,
    required this.commentController,
  });
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: commentController,
      maxLines: 4,
      minLines: 2,
      decoration: InputDecoration(
        hintText: 'Write a comment.....',
        hintStyle: AppTextStyle.textStyle16.copyWith(
          color: AppColors.secondaryColor.shade700,
          fontWeight: FontWeight.w400,
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
        enabledBorder:
            _outLineInputBorder(color: AppColors.mobileBackgroundColor),
        focusedBorder: _outLineInputBorder(color: AppColors.blueColor),
      ),
    );
  }

  OutlineInputBorder _outLineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(2.r),
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
    );
  }
}
