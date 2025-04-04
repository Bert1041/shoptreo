import 'package:flutter/material.dart';
import 'package:shoptreo/config/constants/colors.dart';

class AppLoader extends StatelessWidget {
  final Color? color;
  final double? strokeWidth;

  const AppLoader({super.key, this.color, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.primary,
        strokeWidth: strokeWidth ?? 4.0,
      ),
    );
  }
}
