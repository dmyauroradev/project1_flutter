import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/const/constants.dart';
import 'package:app_1/src/cart/controllers/cart_notifier.dart';
import 'package:app_1/src/cart/models/cart_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckoutTile extends StatelessWidget {
  const CheckoutTile({super.key, required this.cart});

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '',
      decimalDigits: 0,
    );

    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Container(
            width: ScreenUtil().screenWidth,
            height: 90.h,
            decoration: BoxDecoration(
                color: Kolors.kPrimaryLight.withOpacity(0.2),
                borderRadius: kRadiusAll),
            child: SizedBox(
              height: 85.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Kolors.kWhite,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              topRight: Radius.circular(12),
                            )),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: kRadiusAll,
                              child: SizedBox(
                                width: 76.w,
                                height: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: cart.product.imageUrls[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ReusableText(
                              text: cart.product.title,
                              style: appStyle(
                                  12, Kolors.kDart, FontWeight.normal)),
                          ReusableText(
                              text:
                                  'Kích thước: ${cart.dimensions}  ||  Mã màu: ${cart.code}',
                              style: appStyle(
                                  12, Kolors.kGray, FontWeight.normal)),
                          SizedBox(
                            width: ScreenUtil().screenWidth * .5,
                            child: Text(cart.product.description,
                                maxLines: 2,
                                textAlign: TextAlign.justify,
                                style: appStyle(
                                    9, Kolors.kGray, FontWeight.normal)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartNotifier.setSelectedCounter(
                                cart.id, cart.quantity);
                          },
                          onDoubleTap: () {},
                          child: Container(
                            width: 40.w,
                            height: 20.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Kolors.kPrimary,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: ReusableText(
                                text: 'x ${cart.quantity}',
                                style: appStyle(
                                    12, Kolors.kPrimary, FontWeight.normal)),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: ReusableText(
                              //text: '${(cart.quantity * cart.product.price)} VNĐ',
                              text:
                                  '${formatCurrency.format(cart.quantity * cart.product.price)} VNĐ',
                              style: appStyle(
                                  12, Kolors.kPrimary, FontWeight.w600)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
