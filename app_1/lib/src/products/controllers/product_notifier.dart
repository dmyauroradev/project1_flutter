import 'package:app_1/src/products/models/products_model.dart';
import 'package:app_1/src/products/widgets/product_service.dart';
import 'package:flutter/material.dart';

class ProductNotifier with ChangeNotifier {
  Products? product;

  void setProuct(Products p) {
    product = p;
    notifyListeners();
  }

  bool _description = false;

  bool get description => _description;

  void setDescription() {
    _description = !_description;
    notifyListeners();
  }

  void resetDescription() {
    _description = false;
  }

  Future<void> fetchProduct(int productId) async {
    try {
      product = await ProductService.fetchProductById(productId);
      //product = fetchProduct;
      notifyListeners();
    } catch (e) {
      print("Lỗi khi tải sản phẩm: $e");
    }
  }
}
