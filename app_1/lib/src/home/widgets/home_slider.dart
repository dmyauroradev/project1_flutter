import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/custom_button.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/const/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kRadiusAll,
      child: Stack(
        children: [
          SizedBox(
            //height: ScreenUtil().screenHeight * 0.16,
            //width: ScreenUtil().scaleWidth,
            height: 200,
            width: double.infinity,
            child: ImageSlideshow(
              indicatorColor: Kolors.kPrimaryLight,
              onPageChanged: (p) {
                //debugPrint("Slider page changed: $p");
              },
              autoPlayInterval: 5000,
              isLoop: true,
              children: images.map((imageUrl) {
                return CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              }).toList(),
            ),
          ),
          Positioned(
            //child: SizedBox(
            //height: ScreenUtil().screenHeight * 0.16,
            //width: ScreenUtil().scaleWidth,
            left: 20,
            bottom: 30,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: AppText.kCollection,
                    style: appStyle(20, Kolors.kWhite, FontWeight.w600),
                  ),
                  SizedBox(height: 5.h //ScreenUtil().setHeight(5),
                      ),
                  Text(
                    'Chào mừng bạn! \nĐến với Luxos',
                    style: appStyle(14, Kolors.kOffWhite.withOpacity(.6),
                        FontWeight.normal),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                    text: "Shop Now",
                    btnWidth: 150.w,
                  )
                ],
              ),
            ),
            //),
          )
        ],
      ),
    );
  }
}

List<String> images = [
  "https://res.cloudinary.com/ddcuxrwap/image/upload/v1728673181/slider_4_vvm3uv.jpg"
];
