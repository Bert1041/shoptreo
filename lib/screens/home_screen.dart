import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoptreo/config/constants/colors.dart';
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

  @override
  void initState() {
    super.initState();
    // Schedule fetchProducts after widget build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = context.read<ProductProvider>();
      productProvider.fetchProducts(); // Fetch products after the widget builds
    });

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<ProductProvider>().loadMoreProducts(); // Load more when reached the end
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: RichText(
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
                text: 'Guest',
                style: TextStyle(
                  fontFamily: 'Filson Pro',
                  fontSize: 17.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.message_outlined,
              size: 20,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 20,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              size: 20,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: productProvider.isLoading && productProvider.visibleProducts.isEmpty
          ? const AppLoader()
          : productProvider.isError
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.primary,
              size: 40.sp,
            ),
            SizedBox(height: 10.h),
            Text(
              productProvider.errorMessage ?? 'An error occurred.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Filson Pro',
                fontSize: 16.sp,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => productProvider.fetchProducts(),
              child: const Text('Retry'),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              CustomSearchField(onQrTap: () {}, onCameraTap: () {}),
              SizedBox(height: 50.h),
              TopPicksCard(),
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
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.62,
                ),
                itemCount:
                productProvider.visibleProducts.length +
                    (productProvider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= productProvider.visibleProducts.length) {
                    return const AppLoader();
                  }
                  return ProductCard(
                    product: productProvider.visibleProducts[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
