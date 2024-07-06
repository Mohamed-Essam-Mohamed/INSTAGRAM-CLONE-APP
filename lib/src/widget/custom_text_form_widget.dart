import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';

typedef Validator = String? Function(String?);

class CustomTextFormFieldWidget extends StatefulWidget {
  String label;
  TextInputType keyboardType;
  bool obscureText;

  bool isPassword;
  TextEditingController controller;
  Validator myValidator;

  CustomTextFormFieldWidget({
    required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    required this.controller,
    required this.myValidator,
  });

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: TextFormField(
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColor,
        ),
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          fillColor: AppColors.mobileSearchColor,
          filled: true,
          labelText: widget.label,
          labelStyle: AppTextStyle.textStyle18
              .copyWith(fontSize: 20.sp, color: AppColors.primaryColor),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 25.sp, vertical: 15.sp),
          enabledBorder:
              _outLineInputBorder(color: AppColors.mobileBackgroundColor),
          focusedBorder: _outLineInputBorder(color: AppColors.blueColor),
          errorBorder: _outLineInputBorder(color: AppColors.redColor),
        ),
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        validator: widget.myValidator,
      ),
    );
  }

  OutlineInputBorder _outLineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
    );
  }
}
