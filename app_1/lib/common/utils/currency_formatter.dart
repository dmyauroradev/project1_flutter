import 'package:intl/intl.dart';

String formatCurrency(int price) {
  final formatter = NumberFormat("#,###", "vi_VN");
  return "đ${formatter.format(price)}";
}
