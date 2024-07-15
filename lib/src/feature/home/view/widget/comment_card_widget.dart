import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/src/data/firebase/app_firebase.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentCardWidget extends StatelessWidget {
  CommentCardWidget({
    super.key,
    required this.comment,
    required this.userName,
    required this.photoUrl,
    required this.time,
    required this.postId,
    required this.commentId,
    required this.likes,
  });
  final String comment;
  final String userName;
  final String photoUrl;
  final DateTime time;
  final String postId;
  final String commentId;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final List likes;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(time.toString());
    var date = timeago.format(dateTime, locale: 'en_short');

    return SizedBox(
      height: 60.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundImage: NetworkImage(photoUrl),
          ),
          Gap(10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    userName,
                    style: AppTextStyle.textStyle14.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Gap(10.w),
                  Text(
                    date,
                    // "1H",
                    style: AppTextStyle.textStyle14.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColor.shade700,
                    ),
                  ),
                ],
              ),
              Gap(5.h),
              Text(
                comment,
                style: AppTextStyle.textStyle14.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  AppFirebase.updateLikesComment(
                    postId: postId,
                    commentId: commentId,
                    likes: likes,
                    uid: uid,
                  );
                },
                child: likes.contains(uid)
                    ? SvgPicture.asset(
                        "assets/icons/Icon-select-love.svg",
                        color: AppColors.redColor,
                        height: 17.h,
                        width: 17.w,
                      )
                    : SvgPicture.asset(
                        "assets/icons/Icon-unselect-love.svg",
                        height: 17.h,
                        width: 17.w,
                      ),
              ),
              likes.isEmpty ? const Text("") : Text("${likes.length}"),
            ],
          ),
        ],
      ),
    );
  }
}
