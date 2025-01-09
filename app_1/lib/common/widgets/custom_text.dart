import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.keyboardType,
    this.onEditingComplete,
    this.controller,
    this.hintText,
    this.focusNode,
    this.initialValue,
    this.maxLines,
    this.radius,
  });
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final int? maxLines;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      maxLines: maxLines ?? 1,
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType,
      initialValue: initialValue,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a valid value";
        } else {
          return null;
        }
      },
      style: appStyle(12, Kolors.kDart, FontWeight.normal),
      decoration: InputDecoration(
        hintText: 'Username',
        prefixIcon: const Icon(
          CupertinoIcons.profile_circled,
          size: 26,
          color: Kolors.kGrayLight,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(6),
        hintStyle: appStyle(12, Kolors.kGray, FontWeight.normal),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12))),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Kolors.kPrimary, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12))),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Kolors.kGray, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12))),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Kolors.kGray, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12))),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Kolors.kPrimary, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 12))),
      ),
    );
  }
}
