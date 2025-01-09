import 'dart:ui_web';

import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/src/cart/controllers/cart_notifier.dart';
import 'package:app_1/src/checkout/views/failed_payment.dart';
import 'package:app_1/src/checkout/views/order_success.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class PaymentIFramePage extends StatelessWidget {
  //final String url;
  const PaymentIFramePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy URL thanh toán từ CartNotifier
    final paymentUrl = context.watch<CartNotifier>().paymentUrl;

    if (kIsWeb && paymentUrl.isNotEmpty) {
      // Đăng ký một view factory duy nhất với viewType là 'iframeElement'
      // Đảm bảo đã import 'dart:ui' nếu có lỗi 'platformViewRegistry'
      platformViewRegistry.registerViewFactory(
        'iframeElement',
        (int viewId) {
          final iframe = html.IFrameElement()
            ..src = paymentUrl
            ..style.border = 'none' // Xóa đường viền iframe
            ..style.width = '100%'
            ..style.height = '100%';

          // Lắng nghe sự kiện load của iframe để kiểm tra URL
          iframe.onLoad.listen((event) {
            // Kiểm tra URL hiện tại của iframe bằng iframe.src
            final currentUrl = iframe.src;

            if (currentUrl != null && currentUrl.contains("success")) {
              context.read<CartNotifier>().setPaymentUrl('');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const OrderSuccessPage()),
              );
            } else if (currentUrl != null && currentUrl.contains("fail")) {
              context.read<CartNotifier>().setPaymentUrl('');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const FailedPayment()),
              );
            }
          });
          return iframe;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: AppText.kPaymentZalopay,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: kIsWeb && paymentUrl.isNotEmpty
          ? const HtmlElementView(
              viewType: 'iframeElement', // Sử dụng view type đã đăng ký
            )
          : const Center(
              child:
                  CircularProgressIndicator()), // Hiển thị loading nếu URL chưa sẵn sàng
    );
  }
}
