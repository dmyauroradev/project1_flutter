import 'package:app_1/src/cart/views/cart_screen.dart';
import 'package:app_1/src/orders/models/orders_model.dart';
import 'package:app_1/src/orders/views/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:intl/intl.dart';

class OrdersTile extends StatelessWidget {
  final OrdersModel order;
  final String buttonType;
  final Function() markAsReviewed;
  final bool isReviewed;

  const OrdersTile(
      {Key? key,
      required this.order,
      required this.buttonType,
      required this.markAsReviewed,
      required this.isReviewed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tính tổng giá trị ban đầu của toàn bộ sản phẩm
    final totalOriginalPrice = order.orderProducts.fold<int>(
      0,
      (sum, product) => sum + (product.price * product.quantity),
    );

    // Tính giá trị sau khi áp dụng ưu đãi (nếu có)
    final totalAfterDiscount = order.total; // Giá trị sau ưu đãi từ backend

    final formatCurrency = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '',
      decimalDigits: 0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Lặp qua tất cả sản phẩm trong đơn hàng
        ...order.orderProducts.map((product) {
          final productOriginalPrice = product.price * product.quantity;
          final adjustedPrice =
              (productOriginalPrice / totalOriginalPrice) * totalAfterDiscount;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị hình ảnh sản phẩm
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Kolors.kWhite,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    //imageUrl: order.orderProducts[0].imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(width: 10.w),

              // Hiển thị thông tin sản phẩm
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableText(
                      text: product.title,
                      //text: order.orderProducts[0].title,
                      style: appStyle(14, Kolors.kDart, FontWeight.bold),
                    ),
                    SizedBox(height: 4.h),
                    ReusableText(
                      text:
                          'Kích thước: ${product.dimensions} | Mã màu: ${product.code}',
                      //text:'Kích thước: ${order.orderProducts[0].dimensions} | Mã màu: ${order.orderProducts[0].code}',
                      style: appStyle(12, Kolors.kGray, FontWeight.normal),
                    ),
                    SizedBox(height: 4.h),
                    ReusableText(
                      text: 'Số lượng: ${product.quantity}',
                      //text: 'Số lượng: ${order.totalQuantity}',
                      style: appStyle(13, Kolors.kGray, FontWeight.normal),
                    ),
                    SizedBox(height: 8.h),
                    ElevatedButton(
                      onPressed: isReviewed
                          ? null
                          : () {
                              if (buttonType == "review") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewPage(
                                      order: order,
                                      onReviewSubmitted: markAsReviewed,
                                    ),
                                  ),
                                );
                              } else if (buttonType == "reorder") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartPage(),
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Kolors.kPrimary,
                          disabledBackgroundColor: Kolors.kPrimaryLight),
                      child: ReusableText(
                        text: isReviewed
                            ? "Reviewed"
                            : (buttonType == "review" ? "Review" : "Mua lại"),
                        style: appStyle(12, Kolors.kWhite, FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),

              // Hiển thị giá sản phẩm
              Padding(
                padding: EdgeInsets.only(right: 8.w, top: 60.h),
                child: ReusableText(
                  //text: '${adjustedPrice.toStringAsFixed(0)} VNĐ',
                  text: '${formatCurrency.format(adjustedPrice)} VNĐ',
                  style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
