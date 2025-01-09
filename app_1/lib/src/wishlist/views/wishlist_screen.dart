import 'package:app_1/common/services/storage.dart';
import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/src/auth/views/login_screen.dart';
import 'package:app_1/src/wishlist/widgets/wishlist.dart';
import 'package:flutter/material.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null) {
      return const LoginPage();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableText(
            text: AppText.kWishlist,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: WishListWidget(),
      ),
    );
  }
}
