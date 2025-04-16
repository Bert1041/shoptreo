import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptreo/config/constants/colors.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final void Function()? onQrTap;
  final void Function()? onCameraTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool autofocus;
  final int? maxLength;

  const CustomSearchField({
    super.key,
    this.hintText = 'Search Products/Vendors',
    this.onQrTap,
    this.onCameraTap,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        autofocus: autofocus,
        maxLength: maxLength,
        decoration: InputDecoration(
          counterText: '', // Hide counter for maxLength
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Filson Pro',
            fontSize: 13.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (onQrTap != null)
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner, color: Colors.grey),
                  onPressed: onQrTap,
                  splashRadius: 20.r,
                ),
              if (onCameraTap != null)
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.grey),
                  onPressed: onCameraTap,
                  splashRadius: 20.r,
                ),
            ].where((w) => w != null).toList(),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 16.w,
          ),
          errorStyle: TextStyle(
            fontSize: 10.sp,
            height: 0.5,
          ),
        ),
      ),
    );
  }
}