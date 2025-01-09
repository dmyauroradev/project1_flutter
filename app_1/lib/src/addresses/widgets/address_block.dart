import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/src/addresses/models/addresses_model.dart';
import 'package:app_1/src/addresses/widgets/address_tile.dart';
import 'package:flutter/material.dart';

class AddressBlock extends StatelessWidget {
  const AddressBlock({super.key, this.address});

  final AddressModel? address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(
            text: 'Địa chỉ nhận hàng',
            style: appStyle(13, Kolors.kPrimary, FontWeight.w500)),
        AddressTile(
          address: address!,
          isCheckout: true,
        )
      ],
    );
  }
}
