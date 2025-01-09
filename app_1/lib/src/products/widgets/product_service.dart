import 'dart:convert';

import 'package:app_1/common/utils/environment.dart';
import 'package:app_1/src/products/models/products_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<Products> fetchProductById(int productId) async {
    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/products/product/$productId/');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final product = Products.fromJson(json.decode(response.body));
        return product;
      } else {
        throw Exception(
            "Lỗi khi tải sản phẩm, mã trạng thái: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Lỗi khi gọi API: $e");
    }
  }
}
