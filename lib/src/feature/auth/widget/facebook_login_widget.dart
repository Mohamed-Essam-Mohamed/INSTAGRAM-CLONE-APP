import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';

class FacebookLoginWidget extends StatelessWidget {
  const FacebookLoginWidget({
    super.key,
    required this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Icon-facebook.png',
            width: 25.w,
            height: 25.h,
            color: AppColors.blueColor,
            fit: BoxFit.contain,
          ),
          Gap(10.w),
          Text(
            'Login with Facebook',
            style: AppTextStyle.textStyle16.copyWith(
              color: AppColors.blueColor,
            ),
          ),
        ],
      ),
    );
  }
}
