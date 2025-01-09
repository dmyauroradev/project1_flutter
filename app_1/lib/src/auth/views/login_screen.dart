import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:app_1/common/widgets/back_button.dart';
import 'package:app_1/common/widgets/custom_button.dart';
import 'package:app_1/common/widgets/custom_text.dart';
import 'package:app_1/common/widgets/password_field.dart';
import 'package:app_1/src/auth/controllers/auth_notifier.dart';
import 'package:app_1/src/auth/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _usernameController =
      TextEditingController();
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
        leading: AppBackButton(
          onTap: () {
            context.go('/home');
          },
        ),
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
            "Hi! Chào mừng bạn đã quay trở lại với Luxos",
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
                  controller: _usernameController,
                  focusNode: _passwordNode,
                  //hintText: "Username",
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
                PasswordField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  radius: 25,
                ),
                SizedBox(
                  height: 20.h,
                ),
                context.watch<AuthNotifier>().isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Kolors.kPrimary,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Kolors.kWhite),
                        ),
                      )
                    : CustomButton(
                        onTap: () {
                          LoginModel model = LoginModel(
                              password: _passwordController.text,
                              username: _usernameController.text);

                          String data = loginModelToJson(model);

                          context.read<AuthNotifier>().loginFunc(data, context);
                        },
                        text: "ĐĂNG NHẬP",
                        btnWidth: ScreenUtil().screenWidth,
                        btnHieght: 40,
                        radius: 20,
                      )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 130.h,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 110.0),
            child: GestureDetector(
              onTap: () {
                context.push('/register');
              },
              child: Text(
                'Bạn chưa có tài khoản? Đăng ký một tài khoản mới',
                style: appStyle(12, Colors.blue, FontWeight.normal),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
