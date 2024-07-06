import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });
  final String buttonText;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blueColor,
        minimumSize: const Size(double.infinity, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
        textStyle: AppTextStyle.textStyle18.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(buttonText),
      ),
    );
  }
}
