import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/back_button.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/src/cart/controllers/cart_notifier.dart';
import 'package:app_1/src/promotion/widgets/promotion_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionPage extends StatelessWidget {
  const PromotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartNotifier = context.watch<CartNotifier>();

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
            text: AppText.kPromotion,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          PromotionTile(
            title: "Freeship",
            description: "Miễn phí vận chuyển cho đơn hàng của bạn.",
            isSelected: cartNotifier.isFreeShippingSelected,
            onSelected: (selected) {
              cartNotifier.toggleFreeShipping();
            },
          ),
          PromotionTile(
            title: "Giảm 10%",
            description: "Giảm 10% trên tổng đơn hàng",
            isSelected: cartNotifier.isDiscountSelected,
            onSelected: (selected) {
              cartNotifier.toggleDiscount();
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              //"Đã chọn $selectedPromotions ưu đãi",
              "Đã chọn ${cartNotifier.selectedDiscounts.length} ưu đãi",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, cartNotifier.selectedDiscounts.length);
              },
              child: const Text(
                "Áp dụng",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
