import 'dart:convert';

import 'package:app_1/common/services/storage.dart';
import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/back_button.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/src/addresses/controllers/address_notifier.dart';
import 'package:app_1/src/addresses/hooks/fetch_default.dart';
import 'package:app_1/src/addresses/widgets/address_block.dart';
import 'package:app_1/src/cart/controllers/cart_notifier.dart';
import 'package:app_1/src/checkout/models/check_out_model.dart';
import 'package:app_1/src/checkout/views/payment_iframe.dart';
import 'package:app_1/src/checkout/views/paymethod_screen.dart';
import 'package:app_1/src/checkout/widgets/check_out_summary.dart';
import 'package:app_1/src/checkout/widgets/checkout_tile.dart';
import 'package:app_1/src/promotion/views/promotion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends HookWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accessToken = Storage().getString('accessToken') ?? '';
    final rzlt = fetchDefaultAddress();
    final address = rzlt.address;
    final isLoading = rzlt.isLoading;
    final selectedPaymentMethod = useState<String>('Phương thức thanh toán');
    final cartNotifier = Provider.of<CartNotifier>(context, listen: false);

    void placeOrder(BuildContext context) async {
      if (selectedPaymentMethod.value == 'Phương thức thanh toán') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Vui lòng chọn phương thức thanh toán")),
        );
        return;
      }

      if (address == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Vui lòng thêm địa chỉ")),
        );
        context.push('/addresses');
        return;
      }

      List<CartItem> checkoutItems = cartNotifier.selectedCartItems.map((item) {
        return CartItem(
          name: item.product.title,
          id: item.product.id,
          price: item.product.price,
          cartQuantity: item.quantity,
          code: item.code,
          dimensions: item.dimensions,
        );
      }).toList();

      CreateCheckout checkoutData = CreateCheckout(
        address: address.id,
        accesstoken: accessToken,
        totalAmount: cartNotifier.totalPrice,
        cartItems: checkoutItems,
        fcm: '',
      );

      Map<String, dynamic> requestData =
          json.decode(createCheckoutToJson(checkoutData));

      if (selectedPaymentMethod.value == 'Tiền mặt') {
        requestData.addAll({
          "customer_id": "Hvfdfhvkfvfvg789",
          "total_quantity": cartNotifier.totalQuantity,
          "subtotal": cartNotifier.subtotal,
          "total": cartNotifier.totalPrice,
          "delivery_status": "pending",
          "payment_status": "Thanh toán khi nhận hàng",
          "order_products": checkoutItems.map((item) {
            return {
              "product": item.id,
              "quantity": item.cartQuantity,
              "dimensions": item.dimensions,
              "code": item.code,
            };
          }).toList(),
        });
      }

      final isCash = selectedPaymentMethod.value == 'Tiền mặt';
      final response = isCash
          ? await cartNotifier.createOrder(json.encode(
              requestData,
            ))
          : await cartNotifier.createCheckout(json.encode(requestData));

      /*f (response is bool && response) {
        print("Order placed successfully.");
        if (isCash) {
          context.push('/order_success');
        } else if (context.mounted) {
          final paymentUrl = cartNotifier.paymentUrl;
          if (paymentUrl.isNotEmpty && paymentUrl.contains('zalopay.vn')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentIFramePage(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Không tìm thấy URL thanh toán ZaloPay"),
              ),
            );
          }
        } else if (response is String) {
          // Hiển thị lý do cụ thể từ API
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Đặt hàng thất bại")),
          );
        }
      }*/

      if (response == true) {
        // Đặt hàng thành công
        print("Order placed successfully.");
        if (isCash) {
          context.push('/order_success');
        } else if (context.mounted) {
          final paymentUrl = cartNotifier.paymentUrl;

          if (paymentUrl.isNotEmpty && paymentUrl.contains('zalopay.vn')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentIFramePage(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Không tìm thấy URL thanh toán ZaloPay"),
              ),
            );
          }
        }
      } else if (response is String) {
        // Hiển thị lý do cụ thể từ API
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response)),
        );
      } else {
        // Đặt hàng thất bại
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đặt hàng thất bại")),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.read<AddressNotifier>().clearAddress();
            context.pop();
          },
        ),
        title: ReusableText(
          text: AppText.kCheckout,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            children: [
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (address != null)
                AddressBlock(address: address)
              else
                const Center(child: Text("Vui lòng thêm địa chỉ")),
              const SizedBox(height: 10.0),
              Column(
                children: cartNotifier.selectedCartItems
                    .map((item) => CheckoutTile(cart: item))
                    .toList(),
              ),
              const SizedBox(height: 10.0),
              CheckoutSummary(
                subtotal: cartNotifier.subtotal,
                fees: cartNotifier.shippingFee,
                discount: cartNotifier.discount,
                total: cartNotifier.totalPrice,
              ),
              const SizedBox(height: 20.0),
              _buildPaymentMethodTile(context, selectedPaymentMethod),
              _buildPromotionTile(context, cartNotifier),
            ],
          );
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => placeOrder(context),
        child: Container(
          height: 80.0,
          color: Kolors.kPrimaryLight,
          child: Center(
            child: ReusableText(
              text: address == null ? 'Vui lòng thêm địa chỉ' : 'Đặt Hàng',
              style: appStyle(16, Kolors.kWhite, FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(
      BuildContext context, ValueNotifier<String> selectedPaymentMethod) {
    return ListTile(
      title: Text(
        selectedPaymentMethod.value,
        style: appStyle(13, Kolors.kPrimary, FontWeight.w500),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_forward_ios),
        onPressed: () async {
          final method = await Navigator.push<String>(
            context,
            MaterialPageRoute(builder: (context) => const PaymentMethodPage()),
          );
          if (method != null) selectedPaymentMethod.value = method;
        },
      ),
    );
  }

  Widget _buildPromotionTile(BuildContext context, CartNotifier cartNotifier) {
    return ListTile(
      title: Text(
        cartNotifier.selectedDiscounts.isEmpty
            ? "Áp dụng ưu đãi"
            : "Đã chọn ${cartNotifier.selectedDiscounts.length} ưu đãi",
        style: appStyle(13, Kolors.kPrimary, FontWeight.w500),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_forward_ios),
        onPressed: () async {
          final selectedCount = await Navigator.push<int>(
            context,
            MaterialPageRoute(builder: (context) => const PromotionPage()),
          );
          if (selectedCount != null) {
            cartNotifier.applyPromotions(
              freeShipping: selectedCount > 0,
              discount: selectedCount > 1,
            );
          }
        },
      ),
    );
  }
}
