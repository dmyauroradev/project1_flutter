import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckoutSummary extends StatelessWidget {
  final int subtotal;
  final int fees;
  final int discount;
  final int total;

  const CheckoutSummary({
    Key? key,
    required this.subtotal,
    required this.fees,
    required this.discount,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '',
      decimalDigits: 0,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ReusableText(
              text: 'Thông tin hóa đơn',
              style: appStyle(13, Kolors.kPrimary, FontWeight.w500)),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow('Tổng tạm tính', formatCurrency.format(subtotal)),
              _buildRow('Phí vận chuyển', formatCurrency.format(fees)),
              _buildRow('Ưu đãi đã chọn', formatCurrency.format(-discount)),
              Divider(thickness: 1, color: Colors.grey.shade300),
              _buildRow('Tổng cộng', formatCurrency.format(total),
                  isBold: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String label, String formattedAmount,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: appStyle(13, Kolors.kDart, FontWeight.w500),
          ),
          Text(
            '$formattedAmount VNĐ',
            style: appStyle(13, Kolors.kPrimary, FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
