import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';
import 'package:instagram_clone/src/feature/auth/register/view_model/register_view_model_cubit.dart';
import 'package:instagram_clone/src/feature/auth/widget/bottom_sheet_selected_image.dart';

import 'package:instagram_clone/src/feature/auth/widget/signup_or_login_widget.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';
import 'package:instagram_clone/src/utils/dialog_app.dart';
import 'package:instagram_clone/src/utils/image_functions.dart';

import 'package:instagram_clone/src/widget/custom_button_widget.dart';
import 'package:instagram_clone/src/widget/custom_text_form_widget.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = 'RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterViewModelCubit viewModel = RegisterViewModelCubit();

  @override
  void dispose() {
    super.dispose();
    viewModel.close();
    viewModel.usernameController.dispose();
    viewModel.emailController.dispose();
    viewModel.passwordController.dispose();
    viewModel.bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mobileBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Center(
          child: SingleChildScrollView(
            child: BlocListener<RegisterViewModelCubit, RegisterViewModelState>(
              bloc: viewModel,
              listener: (context, state) {
                if (state is RegisterViewModelLoading) {
                  DialogApp.showLoading(context, "Registering...");
                }

                if (state is RegisterViewModelError) {
                  DialogApp.showMessage(
                      context: context, message: state.errorMessage);
                }
                if (state is RegisterViewModelSuccess) {
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
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 64.r,
                          backgroundImage: viewModel.image == null
                              ? const NetworkImage(
                                  "https://cvhrma.org/wp-content/uploads/2015/07/default-profile-photo.jpg",
                                )
                              : FileImage(viewModel.image!),
                          backgroundColor: Colors.transparent,
                        ),
                        Positioned(
                          bottom: -10.h,
                          left: 80.w,
                          child: IconButton(
                            onPressed: _selectedImage,
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
                      label: "name",
                      hintText: "Enter your name",
                      controller: viewModel.nameController,
                      myValidator: (textValue) {
                        if (textValue!.trim().isEmpty) {
                          return "Please enter your name";
                        }

                        if (textValue.length < 3) {
                          return "not valid name, you should be at greater 3 characters";
                        }
                        //? regular expression name
                        RegExp regex = RegExp(r'^[a-zA-Z]+$');
                        if (!regex.hasMatch(textValue)) {
                          return "your name is not valid";
                        }
                        return null;
                      },
                    ),
                    Gap(10.h),
                    CustomTextFormFieldWidget(
                      label: "username",
                      hintText: "Enter your username",
                      controller: viewModel.usernameController,
                      myValidator: (textValue) {
                        if (textValue!.trim().isEmpty) {
                          return "Please enter your username";
                        }

                        if (textValue.length <= 8) {
                          return "your username is short";
                        }
                        //? regular expression user name
                        RegExp regex =
                            RegExp(r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*$');
                        if (!regex.hasMatch(textValue)) {
                          return "your username is not valid";
                        }
                        if (viewModel.checkUniqueUsername(textValue) == false) {
                          return "your username is not unique";
                        }

                        return null;
                      },
                    ),
                    Gap(10.h),
                    CustomTextFormFieldWidget(
                      label: "Email",
                      hintText: "Enter your email",
                      controller: viewModel.emailController,
                      myValidator: (textValue) {
                        if (textValue!.trim().isEmpty) {
                          return "Please enter your email";
                        }
                        //? regular expression email
                        RegExp regex = RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                        if (!regex.hasMatch(textValue)) {
                          return "your email is not valid";
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
                        if (textValue.length <= 8) {
                          return "your password is short";
                        }

                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (!regex.hasMatch(textValue)) {
                          return "your password is not valid";
                        }
                        return null;
                      },
                    ),
                    Gap(10.h),
                    CustomTextFormFieldWidget(
                      label: "Bio",
                      hintText: "Enter your bio",
                      controller: viewModel.bioController,
                      myValidator: (textValue) {
                        if (textValue!.trim().isEmpty) {
                          return "Please enter your bio";
                        }
                        return null;
                      },
                    ),
                    Gap(25.h),
                    CustomButtonWidget(
                      buttonText: "Register",
                      onPressed: () {
                        viewModel.register();
                      },
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

  void _selectedImage() async {
    //? creat modal bottom sheet chose image from gallery or camera
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetOptions(
        onPressedCamera: () async {
          File? temp = await ImageFunctions.cameraPicker();
          if (temp != null) {
            viewModel.image = temp;
          }
          setState(() {});
          Navigator.pop(context);
        },
        onPressedGallery: () async {
          File? temp = await ImageFunctions.galleryPicker();
          if (temp != null) {
            viewModel.image = temp;
          }
          setState(() {});
          Navigator.pop(context);
        },
      ),
    );
  }
}
