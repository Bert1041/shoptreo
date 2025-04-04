import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptreo/config/constants/colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double margin;
  final Color outlineButtonColor;
  final Color outlineBackgroundColor;
  final double height;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.margin = 20,
    this.outlineButtonColor = Colors.white,
    this.outlineBackgroundColor = Colors.transparent,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: margin),
      child: isPrimary
          ? ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEE571C),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style:  TextStyle(
            fontFamily: 'Filson Pro',
            fontSize: 13.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      )
          : OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: outlineBackgroundColor,
          side: BorderSide(color: outlineButtonColor),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Filson Pro',
            fontSize: 13.sp,
            color: outlineButtonColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
