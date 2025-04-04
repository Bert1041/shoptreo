import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoptreo/config/constants/colors.dart';
import 'package:shoptreo/core/models/product.dart';
import 'package:shoptreo/core/providers/auth_provider.dart';
import 'package:shoptreo/core/services/api_service.dart';
import 'package:shoptreo/shared/widgets/app_loader.dart';
import 'package:shoptreo/shared/widgets/custom_search_field.dart';
import 'package:shoptreo/shared/widgets/product_card.dart';
import 'package:shoptreo/shared/widgets/top_picks_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ProductApiService _apiService = ProductApiService();
  List<Product> _allProducts = [];
  List<Product> _visibleProducts = [];
  bool _isLoading = true;
  bool _hasMore = true;
  bool _isError = false; // Add an error flag
  String? _errorMessage; // Add a variable to store error messages
  final int _batchSize = 10;
  final ScrollController _scrollController = ScrollController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadAllProducts();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAllProducts() async {
    try {
      final products = await _apiService.fetchProducts();
      setState(() {
        _allProducts = products;
        _visibleProducts = products.take(_batchSize).toList();
        _hasMore = products.length > _batchSize;
        _isLoading = false;
        _isError = false; // Reset error flag if API is successful
      });
    } catch (e) {
      print('Error loading products: $e');
      setState(() {
        _isLoading = false;
        _isError = true; // Set error flag to true if API fails
        _errorMessage = 'Failed to load products. Please try again later.'; // Set error message
      });
    }
  }

  void _loadMoreProducts() {
    if (!_hasMore || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      final nextIndex = _visibleProducts.length;
      final endIndex = nextIndex + _batchSize;

      setState(() {
        _visibleProducts.addAll(
          _allProducts.sublist(
            nextIndex,
            endIndex > _allProducts.length ? _allProducts.length : endIndex,
          ),
        );
        _hasMore = endIndex < _allProducts.length;
        _isLoading = false;
      });
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<AuthProvider>().userName ?? 'Guest';

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
                text: userName,
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
      body: _isLoading && _visibleProducts.isEmpty
          ? const AppLoader()
          : _isError
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
              _errorMessage ?? 'An error occurred.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Filson Pro',
                fontSize: 16.sp,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: _loadAllProducts,
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
              CustomSearchField(
                onQrTap: () {
                  print("QR tapped");
                },
                onCameraTap: () {
                  print("Camera tapped");
                },
              ),
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
                itemCount: _visibleProducts.length + (_hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= _visibleProducts.length) {
                    return const AppLoader();
                  }
                  return ProductCard(product: _visibleProducts[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
