// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';

import 'app_colors.dart';

class DialogApp {
  static void showLoading(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(color: AppColors.primaryColor),
              Gap(12.w),
              Text(
                message,
                style: AppTextStyle.textStyle16.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showMessage(
      {required BuildContext context, required String message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return AlertDialog(
          title: Text(
            "warning".toUpperCase(),
            style: AppTextStyle.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
            style: AppTextStyle.textStyle16.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: AppTextStyle.textStyle16.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
