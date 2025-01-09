import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/back_button.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/src/notification/controllers/notification_notifier.dart';
import 'package:app_1/src/notification/views/notifications_shimmer.dart';
import 'package:app_1/src/orders/hooks/fetch_order.dart';
import 'package:app_1/src/orders/widgets/orders_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TrackingPage extends HookWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchOrder(context.read<NotificationNotifier>().orderId);

    final isLoading = results.isLoading;
    final order = results.order;

    if (isLoading) {
      return const NotificationShimmer();
    }
    final formatCurrency = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '',
      decimalDigits: 0,
    );

    return Scaffold(
        backgroundColor: Kolors.kWhite,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Kolors.kWhite,
          leading: const AppBackButton(),
          title: ReusableText(
              text: AppText.kTrack,
              style: appStyle(16, Kolors.kPrimary, FontWeight.w600)),
        ),
        body: Container(
          color: Kolors.kWhite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: ListView(
              children: [
                OrdersTile(
                  order: order!,
                  buttonType: "review",
                  markAsReviewed: () {},
                  isReviewed: false,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Divider(
                  thickness: 0.5.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ReusableText(
                    text: "Chi tiết đặt hàng",
                    style: appStyle(14, Kolors.kDart, FontWeight.w600)),
                SizedBox(
                  height: 20.h,
                ),
                Table(
                  border: TableBorder.all(
                    color: Kolors.kGrayLight,
                    style: BorderStyle.solid,
                    width: 0.5,
                  ),
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            "Đơn vị vận chuyển",
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            "Giao Hàng Tiết Kiệm (GHTK)",
                            style:
                                appStyle(12, Kolors.kDart, FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            "Mã theo dõi",
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            order.id.toString(),
                            style:
                                appStyle(12, Kolors.kDart, FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            "Trạng thái thanh toán",
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            order.paymentStatus.toUpperCase(),
                            style:
                                appStyle(12, Kolors.kDart, FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            "Tổng tiền",
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            '${formatCurrency.format(order.total)} VNĐ',
                            style:
                                appStyle(12, Kolors.kDart, FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            "Trạng thái giao hàng",
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            order.deliveryStatus.toUpperCase(),
                            style:
                                appStyle(12, Kolors.kDart, FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            "Ngày giao hàng dự kiến",
                            style:
                                appStyle(12, Kolors.kGray, FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            order.createdAt
                                .add(const Duration(days: 3))
                                .toString()
                                .substring(0, 10),
                            style:
                                appStyle(12, Kolors.kDart, FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
