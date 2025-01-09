import 'package:app_1/common/services/storage.dart';
import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/back_button.dart';
import 'package:app_1/common/widgets/error_modal.dart';
import 'package:app_1/common/widgets/login_bottom_sheet.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/const/constants.dart';
import 'package:app_1/src/cart/controllers/cart_notifier.dart';
import 'package:app_1/src/cart/models/create_cart_model.dart';
import 'package:app_1/src/products/controllers/colors_sizes_notifier.dart';
import 'package:app_1/src/products/controllers/product_notifier.dart';
import 'package:app_1/src/products/widgets/color_selection_widget.dart';
import 'package:app_1/src/products/widgets/expandable_text.dart';
import 'package:app_1/src/products/widgets/product_bottom_bar.dart';
import 'package:app_1/src/products/widgets/product_sizes_widget.dart';
import 'package:app_1/src/products/widgets/similar_products.dart';
import 'package:app_1/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    print("ProductPage nhận productId: $productId");

    // Thêm kiểm tra xem `productId` có khớp dữ liệu không.
    if (productId.isEmpty || int.tryParse(productId) == null) {
      return const Center(
        child: Text('Không thể tải sản phẩm. Product ID không hợp lệ.'),
      );
    }
    return Consumer<ProductNotifier>(
        builder: (context, productNotifier, child) {
      if (productNotifier.product == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 700.h,
              collapsedHeight: 100.h,
              floating: false,
              pinned: true,
              leading: const AppBackButton(),
              actions: [
                Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Consumer<WishlistNotifier>(
                        builder: (context, wishlistNotifier, child) {
                      return GestureDetector(
                        onTap: () {
                          if (accessToken == null) {
                            loginBottomSheet(context);
                          } else {
                            wishlistNotifier.addRemoveWishlist(
                                productNotifier.product!.id, () {}
                                /*wishlistNotifier.fetchWishlist,*/
                                );
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Kolors.kSecondaryLight,
                          child: Icon(
                            AntDesign.heart,
                            color: wishlistNotifier.wishlist
                                    .contains(productNotifier.product!.id)
                                ? Kolors.kRed
                                : Kolors.kGrayLight,
                            size: 18,
                          ),
                        ),
                      );
                    }))
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: SizedBox(
                  height: 415.h,
                  child: ImageSlideshow(
                    indicatorColor: Kolors.kPrimaryLight,
                    autoPlayInterval: 15000,
                    isLoop: productNotifier.product!.imageUrls.length > 1
                        ? true
                        : false,
                    children: List.generate(
                        productNotifier.product!.imageUrls.length, (i) {
                      return CachedNetworkImage(
                        placeholder: placeholder,
                        errorWidget: errorWidget,
                        height: 415.h,
                        imageUrl: productNotifier.product!.imageUrls[i],
                        fit: BoxFit.cover,
                      );
                    }),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: productNotifier.product!.decorationType
                            .toUpperCase(),
                        style: appStyle(13, Kolors.kGray, FontWeight.w600)),
                    Row(
                      children: [
                        const Icon(
                          AntDesign.star,
                          color: Kolors.kGold,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ReusableText(
                            text: productNotifier.product!.ratings
                                .toStringAsFixed(1),
                            style:
                                appStyle(13, Kolors.kGray, FontWeight.normal)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ReusableText(
                    text: productNotifier.product!.title,
                    style: appStyle(16, Kolors.kDart, FontWeight.w600)),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.h),
                child:
                    ExpandableText(text: productNotifier.product!.description),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Divider(
                  thickness: .5.h,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ReusableText(
                    text: "Kích thước",
                    style: appStyle(14, Kolors.kDart, FontWeight.w600)),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ProductSizesWidget(),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ReusableText(
                    text: "Mã màu",
                    style: appStyle(14, Kolors.kDart, FontWeight.w600)),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ColorSelectionWidget(),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ReusableText(
                    text: "Sản phẩm tương tự",
                    style: appStyle(14, Kolors.kDart, FontWeight.w600)),
              ),
            ),
            const SliverToBoxAdapter(
              child: SimilarProducts(),
            ),
          ],
        ),
        bottomNavigationBar: ProductBottomBar(
          onPressed: () {
            if (accessToken == null) {
              loginBottomSheet(context);
            } else {
              if (context.read<ColorSizesNotifier>().code == '' ||
                  context.read<ColorSizesNotifier>().dimensions == '') {
                showErrorPopup(context, AppText.kCartErrorText,
                    "Lỗi thêm vào giỏ hàng", true);
              } else {
                CreateCartModel data = CreateCartModel(
                    product: context.read<ProductNotifier>().product!.id,
                    quantity: 1,
                    dimensions: context.read<ColorSizesNotifier>().dimensions,
                    code: context.read<ColorSizesNotifier>().code);

                String cartData = createCartModelToJson(data);

                context.read<CartNotifier>().addToCart(cartData, context);
              }
            }
          },
          price: productNotifier.product!.price,
        ),
      );
    });
  }
}
