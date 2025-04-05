import 'package:flutter/material.dart';
import 'package:shoptreo/core/models/product.dart';
import 'package:shoptreo/core/services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductApiService _productApiService;

  List<Product> _products = [];
  List<Product> _visibleProducts = [];
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isError = false;
  String? _errorMessage;

  ProductProvider(this._productApiService);  // Inject ProductApiService through the constructor

  List<Product> get products => _products;
  List<Product> get visibleProducts => _visibleProducts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  bool get isError => _isError;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _isError = false;
    _errorMessage = null;
    notifyListeners();

    try {
      final List<Product> fetchedProducts = await _productApiService.fetchProducts();
      _products = fetchedProducts;
      _visibleProducts = _products.take(10).toList();
      _hasMore = _products.length > 10;
    } catch (e) {
      _isError = true;
      _errorMessage = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void loadMoreProducts() {
    if (!_hasMore || _isLoading) return;

    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 500), () {
      final nextIndex = _visibleProducts.length;
      final endIndex = nextIndex + 10;

      _visibleProducts.addAll(
        _products.sublist(
          nextIndex,
          endIndex > _products.length ? _products.length : endIndex,
        ),
      );
      _hasMore = endIndex < _products.length;

      _isLoading = false;
      notifyListeners();
    });
  }
}
