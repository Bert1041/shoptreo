import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptreo/config/constants/colors.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final void Function()? onQrTap;
  final void Function()? onCameraTap;
  final TextEditingController? controller;

  const CustomSearchField({
    super.key,
    this.hintText = 'Search Products/Vendors',
    this.onQrTap,
    this.onCameraTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Filson Pro',
            fontSize: 13.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.qr_code_scanner, color: Colors.grey),
                onPressed: onQrTap,
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.grey),
                onPressed: onCameraTap,
              ),
            ],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
