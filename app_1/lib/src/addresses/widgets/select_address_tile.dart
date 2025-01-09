import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/src/addresses/controllers/address_notifier.dart';
import 'package:app_1/src/addresses/models/addresses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SelectAddressTile extends StatelessWidget {
  const SelectAddressTile({
    super.key,
    required this.address,
  });

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressNotifier>(
        builder: (context, addressNotifier, child) {
      return ListTile(
          onTap: () {
            addressNotifier.setAddress(address);
            context.pop();
          },
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(
            radius: 24,
            backgroundColor: Kolors.kSecondaryLight,
            child: Icon(
              MaterialIcons.location_pin,
              color: Kolors.kPrimary,
              size: 30,
            ),
          ),
          title: ReusableText(
              text: address.addressType.toUpperCase(),
              style: appStyle(12, Kolors.kDart, FontWeight.w400)),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                  text: address.address,
                  style: appStyle(11, Kolors.kGray, FontWeight.w400)),
              ReusableText(
                  text: address.phone,
                  style: appStyle(11, Kolors.kGray, FontWeight.w400)),
            ],
          ),
          trailing: ReusableText(
              text: addressNotifier.address != null &&
                      addressNotifier.address!.id == address.id
                  ? 'Đã chọn'
                  : 'Chọn',
              style: appStyle(12, Kolors.kPrimaryLight, FontWeight.w400)));
    });
  }
}
