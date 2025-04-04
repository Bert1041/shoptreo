import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptreo/config/constants/colors.dart';

class TopPicksCard extends StatelessWidget {
  const TopPicksCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 29.0),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none, // Allow the image to overflow outside the container
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wine_bar_outlined, color: Colors.white, size: 20.0),
                      SizedBox(width: 8.0),
                      Text(
                        'Top Picks',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Best Seller | Popular Supplier',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.0.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Positioned image outside the container
          Positioned(
            right: -10, // Adjust this value to move the image further out
            top: -50, // Adjust this value to change how far above the container the image is
            child: Image.asset(
              'assets/images/trophy.png',
              // height: 100.0, // Set the height of the image
            ),
          ),
        ],
      ),
    );
  }
}
