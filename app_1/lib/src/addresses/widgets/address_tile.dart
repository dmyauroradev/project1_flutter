import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/change_address_modal.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/const/constants.dart';
import 'package:app_1/src/addresses/controllers/address_notifier.dart';
import 'package:app_1/src/addresses/models/addresses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class AddressTile extends StatelessWidget {
  const AddressTile(
      {super.key,
      required this.address,
      required this.isCheckout,
      this.setDefault,
      this.onDelete});

  final AddressModel address;
  final bool isCheckout;
  final void Function()? setDefault;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressNotifier>(
        builder: (context, addressNotifier, child) {
      return ListTile(
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
            text: addressNotifier.address == null
                ? address.addressType
                : addressNotifier.address!.addressType.toUpperCase(),
            style: appStyle(12, Kolors.kDart, FontWeight.w400)),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableText(
                text: addressNotifier.address == null
                    ? address.address
                    : addressNotifier.address!.address,
                style: appStyle(11, Kolors.kGray, FontWeight.w400)),
            ReusableText(
                text: addressNotifier.address == null
                    ? address.phone
                    : addressNotifier.address!.phone,
                style: appStyle(11, Kolors.kGray, FontWeight.w400)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                if (isCheckout == true) {
                  changeAddressBottomSheet(context);
                } else {
                  address.isDefault ? () {} : setDefault!();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  borderRadius: kRadiusAll,
                  color: isCheckout
                      ? Kolors.kPrimary
                      : addressNotifier.address == null
                          ? address.isDefault == true
                              ? Colors.green
                              : Kolors.kGrayLight
                          : addressNotifier.address!.isDefault != true
                              ? Colors.green
                              : Kolors.kGrayLight,
                ),
                child: ReusableText(
                    text: isCheckout == true
                        ? 'Thay đổi'
                        : addressNotifier.address == null
                            ? address.isDefault == true
                                ? 'Mặc định'
                                : 'Đặt mặc định'
                            : addressNotifier.address!.isDefault == true
                                ? 'Mặc định'
                                : 'Đặt mặc định',
                    style: appStyle(12, Kolors.kWhite, FontWeight.w400)),
              ),
            ),
            isCheckout == true || address.isDefault
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                          color: Kolors.kRed, borderRadius: kRadiusAll),
                      child: ReusableText(
                          text: 'Xoá',
                          style: appStyle(12, Kolors.kWhite, FontWeight.w400)),
                    ),
                  )
          ],
        ),
      );
    });
  }
}
