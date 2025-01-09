import 'package:app_1/common/utils/kcolors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

LinearGradient kGradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Kolors.kPrimaryLight,
    Kolors.kWhite,
    Kolors.kPrimary,
  ],
);

LinearGradient kPGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Kolors.kPrimaryLight,
    Kolors.kPrimaryLight.withOpacity(0.7),
    Kolors.kPrimary,
  ],
);

LinearGradient kBtnGradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Kolors.kPrimaryLight,
    Kolors.kWhite,
    Kolors.kPrimary,
  ],
);

BorderRadiusGeometry kClippingRadius = const BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

BorderRadiusGeometry kRadiusAll = BorderRadius.circular(12);

BorderRadiusGeometry kRadiusTop = const BorderRadius.only(
  topLeft: Radius.circular(9),
  topRight: Radius.circular(9),
);

BorderRadiusGeometry kRadiusBottom = const BorderRadius.only(
  bottomLeft: Radius.circular(12),
  bottomRight: Radius.circular(12),
);

Widget Function(BuildContext, String)? placeholder =
    (p0, p1) => CachedNetworkImage(
          imageUrl:
              "https://res.cloudinary.com/ddcuxrwap/image/upload/f_auto,w_500/v1728673181/slider_4_vvm3uv.jpg",
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );

Widget Function(BuildContext, String, Object)? errorWidget =
    (p0, p1, p3) => CachedNetworkImage(
          imageUrl:
              "https://res.cloudinary.com/ddcuxrwap/image/upload/f_auto,w_500/v1728673181/slider_4_vvm3uv.jpg",
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );

List<String> images = [
  "https://res.cloudinary.com/ddcuxrwap/image/upload/f_auto,w_500/v1728673181/slider_4_vvm3uv.jpg"
];
