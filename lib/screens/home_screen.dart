import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoptreo/config/constants/colors.dart';
import 'package:shoptreo/core/providers/auth_provider.dart';
import 'package:shoptreo/core/providers/product_provider.dart';
import 'package:shoptreo/shared/widgets/app_loader.dart';
import 'package:shoptreo/shared/widgets/custom_search_field.dart';
import 'package:shoptreo/shared/widgets/product_card.dart';
import 'package:shoptreo/shared/widgets/top_picks_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController =
      TextEditingController(); // Add controller

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
    _searchController.addListener(
      _onSearchChanged,
    ); // Listen to changes in the search field
    _scrollController.addListener(_scrollListener);
  }

  void _onSearchChanged() {
    // When search input changes, filter the products
    final query = _searchController.text.toLowerCase();
    context.read<ProductProvider>().filterProducts(query);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductProvider>().loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          return RefreshIndicator(
            onRefresh: () async {
              await productProvider.fetchProducts();
            },
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(20.0),
              children: [
                SizedBox(height: 15.h),
                CustomSearchField(
                  controller: _searchController,
                  onQrTap: () {},
                  onCameraTap: () {},
                ),
                SizedBox(height: 50.h),
                const TopPicksCard(),
                SizedBox(height: 50.h),
                Text(
                  "You May Like",
                  style: TextStyle(
                    fontFamily: 'Filson Pro',
                    fontSize: 22.sp,
                    color: AppColors.greyShade,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.h),
                _buildHomeContent(productProvider),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      centerTitle: false,
      title: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return RichText(
            text: TextSpan(
              text: 'Hello,\n',
              style: TextStyle(
                fontFamily: 'Filson Pro',
                fontSize: 24.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: authProvider.userName ?? 'Guest',
                  style: TextStyle(
                    fontFamily: 'Filson Pro',
                    fontSize: 17.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.message_outlined, semanticLabel: 'Messages'),
          color: AppColors.primary,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, semanticLabel: 'Cart'),
          color: AppColors.primary,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, semanticLabel: 'Alerts'),
          color: AppColors.primary,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildHomeContent(ProductProvider productProvider) {
    if (productProvider.isLoading && productProvider.visibleProducts.isEmpty) {
      return const AppLoader();
    }

    if (productProvider.isError) {
      return _buildErrorState(productProvider);
    }

    if (productProvider.visibleProducts.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // Let ListView handle scroll
      itemCount:
          productProvider.visibleProducts.length +
          (productProvider.hasMore ? 1 : 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: (ScreenUtil().screenWidth / 2) / 320,
      ),
      itemBuilder: (context, index) {
        if (index >= productProvider.visibleProducts.length) {
          return const AppLoader();
        }
        return ProductCard(product: productProvider.visibleProducts[index]);
      },
    );
  }

  Widget _buildErrorState(ProductProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: AppColors.primary, size: 40.sp),
          SizedBox(height: 10.h),
          Text(
            provider.errorMessage ?? 'An error occurred.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Filson Pro',
              fontSize: 16.sp,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () => provider.fetchProducts(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          'No products available at the moment.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Filson Pro',
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
