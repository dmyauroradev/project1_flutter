import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/custom_button.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Kolors.kWhite,
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          // Thêm SizedBox để giới hạn kích thước ảnh
          SizedBox(
            width: 500.w, // Điều chỉnh chiều rộng theo ý muốn
            height: 320.h, // Điều chỉnh chiều cao theo ý muốn
            child: CachedNetworkImage(
              imageUrl:
                  'https://res.cloudinary.com/ddcuxrwap/image/upload/v1730809651/141454-777657300_tiny_p7ouq0.jpg',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover, // Đảm bảo ảnh vừa vặn trong khung
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            AppText.kWelcomeHeader,
            textAlign: TextAlign.center,
            style: appStyle(
                24, const Color.fromARGB(255, 124, 46, 4), FontWeight.bold),
          ),
          SizedBox(
            height: 18.h,
          ),
          SizedBox(
            width: ScreenUtil().screenWidth - 100,
            child: Text(
              AppText.kWelcomeMessage,
              textAlign: TextAlign.center,
              style: appStyle(16, const Color.fromARGB(255, 196, 171, 107),
                  FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomButton(
            /*GradientBtn*/
            text: AppText.kGetStarted,
            btnHieght: 40,
            radius: 20,
            btnWidth: ScreenUtil().screenWidth - 100,
            onTap: () {
              //Storage().setBool('firstOpen', true);

              context.go("/home");
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReusableText(
                  text: "Đã có tài khoản?",
                  style: appStyle(12, Kolors.kDart, FontWeight.normal)),
              TextButton(
                  onPressed: () {
                    //navigate to login page '/login'
                    context.go("/login");
                  },
                  child: const Text(
                    "Đăng nhập",
                    style: TextStyle(
                        fontSize: 12, color: Color.fromARGB(255, 34, 76, 214)),
                  ))
            ],
          )
        ],
      ),
    ));
  }
}
