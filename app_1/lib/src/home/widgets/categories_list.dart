import 'dart:convert';

import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/common/widgets/shimmers/categories_shimmer.dart';
import 'package:app_1/src/categories/controllers/category_notifier.dart';
import 'package:app_1/src/categories/hook/fetch_home_categories.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeCategoriesList extends HookWidget {
  const HomeCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchHomeCategories();
    final categories = results.categories;
    final isLoading = results.isLoading;
    final error = results.error;

    if (isLoading) {
      return const CategoriesShimmer();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: SizedBox(
          height: 80.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(categories.length, (i) {
              final category = categories[i];
              return GestureDetector(
                onTap: () {
                  context
                      .read<CategoryNotifier>()
                      .setCategory(category.title, category.id);
                  context.push('/category');
                },
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: category.imageUrl,
                          width: 40.w,
                          height: 40.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      ReusableText(
                          text: utf8.decode(category.title.runes.toList()),
                          style: appStyle(12, Kolors.kGray, FontWeight.normal))
                    ],
                  ),
                ),
              );
            }),
          )),
    );
  }
}
