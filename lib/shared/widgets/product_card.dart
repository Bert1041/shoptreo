import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptreo/config/routes/app_routes.dart';
import 'package:shoptreo/core/models/product.dart';

import '../../config/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.productDetails,
          arguments: product.id,
        );
      },
      child: Card(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Filson Pro',
                  fontSize: 8.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₦${product.price} / Piece',
                    style: TextStyle(
                      fontFamily: 'Filson Pro',
                      fontSize: 11.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '100 Pieces (MOQ)',
                        style: TextStyle(
                          fontFamily: 'Filson Pro',
                          fontSize: 10.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      
                      Icon(Icons.shopping_cart_outlined, color: Colors.grey, size: 15.sp)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
