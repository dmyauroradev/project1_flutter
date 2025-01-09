import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/src/orders/models/orders_model.dart';
import 'package:app_1/src/orders/widgets/orders_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ReviewPage extends StatefulWidget {
  final OrdersModel order;
  final VoidCallback onReviewSubmitted;

  const ReviewPage(
      {Key? key, required this.order, required this.onReviewSubmitted})
      : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  void _submitReview() {
    setState(() {
      widget.order.rated.add(widget.order.id);
    });
    widget.onReviewSubmitted();
    Navigator.pop(context);
  }

  void _navigateToTrackingPage() {
    Navigator.pop(context); // Dùng pop để tránh thêm page vào stack
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kolors.kWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Kolors.kWhite,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: _navigateToTrackingPage,
            child: const Icon(
              AntDesign.leftcircle,
              color: Kolors.kPrimary, // Màu mũi tên trắng
            ),
            //),
          ),
        ),
        title: ReusableText(
          text: "Thêm Đánh Giá",
          style: appStyle(16, Kolors.kPrimary, FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order details
            OrdersTile(
              order: widget.order,
              buttonType: "reorder",
              markAsReviewed: () {},
              isReviewed: false,
            ),

            SizedBox(height: 20.h),
            const Divider(thickness: 1, color: Kolors.kGrayLight),
            SizedBox(height: 20.h),

            // Review prompt and stars
            Center(
              child: Column(
                children: [
                  ReusableText(
                    text: "Đơn hàng của bạn thế nào?",
                    style: appStyle(14, Kolors.kDart, FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Nhấn để nhập trải nghiệm tổng thể của bạn",
                    style: appStyle(12, Kolors.kGray, FontWeight.normal),
                  ),
                  SizedBox(height: 16.h),

                  // Star rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color: index < _rating ? Colors.orange : Colors.grey,
                          size: 32.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Add review text area
            ReusableText(
              text: "Thêm đánh giá",
              style: appStyle(14, Kolors.kDart, FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Viết nhận xét của bạn ở đây...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Kolors.kGrayLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Kolors.kPrimary),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Cancel and Submit buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _navigateToTrackingPage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Kolors.kOffWhite,
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                  ),
                  child: ReusableText(
                    text: "Hủy",
                    style: appStyle(14, Kolors.kRed, FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Kolors.kOffWhite,
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                  ),
                  child: ReusableText(
                    text: "Gửi",
                    style: appStyle(14, Kolors.kPrimary, FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
