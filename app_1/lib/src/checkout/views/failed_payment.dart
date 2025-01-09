import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/const/constants.dart';
import 'package:app_1/const/resource.dart';
import 'package:app_1/src/cart/controllers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FailedPayment extends StatelessWidget {
  const FailedPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableText(
            text: "Thanh Toán",
            style: appStyle(16, Kolors.kPrimary, FontWeight.w600)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              R.ASSETS_IMAGES_EMPTY_PNG, //ASSETS_IMAGES_FAILED_PNG,
              width: 250.w,
              height: 250.h,
            ),
          ),
          Center(
            child: ReusableText(
              text: "Thanh toán thất bại",
              style: appStyle(20, Kolors.kPrimary, FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: ReusableText(
              text: "Oops! Thanh toán thất bại! Vui lòng thử lại",
              style: appStyle(14, Kolors.kGray, FontWeight.normal),
            ),
          )
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          context.read<CartNotifier>().setPaymentUrl('');
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
                text: "Quay lại Trang chủ",
                style: appStyle(16, Kolors.kWhite, FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
