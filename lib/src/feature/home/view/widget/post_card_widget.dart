// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:instagram_clone/src/data/model/app_post.dart';
import 'package:instagram_clone/src/feature/home/view/comment_screen.dart';
import 'package:instagram_clone/src/feature/home/view/home_screen.dart';
import 'package:instagram_clone/src/feature/home/view_model/home_view_model/home_view_model_cubit.dart';
import 'package:instagram_clone/src/feature/init_screen/init_screen.dart';
import 'package:instagram_clone/src/feature/profile/view/profile_screen.dart';
import 'package:instagram_clone/src/save_data_user/save_data_user.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';
import 'package:instagram_clone/src/widget/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final AppPost? appPost;
  late final snap;
  PostCard({
    Key? key,
    required this.appPost,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;

  HomeViewModelCubit viewModel = HomeViewModelCubit();
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    getLengthComment();
  }

  void getLengthComment() async {
    try {
      QuerySnapshot snp = await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.appPost!.postId)
          .collection("comments")
          .get();
      commentLen = snp.docs.length;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var userDataProvider = Provider.of<SaveUserProvider>(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.mobileBackgroundColor,
        ),
        color: AppColors.mobileBackgroundColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          _headerSectionPostWidget(context, userDataProvider),
          _imageSectionPostWidget(context),
          _likeCommentSectionPostWidget(context),
          _descriptionNumberCommentSectionPostWidget(context),
        ],
      ),
    );
  }

  Container _descriptionNumberCommentSectionPostWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DefaultTextStyle(
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w800),
            child: Text(
              '${widget.appPost?.likes.length ?? 0} likes',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: AppColors.primaryColor),
                children: [
                  TextSpan(
                    text: widget.appPost?.username ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: widget.appPost?.decoration ?? "",
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'View all ${commentLen} comments',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            onTap: () {},
          ),
          Text(
            DateFormat.yMMMd().format(widget.appPost?.date.toDate()),
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Row _likeCommentSectionPostWidget(BuildContext context) {
    return Row(
      children: [
        LikeAnimation(
          isAnimating: widget.appPost!.likes.contains(widget.appPost?.uid),
          smallLike: true,
          child: IconButton(
            onPressed: () async {
              await AppFirebase.updateLikes(
                likes: widget.appPost!.likes,
                postId: widget.appPost!.postId,
                uid: widget.appPost!.uid,
              );
            },
            icon: !widget.appPost!.likes.contains(widget.appPost?.uid)
                ? SvgPicture.asset("assets/icons/Icon-unselect-love.svg")
                : SvgPicture.asset(
                    "assets/icons/Icon-select-love.svg",
                    color: AppColors.redColor,
                  ),
          ),
        ),
        IconButton(
          icon: SvgPicture.asset("assets/icons/icon-comment.svg"),
          onPressed: () {
            Navigator.of(context).pushNamed(CommentScreen.routeName,
                arguments: widget.appPost?.postId ?? "");
          },
        ),
        IconButton(
          icon: SvgPicture.asset("assets/icons/icon-messanger.svg"),
          onPressed: () {},
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(
                Icons.bookmark_border,
                size: 30.sp,
              ),
              onPressed: () {},
            ),
          ),
        )
      ],
    );
  }

  GestureDetector _imageSectionPostWidget(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        await AppFirebase.updateLikes(
          likes: widget.appPost!.likes,
          postId: widget.appPost!.postId,
          uid: widget.appPost!.uid,
        );
        setState(() {
          isLikeAnimating = true;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.43,
            width: double.infinity,
            child: Image.network(
              widget.appPost?.postImage ?? "",
              fit: BoxFit.cover,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isLikeAnimating ? 1 : 0,
            child: LikeAnimation(
              isAnimating: isLikeAnimating,
              duration: const Duration(milliseconds: 300),
              onEnd: () {
                setState(() {
                  isLikeAnimating = false;
                });
              },
              child: Icon(
                Icons.favorite,
                color: AppColors.primaryColor,
                size: 130.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _headerSectionPostWidget(
      BuildContext context, SaveUserProvider providerUser) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.h,
        horizontal: 16.w,
      ).copyWith(right: 0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    uid: widget.appPost?.uid ?? "",
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius: 20.r,
              backgroundImage: NetworkImage(
                widget.appPost?.profileImage ?? "",
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.appPost?.username ?? "",
                    style: AppTextStyle.textStyle14.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    providerUser.user?.username ?? "",
                    style: AppTextStyle.textStyle14.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //? tap delete post
          IconButton(
            onPressed: () {
              showDialog(
                useRootNavigator: false,
                context: context,
                builder: (context) {
                  return Dialog(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shrinkWrap: true,
                      children: [
                        'Delete',
                      ]
                          .map(
                            (e) => InkWell(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 16.w,
                                ),
                                child: Text(e),
                              ),
                              onTap: () {
                                viewModel.deletePost(
                                    postId: widget.appPost!.postId);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }
}
