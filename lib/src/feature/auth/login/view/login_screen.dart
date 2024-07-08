import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/src/feature/auth/login/view_model/login_view_model_cubit.dart';
import 'package:instagram_clone/src/feature/auth/widget/facebook_login_widget.dart';
import 'package:instagram_clone/src/feature/auth/widget/option_or_widget.dart';
import 'package:instagram_clone/src/feature/auth/widget/signup_or_login_widget.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';
import 'package:instagram_clone/src/utils/dialog_app.dart';
import 'package:instagram_clone/src/widget/custom_button_widget.dart';
import 'package:instagram_clone/src/widget/custom_text_form_widget.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModelCubit viewModel = LoginViewModelCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mobileBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Center(
          child: SingleChildScrollView(
            child: BlocListener<LoginViewModelCubit, LoginViewModelState>(
              bloc: viewModel,
              listener: (context, state) {
                if (state is LoginViewModelLoading) {
                  DialogApp.showLoading(context, "Logging in...");
                }
                if (state is LoginViewModelError) {
                  DialogApp.showMessage(
                    context: context,
                    message: state.errorMessage,
                  );
                }
                if (state is LoginViewModelSuccess) {
                  Navigator.of(context).pop();
                }
              },
              child: Form(
                key: viewModel.formKey,
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
                    CustomTextFormFieldWidget(
                      label: "Email",
                      hintText: "Enter your email",
                      controller: viewModel.emailController,
                      myValidator: (textValue) {
                        if (textValue!.trim().isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    Gap(10.h),
                    CustomTextFormFieldWidget(
                      label: "password",
                      hintText: "Enter your password",
                      controller: viewModel.passwordController,
                      myValidator: (textValue) {
                        if (textValue!.trim().isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    Gap(10.h),
                    _forgotPasswordWidget(),
                    Gap(15.h),
                    CustomButtonWidget(
                      buttonText: "Log in",
                      onPressed: () {
                        viewModel.login();
                      },
                    ),
                    Gap(15.h),
                    const OptionOrWidget(),
                    Gap(20.h),
                    FacebookLoginWidget(
                      onTap: () {},
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
        ),
      ),
    );
  }

  InkWell _forgotPasswordWidget() {
    return InkWell(
      onTap: () {
        // Add your 'Forgot password?' behavior here
      },
      child: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Forgot password?',
          style: AppTextStyle.textStyle14,
        ),
      ),
    );
  }
}
