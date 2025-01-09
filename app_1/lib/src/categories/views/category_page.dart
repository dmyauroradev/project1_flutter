import 'dart:convert';

import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/back_button.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/src/categories/controllers/category_notifier.dart';
import 'package:app_1/src/categories/widgets/products_by_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Consumer<CategoryNotifier>(
          builder: (context, categoryNotifier, child) {
            return ReusableText(
              text: utf8.decode(categoryNotifier.category.runes.toList()),
              style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
            );
          },
        ),
      ),
      body: const ProductsByCategory(),
    );
  }
}
