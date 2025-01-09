import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:flutter/material.dart';

class PromotionTile extends StatelessWidget {
  final String title;
  final String description;
  final Function(bool) onSelected;
  final bool isSelected;

  const PromotionTile({
    super.key,
    required this.title,
    required this.description,
    required this.onSelected,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: appStyle(13, Kolors.kDart, FontWeight.w500),
      ),
      subtitle: Text(
        description,
        style: appStyle(12, Kolors.kGray, FontWeight.w500),
      ),
      trailing: Icon(
        isSelected ? Icons.check_circle : Icons.add_circle_outline,
        color: isSelected ? Colors.green : Colors.grey,
      ),
      onTap: () => onSelected(!isSelected),
    );
  }
}
