import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/common/widgets/shimmers/list_shimmer.dart';
import 'package:flutter/material.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableText(
            text: AppText.kNotifications,
            style: appStyle(16, Kolors.kPrimary, FontWeight.w600)),
      ),
      body: Container(
        color: Kolors.kWhite,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ListShimmer(),
        ),
      ),
    );
  }
}
