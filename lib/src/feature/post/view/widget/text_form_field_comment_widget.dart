import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';

class TextFieldCommentWidget extends StatelessWidget {
  const TextFieldCommentWidget({
    super.key,
    required this.commentController,
  });
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: commentController,
        maxLines: 4,
        minLines: 2,
        decoration: InputDecoration(
          hintText: 'Write a comment...',
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
