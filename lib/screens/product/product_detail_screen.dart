import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  bool _showFullDescription = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productId = ModalRoute.of(context)!.settings.arguments as int;
    _productFuture = _apiService.fetchProductById(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: FutureBuilder<Product>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final product = snapshot.data!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoryTag(product.category),
                const SizedBox(height: 8),
                _buildProductImage(product.image),
                const SizedBox(height: 16),
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Filson Pro',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '₦${product.price} / Piece',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                _buildRating(product.rating.rate, product.rating.count),
                const Divider(height: 32),
                _buildSectionLabel('Description'),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showFullDescription = !_showFullDescription;
                    });
                  },
                  child: Text(
                    _showFullDescription
                        ? product.description
                        : product.description.substring(0, 120) + '...',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ),
                const SizedBox(height: 24),
                _buildSectionLabel('Company'),
                const SizedBox(height: 6),
                Text('Ghian Apparels & Couture', style: _infoTextStyle()),
                const SizedBox(height: 24),
                _buildSectionLabel('Delivery'),
                const SizedBox(height: 6),
                Text(
                  'Delivery time is estimated by manufacturers.',
                  style: _infoTextStyle(),
                ),
                const SizedBox(height: 40),
                _buildActionButtons(),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      flexibleSpace: Image.asset(
        'assets/images/appbar.png',
        fit: BoxFit.cover,
      ),
      title: Text(
        'Product Information',
        style: TextStyle(
          fontFamily: 'Filson Pro',
          fontSize: 20.sp,
          color: AppColors.white,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: AppColors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCategoryTag(String category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 4.r),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        category.toUpperCase(),
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.network(
        imageUrl,
        height: 280.h,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const AppLoader();
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 280.h,
            color: Colors.grey.shade200,
            child: const Center(child: Icon(Icons.image_not_supported)),
          );
        },
      ),
    );
  }

  Widget _buildRating(double rate, int count) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rate,
          itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: 18.sp,
        ),
        SizedBox(width: 8.w),
        Text('($count reviews)', style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: 'Filson Pro',
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 44.h,
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
        Expanded(
          child: SizedBox(
            height: 44.h,
            child: AppButton(
              label: 'BUY NOW',
              isPrimary: true,
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _infoTextStyle() {
    return TextStyle(
      fontSize: 13.sp,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    );
  }
}
