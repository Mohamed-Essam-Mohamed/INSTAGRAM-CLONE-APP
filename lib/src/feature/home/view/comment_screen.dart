import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:instagram_clone/src/data/model/app_comment.dart';
import 'package:instagram_clone/src/feature/home/view/widget/comment_card_widget.dart';
import 'package:instagram_clone/src/feature/home/view_model/comment_view_model/comment_view_model_cubit.dart';
import 'package:instagram_clone/src/save_data_user/save_data_user.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';
import 'package:instagram_clone/src/utils/dialog_app.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  static const String routeName = '/comment';
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late SaveUserProvider dataUser;
  late CommentViewModelCubit viewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataUser = Provider.of<SaveUserProvider>(context, listen: false);
    viewModel = CommentViewModelCubit(dataUser: dataUser);
  }

  @override
  Widget build(BuildContext context) {
    var arge = ModalRoute.of(context)!.settings.arguments as String;
    return BlocListener<CommentViewModelCubit, CommentViewModelState>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is CommentViewModelLoading) {
          DialogApp.showLoading(context, "Loading...");
        }

        if (state is CommentViewModelError) {
          DialogApp.showMessage(context: context, message: state.message);
        }
        if (state is CommentViewModelSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comment'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.w),
          // CommentCardWidget()
          child: StreamBuilder(
              stream: AppFirebase.getComment(arge),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      viewModel.data = snapshot.data!.docs
                          .map((data) => AppComment.fromJson(data.data()))
                          .toList();
                      return CommentCardWidget(
                        comment: viewModel.data[index].comment,
                        photoUrl: viewModel.data[index].profileUrl,
                        time: viewModel.data[index].date ?? DateTime.now(),
                        userName: viewModel.data[index].username,
                        commentId: viewModel.data[index].commentId,
                        postId: arge,
                        likes: viewModel.data[index].likes,
                      );
                    },
                    separatorBuilder: (context, index) => Gap(10.h),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blueColor,
                  ),
                );
              }),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.w),
          margin: MediaQuery.of(context).viewInsets,
          child: Form(
            key: viewModel.formKey,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundImage: NetworkImage(dataUser.user?.photoUrl ?? ""),
                ),
                Gap(15.w),
                Expanded(
                  child: TextField(
                    controller: viewModel.commentController,
                    decoration: InputDecoration(
                      hintText: 'write a comment...',
                      hintStyle: AppTextStyle.textStyle16.copyWith(
                        color: AppColors.secondaryColor.shade700,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Gap(10.w),
                TextButton(
                  onPressed: () async {
                    viewModel.addComment(postId: arge);
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
          ),
        ),
      ),
    );
  }
}
