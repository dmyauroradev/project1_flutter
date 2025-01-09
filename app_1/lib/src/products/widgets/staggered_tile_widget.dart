import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/src/products/models/products_model.dart';
import 'package:app_1/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/product_notifier.dart';

class StaggeredTileWidget extends StatelessWidget {
  const StaggeredTileWidget({
    super.key,
    required this.i,
    required this.product,
    this.onTap,
  });

  final int i;
  final Products product;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    //String? accessToken = Storage().getString('accessToken');
    return GestureDetector(
      onTap: () {
        context.read<ProductNotifier>().setProuct(product);
        context.push('/product/${product.id}');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: Kolors.kOffWhite,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Kolors.kPrimary,
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: product.imageUrls[0],
                        //width: double.infinity,
                        //width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.width * 0.6,
                      ),
                    ),
                    /*imageUrl: product.imageUrls.isNotEmpty
                            ? product.imageUrls[0]
                            : 'https://via.placeholder.com/150', // URL hình ảnh thay thế nếu không có hình ảnh
                        placeholder: (context, url) => const Center(
                            child:
                                CircularProgressIndicator()), // Hiển thị khi đang tải
                        errorWidget: (context, url, error) => const Icon(
                            Icons.error), // Hiển thị nếu tải ảnh thất bại
                        cacheKey: product.imageUrls[
                            0], // Sử dụng cacheKey để đảm bảo caching hiệu quả
                        fadeInDuration: const Duration(
                            milliseconds: 500), // Tạo hiệu ứng fade-in
                        width: double.infinity,
                      ),
                    ),*/
                    Positioned(
                        right: 10.h,
                        top: 10.h,
                        child: Consumer<WishlistNotifier>(
                          builder: (context, wishlistNotifier, child) {
                            return GestureDetector(
                              onTap: onTap,
                              child: CircleAvatar(
                                backgroundColor: Kolors.kSecondaryLight,
                                child: Icon(
                                  AntDesign.heart,
                                  color: wishlistNotifier.wishlist
                                          .contains(product.id)
                                      ? Kolors.kRed
                                      : Kolors.kGrayLight,
                                  size: 18,
                                ),
                              ),
                            );
                          },
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(15, Kolors.kDart, FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: Colors.yellow,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            AntDesign.star,
                            color: Colors.orange,
                            size: 13,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          ReusableText(
                            text: product.ratings.toStringAsFixed(1),
                            style:
                                appStyle(13, Kolors.kDart, FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'đ',
                        style: TextStyle(
                          decoration:
                              TextDecoration.underline, // Thêm dấu gạch dưới
                          decorationThickness:
                              3, // Điều chỉnh độ dày của gạch dưới
                          decorationColor: Kolors.kRed,
                          color: Kolors.kRed,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          height: 2.5,
                        ),
                      ),
                      TextSpan(
                        text: NumberFormat("#,###", "vi_VN")
                            .format(product.price),
                        style: const TextStyle(
                          color: Kolors.kRed,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
