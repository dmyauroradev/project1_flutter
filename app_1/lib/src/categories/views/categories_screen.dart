import 'dart:convert';

import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/back_button.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/common/widgets/shimmers/list_shimmer.dart';
import 'package:app_1/src/categories/controllers/category_notifier.dart';
import 'package:app_1/src/categories/hook/fetch_categories.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends HookWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchCategories();
    final categories = results.categories;
    final isLoading = results.isLoading;
    final error = results.error;

    /*for (var category in categories) {
      //print('Title: ${category.title}, Image URL: ${category.imageUrl}');
    }*/

    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
          text: AppText.kCategories,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final category = categories[i];
          return ListTile(
            onTap: () {
              context
                  .read<CategoryNotifier>()
                  .setCategory(category.title, category.id);
              context.push('/category');
            },
            leading: ClipOval(
              child: CachedNetworkImage(
                imageUrl: category.imageUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            title: ReusableText(
                text: utf8.decode(category.title.runes.toList()),
                style: appStyle(12, Kolors.kGray, FontWeight.normal)),
            trailing: const Icon(
              MaterialCommunityIcons.chevron_double_right,
              size: 18,
            ),
          );
        },
      ),
    );
  }
}
