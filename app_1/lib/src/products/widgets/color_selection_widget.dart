import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/const/constants.dart';
import 'package:app_1/src/products/controllers/colors_sizes_notifier.dart';
import 'package:app_1/src/products/controllers/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ColorSelectionWidget extends StatelessWidget {
  const ColorSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSizesNotifier>(builder: (context, controller, child) {
      return Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
            context.read<ProductNotifier>().product!.code.length, (i) {
          String c = context.read<ProductNotifier>().product!.code[i];
          return GestureDetector(
              onTap: () {
                controller.setColor(c);
              },
              child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 140.w,
                  ),
                  height: 25.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 13.w,
                  ),
                  margin: EdgeInsets.only(right: 20.w),
                  decoration: BoxDecoration(
                      borderRadius: kRadiusAll,
                      color: c == controller.code
                          ? Kolors.kPrimary
                          : Kolors.kGrayLight),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: ReusableText(
                          text: c,
                          style: appStyle(13, Kolors.kWhite, FontWeight.w600)),
                    ),
                  )));
        }),
      );
    });
  }
}
