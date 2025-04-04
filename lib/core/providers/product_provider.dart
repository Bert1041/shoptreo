import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoptreo/core/models/product.dart';

class ProductProvider with ChangeNotifier {
  final String _baseUrl = 'https://fakestoreapi.com/products';

  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _products = data.map((json) => Product.fromJson(json)).toList();
      } else {
        _error = 'Failed to fetch products. Try again later.';
      }
    } catch (e) {
      _error = 'An error occurred: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }
}
