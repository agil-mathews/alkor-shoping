import 'dart:convert';

import 'package:alkor_shopin/core/constant/api_endpoints.dart';
import 'package:alkor_shopin/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductApiService {

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse(ApiEndpoints.getproducts),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
