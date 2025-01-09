import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/utils/kstrings.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/back_button.dart';
import 'package:app_1/common/widgets/custom_button.dart';
import 'package:app_1/common/widgets/error_modal.dart';
import 'package:app_1/common/widgets/reusable_text.dart';
import 'package:app_1/const/constants.dart';
import 'package:app_1/src/addresses/controllers/address_notifier.dart';
import 'package:app_1/src/addresses/models/create_address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
            text: AppText.kAddShipping,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: Consumer<AddressNotifier>(
        builder: (context, addressNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            children: [
              SizedBox(
                height: 20.h,
              ),
              _buildtextfield(
                  hintText: 'Số điện thoại',
                  keyboard: TextInputType.phone,
                  controller: _phoneController,
                  onSubmitted: (p) {}),
              SizedBox(
                height: 20.h,
              ),
              _buildtextfield(
                  hintText: 'Địa chỉ',
                  keyboard: TextInputType.text,
                  controller: _addressController,
                  onSubmitted: (p) {}),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                      List.generate(addressNotifier.addressTypes.length, (i) {
                    final adddressType = addressNotifier.addressTypes[i];
                    return GestureDetector(
                      onTap: () {
                        addressNotifier.setAddressType(adddressType);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20.w),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                            color: addressNotifier.addressType == adddressType
                                ? Kolors.kPrimaryLight
                                : Kolors.kWhite,
                            borderRadius: kRadiusAll,
                            border:
                                Border.all(color: Kolors.kPrimary, width: 1)),
                        child: ReusableText(
                            text: adddressType,
                            style: appStyle(
                                12,
                                addressNotifier.addressType == adddressType
                                    ? Kolors.kWhite
                                    : Kolors.kPrimary,
                                FontWeight.normal)),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: 'Đặt địa chỉ này làm mặc định',
                        style:
                            appStyle(14, Kolors.kPrimary, FontWeight.normal)),
                    CupertinoSwitch(
                        value: addressNotifier.defaultToggle,
                        thumbColor: Kolors.kSecondaryLight,
                        activeColor: Kolors.kPrimary,
                        onChanged: (d) {
                          addressNotifier.setDefaultToggle(d);
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                btnHieght: 35.h,
                radius: 9,
                text: "L Ư U",
                onTap: () {
                  if (_addressController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      addressNotifier.addressType != '') {
                    //add address
                    CreateAddress address = CreateAddress(
                        lat: 0.0,
                        lng: 0.0,
                        isDefault: addressNotifier.defaultToggle,
                        address: _addressController.text,
                        phone: _phoneController.text,
                        addressType: addressNotifier.addressType);

                    String data = createAddressToJson(address);

                    addressNotifier.addAddress(data, context);
                  } else {
                    showErrorPopup(
                        context,
                        "Cần nhập đầy đủ địa chỉ và số điện thoại",
                        'Lỗi thêm địa chỉ',
                        false);
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }
}

class _buildtextfield extends StatelessWidget {
  const _buildtextfield({
    Key? key,
    this.keyboard,
    required this.hintText,
    required this.controller,
    required this.onSubmitted,
    this.readOnly,
  }) : super(key: key);
  final String? hintText;
  final TextInputType? keyboard;
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: TextField(
        keyboardType: keyboard,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
            hintText: hintText,
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Kolors.kRed, width: 0.5),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Kolors.kPrimary, width: 0.5),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.5),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
            ),
            border: InputBorder.none),
        controller: controller,
        cursorHeight: 25,
        style: appStyle(12, Colors.black, FontWeight.normal),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
