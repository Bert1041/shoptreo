import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shoptreo/core/exceptions/api_exception.dart';
import 'package:shoptreo/core/models/product.dart';

class ProductApiService {
  final String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$_baseUrl/products');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw ApiException('Failed to load products. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw ApiException('No Internet connection.');
    } on FormatException {
      throw ApiException('Bad response format.');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  Future<Product> fetchProductById(int id) async {
    final url = Uri.parse('$_baseUrl/products/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Product.fromJson(data);
      } else if (response.statusCode == 404) {
        throw ApiException('Product not found.');
      } else {
        throw ApiException('Failed to load product. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw ApiException('No Internet connection.');
    } on FormatException {
      throw ApiException('Bad response format.');
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }
}
