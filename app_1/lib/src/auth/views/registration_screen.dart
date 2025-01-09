import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/back_button.dart';
import 'package:app_1/common/widgets/custom_button.dart';
import 'package:app_1/common/widgets/custom_text.dart';
import 'package:app_1/common/widgets/email_textfield.dart';
import 'package:app_1/common/widgets/password_field.dart';
import 'package:app_1/src/auth/controllers/auth_notifier.dart';
import 'package:app_1/src/auth/models/registration_model.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  final FocusNode _passwordNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kolors.kWhite,
      appBar: AppBar(
        backgroundColor: Kolors.kWhite,
        elevation: 0,
        leading: const AppBackButton(),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 160.h,
          ),
          Text(
            "Luxos Decoration",
            textAlign: TextAlign.center,
            style: appStyle(24, Kolors.kPrimary, FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Hi! Chào mừng bạn đến với Luxos",
            textAlign: TextAlign.center,
            style: appStyle(13, Kolors.kGray, FontWeight.normal),
          ),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                CustomTextField(
                  //hintText: "Username",
                  controller: _usernameController,
                  focusNode: _passwordNode,
                  radius: 25,
                  /*prefixIcon: const Icon(
                    CupertinoIcons.profile_circled,
                    size: 26,
                    color: Kolors.kGray,
                  ),*/
                  keyboardType: TextInputType.name,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                EmailTextField(
                  focusNode: _passwordNode,
                  hintText: "Email",
                  controller: _emailController,
                  radius: 25,
                  prefixIcon: const Icon(
                    CupertinoIcons.mail,
                    size: 26,
                    color: Kolors.kGrayLight,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                PasswordField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  radius: 25,
                ),
                SizedBox(
                  height: 20.h,
                ),
                context.watch<AuthNotifier>().isRLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Kolors.kPrimary,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Kolors.kWhite),
                        ),
                      )
                    : CustomButton(
                        onTap: () {
                          RegistrationModel model = RegistrationModel(
                              password: _passwordController.text,
                              username: _usernameController.text,
                              email: _emailController.text);

                          String data = registrationModelToJson(model);

                          print(data);

                          context
                              .read<AuthNotifier>()
                              .registrationFunc(data, context);
                        },
                        text: "ĐĂNG KÝ",
                        btnWidth: ScreenUtil().screenWidth,
                        btnHieght: 40,
                        radius: 20,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
