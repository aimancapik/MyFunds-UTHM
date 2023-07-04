import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_color.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    this.textInputAction,
    this.onSubmitted,
    this.controller,
    this.isPassword = false,
    this.hintText,
    this.validator, // Add the validator function
  });

  final bool isPassword;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator; // Define the validator function

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
      cursorColor: Colors.blue,
      style: Theme.of(context).textTheme.bodyMedium,
      validator: validator, // Assign the validator function
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.kPlaceholder3,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            8.r,
          ),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColor.kTextColor1,
          fontSize: 14.sp,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
      ),
    );
  }
}
