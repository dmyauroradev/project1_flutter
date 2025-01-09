import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/src/products/controllers/colors_sizes_notifier.dart';
import 'package:app_1/src/products/controllers/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductSizesWidget extends StatelessWidget {
  const ProductSizesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSizesNotifier>(builder: (context, controller, child) {
      return Wrap(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 12.w,
        runSpacing: 8.h,
        children: List.generate(
            context.read<ProductNotifier>().product!.dimensions.length, (i) {
          String s = context.read<ProductNotifier>().product!.dimensions[i];
          return GestureDetector(
            onTap: () {
              controller.setSizes(s);
            },
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 180.w, // Đặt chiều rộng tối đa cho nút
              ),
              height: 30.h,
              //width: 250.h,
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              decoration: BoxDecoration(
                  color: controller.dimensions == s
                      ? Kolors.kPrimary
                      : Kolors.kGrayLight,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    s,
                    style: appStyle(15, Kolors.kWhite, FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
