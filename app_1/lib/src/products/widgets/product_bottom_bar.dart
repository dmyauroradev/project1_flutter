import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({super.key, required this.price, this.onPressed});

  final int price;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final formattedPrice =
        NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0)
            .format(price);
    return Container(
      height: 68.h,
      color: Colors.white.withOpacity(.6),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 12.w, 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.h,
              width: 130.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: ReusableText(
                        text: 'Tổng Tiền',
                        style: appStyle(14, Kolors.kGray, FontWeight.w400)),
                  ),
                  ReusableText(
                      //text: "${price.toString()} VNĐ",
                      text: "$formattedPrice VNĐ",
                      style: appStyle(16, Kolors.kDart, FontWeight.w600)),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Kolors.kPrimary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesome.shopping_bag,
                      size: 16,
                      color: Kolors.kWhite,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    ReusableText(
                        text: "Thêm vào Giỏ hàng",
                        style: appStyle(14, Kolors.kWhite, FontWeight.bold)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
