import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/const/constants.dart';
import 'package:app_1/src/addresses/controllers/address_notifier.dart';
import 'package:app_1/src/cart/controllers/cart_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableText(
            text: "Đặt hàng",
            style: appStyle(16, Kolors.kPrimary, FontWeight.w600)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl:
                  'https://res.cloudinary.com/ddcuxrwap/image/upload/v1730966432/check-mark-8-xxl_z1mlbk.png', // Đặt URL ảnh của bạn vào đây
              width: 250.w,
              height: 250.h,
              placeholder: (context, url) =>
                  const CircularProgressIndicator(), // Hiển thị khi tải ảnh
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error), // Hiển thị khi lỗi
            ),
          ),
          Center(
            child: ReusableText(
              text: "Đặt hàng thành công",
              style: appStyle(20, Kolors.kPrimary, FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: ReusableText(
              text: "Cảm ơn bạn đã mua hàng",
              style: appStyle(14, Kolors.kGray, FontWeight.normal),
            ),
          )
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          context.read<CartNotifier>().setPaymentUrl('');
          context.read<AddressNotifier>().clearAddress();
          /*context
              .read<NotificationNotifier>()
              .setReloadCount(NotificationCount.update);*/
          context.go('/home');
        },
        child: Container(
          height: 80,
          width: ScreenUtil().screenWidth,
          decoration:
              BoxDecoration(color: Kolors.kPrimary, borderRadius: kRadiusTop),
          child: Center(
            child: ReusableText(
                text: "Quay lại Giỏ hàng",
                style: appStyle(16, Kolors.kWhite, FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
