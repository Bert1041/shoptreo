import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoptreo/config/constants/colors.dart';
import 'package:shoptreo/core/models/product.dart';
import 'package:shoptreo/core/services/api_service.dart';
import 'package:shoptreo/shared/widgets/app_loader.dart';
import 'package:shoptreo/shared/widgets/reusable_app_button.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductApiService _apiService = ProductApiService();
  late Future<Product> _productFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productId = ModalRoute.of(context)!.settings.arguments as int;
    _productFuture = _apiService.fetchProductById(
      productId,
    ); // Fetch the product data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/appbar.png',
          fit: BoxFit.cover,
        ),
        title: Text(
          'Product Information',
          style: TextStyle(
            fontFamily: 'Filson Pro',
            fontSize: 22.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.white),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: FutureBuilder<Product>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppLoader();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final product = snapshot.data;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overview',
                  style: TextStyle(
                    fontFamily: 'Filson Pro',
                    fontSize: 13.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  color: AppColors.primary,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Image.network(
                        product?.image ?? '',
                        height: 390,
                        width: 390,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                Text(
                  product?.title ?? 'Product Title',
                  style: TextStyle(
                    fontFamily: 'Filson Pro',
                    fontSize: 13.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '₦${product?.price} / Piece',
                  style: TextStyle(
                    fontFamily: 'Filson Pro',
                    fontSize: 15.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Company',
                  style: TextStyle(
                    fontFamily: 'Filson Pro',
                    fontSize: 13.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Ghian Apparels & Couture',
                  style: TextStyle(
                    fontFamily: 'Filson Pro',
                    fontSize: 13.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Delivery',
                  style: TextStyle(
                    fontFamily: 'Filson Pro',
                    fontSize: 13.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Delivery time is estimated by manufacturers.',
                  style: TextStyle(
                    fontFamily: 'Filson Pro',
                    fontSize: 13.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        // Adjust this value to make the button smaller
                        child: AppButton(
                          label: 'SEND INQUIRY',
                          isPrimary: false,
                          onPressed: () {},
                          outlineButtonColor: AppColors.primary,
                          outlineBackgroundColor: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Use width for spacing, not height
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: AppButton(
                          label: 'BUY NOW',
                          isPrimary: true,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PriceTier extends StatelessWidget {
  final String price;
  final String range;

  const PriceTier({super.key, required this.price, required this.range});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 16),
          Text(range),
        ],
      ),
    );
  }
}
