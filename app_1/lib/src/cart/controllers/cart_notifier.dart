import 'dart:convert';

import 'package:app_1/common/services/storage.dart';
import 'package:app_1/common/utils/environment.dart';
import 'package:app_1/src/cart/models/cart_model.dart';
import 'package:app_1/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:app_1/src/products/controllers/colors_sizes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartNotifier with ChangeNotifier {
  Function? refetchCount;

  int subtotal = 0; // Tổng giá trị các sản phẩm trong giỏ hàng.
  int shippingFee = 30000;
  int discount = 0;
  int totalPrice = 0;
  List<String> selectedDiscounts = [];

  bool isFreeShippingSelected = false;
  bool isDiscountSelected = false;

  void toggleFreeShipping() {
    isFreeShippingSelected = !isFreeShippingSelected;
    applyPromotions();
    notifyListeners();
  }

  void toggleDiscount() {
    isDiscountSelected = !isDiscountSelected;
    applyPromotions();
    notifyListeners();
  }

  int get totalQuantity =>
      selectedCartItems.fold(0, (sum, item) => sum + item.quantity);

  void applyPromotions({bool freeShipping = false, bool discount = false}) {
    selectedDiscounts.clear();

    if (isDiscountSelected) {
      selectedDiscounts.add("10PercentOff");
      this.discount = (subtotal * 0.1).toInt();
    } else {
      this.discount = 0;
    }
    if (isFreeShippingSelected) {
      selectedDiscounts.add("freeShipping");
      shippingFee = 0;
    } else {
      shippingFee = 30000;
    }
    // Tính lại tổng số tiền
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    totalPrice = subtotal + shippingFee - discount;
    notifyListeners();
  }

  void updateSubtotal(int newSubtotal) {
    subtotal = newSubtotal;
    calculateTotalAmount(); // Tự động cập nhật tổng số tiền khi thay đổi subtotal
  }

  void setRefetchCount(Function r) {
    refetchCount = r;
  }

  int _qty = 0;

  int get qty => _qty;

  void increment() {
    _qty++;
    notifyListeners();
  }

  void decrement() {
    if (_qty > 1) {
      _qty--;
      notifyListeners();
    }
  }

  int? _selectCart;

  int? get selectedCart => _selectCart;

  void setSelectedCounter(int id, int q) {
    _selectCart = id;
    _qty = q;
    notifyListeners();
  }

  void clearSelected() {
    _selectCart = null;
    _selectedCartItems.clear();
    _selectedCartItemsId.clear();
    _qty = 0;
    notifyListeners();
  }

  Future<void> deleteCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/delete/?id=$id');

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        refetch();
        refetchCount!();
        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/cart/update/?id=$id&count=$qty');

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        refetch();
        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addToCart(String data, BuildContext ctx) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/add/');

      final response = await http.post(
        url,
        body: data,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        refetchCount!();

        //navigate to the cart
        ctx.read<ColorSizesNotifier>().setSizes('');
        ctx.read<ColorSizesNotifier>().setColor('');
        ctx.read<TabIndexNotifier>().setIndex(2);
        ctx.go('/home');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<int> _selectedCartItemsId = [];

  List<int> get selectedCartItemsId => _selectedCartItemsId;

  List<CartModel> _selectedCartItems = [];

  List<CartModel> get selectedCartItems => _selectedCartItems;

  void calculateSubtotal() {
    subtotal = selectedCartItems.fold(
        0, (sum, item) => sum + item.product.price * item.quantity);
    calculateTotalAmount();
  }

  //int totalPrice = 0;

  void selectOrDeselect(int id, CartModel cartItem) {
    if (_selectedCartItemsId.contains(id)) {
      _selectedCartItemsId.remove(id);
      _selectedCartItems.removeWhere((i) => i.id == id);
      totalPrice = calculateTotalPrice(_selectedCartItems);
    } else {
      _selectedCartItemsId.add(id);
      _selectedCartItems.add(cartItem);
      totalPrice = calculateTotalPrice(_selectedCartItems);
    }
    calculateSubtotal();
    notifyListeners();
  }

  int calculateTotalPrice(List<CartModel> items) {
    int tp = 0;
    for (var item in items) {
      tp += item.product.price * item.quantity;
    }
    return tp;
  }

  String _paymentUrl = '';

  String get paymentUrl => _paymentUrl;

  void setPaymentUrl(String url) {
    //_paymentUrl = url;
    _paymentUrl = url.isNotEmpty ? url : '';
    print("setPaymentUrl was called with URL: $url"); // In ra URL
    notifyListeners();
  }

  String _success = '';

  String get success => _success;

  void setSuccessUrl(String url) {
    _success = url;
    notifyListeners();
  }

  Future<bool> createCheckout(String data) async {
    // Lấy accessToken từ Storage
    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null || accessToken.isEmpty) {
      print("Access token is missing. Please log in again.");
      return false;
    }

    final requestData = json.encode({
      ...json.decode(data),
      "discountOptions": selectedDiscounts,
    }); // Include selected discounts

    //print("Request Data: $requestData");

    try {
      Uri url = Uri.parse(Environment.paymentBaseUrl);

      final response = await http.post(
        url,
        body: utf8.encode(requestData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      print("JSON data for createCheckout: $requestData");
      print("JSON data for createOrder: $requestData");

      // Kiểm tra phản hồi từ API
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true &&
            responseData['paymentUrl'] != null) {
          print("Checkout created successfully.");
          setPaymentUrl(responseData['paymentUrl']); // Set the payment URL
          print("Payment URL: $paymentUrl");

          return true;
        } else {
          print(
              "Failed to create checkout: ${responseData['error'] ?? 'Unknown error'}");
          print("Response body: ${utf8.decode(response.bodyBytes)}");
          return false;
        }
      } else {
        print("Error: Received non-success status code ${response.statusCode}");
        return false;
      }
    } on http.ClientException catch (e) {
      print("ClientException occurred: $e");
      return false;
    } on FormatException catch (e) {
      print("FormatException occurred while decoding JSON: $e");
      return false;
    } catch (e) {
      print("Unknown error creating checkout: $e");
      return false;
    }
  }

  Future<dynamic> createOrder(String requestData) async {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null || accessToken.isEmpty) {
      print("Access token is missing. Please log in again.");
      return false;
    }

    try {
      // appBaseUrl URL API cho đơn hàng paymentBaseUrl
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/orders/add');
      print("Creating order with URL: $url");

      // Gửi yêu cầu POST đến API
      final response = await http.post(
        url, body: utf8.encode(requestData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
        //body: requestData,
        //body: data,
      );

      // Log response status and body for debugging
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Kiểm tra phản hồi từ API
      if (response.statusCode == 201) {
        print("Order created successfully.");
        return true;
      } else {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        String errorMessage = responseData['message'] ?? 'Unknown error';
        print("Failed to create order: $errorMessage");
        return responseData['message'] ?? 'Đã xảy ra lỗi không xác định.';
      }
    } catch (e) {
      print("Error creating order: $e");
      return false;
    }
  }
}
