import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/src/feature/auth/widget/bottom_sheet_selected_image.dart';
import 'package:instagram_clone/src/feature/post/view/selected_image_screen.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_shared_preferences.dart';
import 'package:instagram_clone/src/utils/image_functions.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late String urlImageProfile;

  File? image;
  @override
  void initState() {
    super.initState();
    urlImageProfile =
        SharedPreferencesUtils.getData(key: 'profileImageUrl') as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: _selectedImage,
          icon: Icon(
            Icons.upload_sharp,
            color: AppColors.primaryColor,
            size: 60.sp,
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
            image = temp;
          }
          setState(() {});

          image != null
              ? Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    Navigator.of(context).pushNamed(
                      SelectedImageScreen.routeName,
                      arguments: ImageDataClass(
                        image: image!,
                        urlImageProfile: urlImageProfile,
                      ),
                    );
                  },
                )
              : Navigator.pop(context);
        },
        onPressedGallery: () async {
          File? temp = await ImageFunctions.galleryPicker();
          if (temp != null) {
            image = temp;
          }
          setState(() {});
          // Navigator.pop(context);
          image != null
              ? Future.delayed(
                  const Duration(milliseconds: 200),
                  () {
                    Navigator.of(context).pushNamed(
                      SelectedImageScreen.routeName,
                      arguments: ImageDataClass(
                        image: image!,
                        urlImageProfile: urlImageProfile,
                      ),
                    );
                  },
                )
              : Navigator.pop(context);
        },
      ),
    );
  }
}

class ImageDataClass {
  File image;
  String urlImageProfile;
  ImageDataClass({required this.image, required this.urlImageProfile});
}
