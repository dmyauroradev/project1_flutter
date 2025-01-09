import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class PaymentMethodPage extends StatefulWidget {
  final String? initialSelectedMethod;

  const PaymentMethodPage({super.key, this.initialSelectedMethod});

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  late String? selectedMethod;

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.initialSelectedMethod;
  }

  void selectPaymentMethod(String method) {
    setState(() {
      selectedMethod = method;
    });
    Navigator.pop(
        context, method); // Quay lại với lựa chọn phương thức thanh toán
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: AppText.kPayment,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(
            AntDesign.leftcircle,
            color: Kolors.kPrimary, // Màu mũi tên trắng
          ),
          onPressed: () {
            Navigator.pop(context, selectedMethod);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          ListTile(
            leading: Image.asset(
              'assets/images/zalopay.png',
              width: 30,
              height: 30,
            ),
            title: const Text(
              'ZaloPay',
              style: TextStyle(
                fontSize: 15,
                color: Kolors.kDart,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: selectedMethod == 'ZaloPay'
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
            onTap: () => selectPaymentMethod('ZaloPay'),
          ),
          ListTile(
            leading:
                const Icon(Icons.attach_money, color: Colors.black, size: 30),
            title: const Text(
              'Tiền mặt',
              style: TextStyle(
                fontSize: 15,
                color: Kolors.kDart,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: selectedMethod == 'Tiền mặt'
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
            onTap: () => selectPaymentMethod('Tiền mặt'),
          ),
        ],
      ),
    );
  }
}
