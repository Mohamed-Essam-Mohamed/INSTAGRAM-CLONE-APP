import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';
import 'package:intl/intl.dart';

class CommentCardWidget extends StatelessWidget {
  const CommentCardWidget(
      {super.key,
      required this.comment,
      required this.userName,
      required this.photoUrl,
      required this.time});
  final String comment;
  final String userName;
  final String photoUrl;
  final time;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      child: Row(
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
                    // DateFormat.yMMMd().format(time.toDate()),
                    "1H",
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
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/Icon-unselect-love.svg"),
          ),
        ],
      ),
    );
  }
}
