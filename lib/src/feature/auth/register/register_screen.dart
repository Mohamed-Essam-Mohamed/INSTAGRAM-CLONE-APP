import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';

import 'package:instagram_clone/src/feature/auth/widget/signup_or_login_widget.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';

import 'package:instagram_clone/src/widget/custom_button_widget.dart';
import 'package:instagram_clone/src/widget/custom_text_form_widget.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = 'RegisterScreen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mobileBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(100.h),
                Image.asset(
                  "assets/images/icon-instagram-logo.png",
                  width: 182.w,
                  height: 49.h,
                ),
                Gap(50.h),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 64.r,
                      backgroundImage: const NetworkImage(
                        "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    Positioned(
                      bottom: -10.h,
                      left: 80.w,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_a_photo,
                          size: 28.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(15.h),
                CustomTextFormFieldWidget(
                  label: "username",
                  hintText: "Enter your username",
                  controller: TextEditingController(),
                  myValidator: (textValue) {},
                ),
                Gap(10.h),
                CustomTextFormFieldWidget(
                  label: "Email",
                  hintText: "Enter your email",
                  controller: TextEditingController(),
                  myValidator: (textValue) {},
                ),
                Gap(10.h),
                CustomTextFormFieldWidget(
                  label: "password",
                  hintText: "Enter your password",
                  controller: TextEditingController(),
                  myValidator: (textValue) {},
                ),
                Gap(10.h),
                CustomTextFormFieldWidget(
                  label: "Bio",
                  hintText: "Enter your bio",
                  controller: TextEditingController(),
                  myValidator: (textValue) {},
                ),
                Gap(25.h),
                CustomButtonWidget(
                  buttonText: "Register",
                  onPressed: () {},
                ),
                Gap(50.h),
                SignUpOrLoginWidget(
                  title: 'Don\'t have an account?',
                  subTitle: 'Sign up',
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
