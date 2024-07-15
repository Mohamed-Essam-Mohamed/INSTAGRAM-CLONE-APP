import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/src/feature/init_screen/init_screen.dart';
import 'package:instagram_clone/src/feature/post/view/post_screen.dart';
import 'package:instagram_clone/src/feature/post/view/widget/text_form_field_comment_widget.dart';
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
    super.initState();
    urlImage = SharedPreferencesUtils.getData(key: 'profileImageUrl') as String;
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.close();
    viewModel.captionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)!.settings.arguments as ImageDataClass;
    var providerUser = Provider.of<SaveUserProvider>(context);
    return Scaffold(
      appBar: _appBarWidget(arguments, providerUser),
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
                TextFieldCommentWidget(
                  commentController: viewModel.captionController,
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

  AppBar _appBarWidget(
    ImageDataClass arguments,
    SaveUserProvider providerUser,
  ) {
    return AppBar(
      title: const Text('Selected Image', style: AppTextStyle.textStyle16),
      centerTitle: true,
      actions: [
        // icon post
        TextButton(
          onPressed: () async {
            viewModel.postImage(
              pathImage: arguments.image,
              name: providerUser.user?.name ?? "",
              profileImage: urlImage,
              userName: providerUser.user?.username ?? "",
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
    );
  }
}
