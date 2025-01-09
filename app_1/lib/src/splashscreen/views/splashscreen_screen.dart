import 'package:app_1/common/services/storage.dart';
import 'package:app_1/common/utils/kcolors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigator();
    super.initState();
  }

  _navigator() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      if (Storage().getBool('firstOpen') == null) {
        //Go to the onboarding screen
        GoRouter.of(context).go('/onboarding');
      } else {
        //Go to home page
        GoRouter.of(context).go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kolors.kWhite,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: CachedNetworkImageProvider(
            'https://res.cloudinary.com/ddcuxrwap/image/upload/v1730813871/hinh-nen-3d-full-hd-cho-dien-thoai-14_trfvly.jpg',
          ),
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
