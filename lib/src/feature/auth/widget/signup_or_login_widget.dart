import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_style.dart';

class SignUpOrLoginWidget extends StatelessWidget {
  const SignUpOrLoginWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTap,
  });
  final String title;
  final String subTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyle.textStyle16.copyWith(
            color: AppColors.secondaryColor,
          ),
        ),
        Gap(5.w),
        InkWell(
          onTap: onTap,
          child: Text(
            subTitle,
            style: AppTextStyle.textStyle16.copyWith(
              fontSize: 17,
              color: AppColors.blueColor,
            ),
          ),
        ),
      ],
    );
  }
}
