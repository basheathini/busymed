import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class Api {
  String api = 'dev.busymed.com';

  Future<List<Product>> fetchTop20Products() async {
    final response = await http.get(Uri.https(api, 'api/products_top_20'));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return (responseJson['products'] as List).map((p) => Product.fromJson(p)).toList();
    }else {
      throw Exception('Failed to load products');
    }
  }
}