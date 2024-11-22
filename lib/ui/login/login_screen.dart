import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichatapp/provider/auth_provider.dart';
import 'package:minichatapp/utils/asset_image_loader.dart';
import 'package:minichatapp/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../utils/strings.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIconBack(),
          _buildRowTitleContentAndImage(),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                _buildTextFormFieldEmail(),
                _buildTextFormFieldPassWord(),
              ],
            ),
          ),
          _buildTextForgotPassWord(),
          30.verticalSpace,
          _buildButtonLogin(authProvider, context),
          10.verticalSpace,
          _buildTextAndRegisterNow(),
          58.verticalSpace,
          _buildTextAndDivider(),
          38.verticalSpace,
          _buildRowPlatform(),
        ],
      ),
    ));
  }

  Widget _buildIconBack() {
    return Container(
      margin: const EdgeInsets.only(top: 31, left: 27).r,
      width: 37.w,
      height: 37.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: Colors.black, width: 2.w), // Border for the circle
      ),
      child: Center(
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 28.sp,
        ),
      ),
    );
  }

  Widget _buildRowTitleContentAndImage() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 22).r,
              child: Text(
                AppStrings.textTitleHello,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 22).r,
              child: Text(AppStrings.textContentHello,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start),
            ),
          ],
        ),
        Flexible(
            child: AssetImageLoader.loadAssetImage("dayflow_sitting",
                width: 188, height: 229, fit: BoxFit.fill))
      ],
    );
  }

  Widget _buildTextFormFieldEmail() {
    return CustomTextFormField(
      textTitle: "Email Address",
      controller: _emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email không được để trống';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Email không hợp lệ';
        }
        return null;
      },
    );
  }

  Widget _buildTextFormFieldPassWord() {
    return CustomTextFormField(
      textTitle: "Password",
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password không được để trống';
        }
        return null;
      },
    );
  }

  Widget _buildTextForgotPassWord() {
    return Container(
        width:
            double.infinity, // Make the container fill the width of the screen
        alignment: Alignment.centerRight, // Align text to the right
        padding: const EdgeInsets.only(right: 29.0, top: 13)
            .w, // Add padding from the right
        child: Text(AppStrings.textForgotPassword,
            style: GoogleFonts.poppins(
                color: AppColors.colorTextForgotPassword,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.start));
  }

  Widget _buildButtonLogin(AuthProvider authProvider, BuildContext context) {
    return CustomElevatedButton(
      onPressed: () => _onHandleLogin(authProvider, context),
      text: AppStrings.textButtonLogin,
      backgroundColor: AppColors.colorButton,
      borderRadius: BorderRadius.circular(15).r,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      minimumSizeHeight: 46,
      minimumSizeWith: 334,
      textColor: AppColors.textButton,
    );
  }

  Widget _buildTextAndRegisterNow() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "New To [App Name]? ",
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400),
          children: <TextSpan>[
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/register');
                },
              text: "Register Now",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextAndDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            indent: 45.0,
            endIndent: 11.0,
            thickness: 1,
            color: AppColors.colorDivider,
          ),
        ),
        Text(AppStrings.textLoginWith,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.start),
        const Expanded(
          child: Divider(
            indent: 11.0,
            endIndent: 45.0,
            thickness: 1,
            color: AppColors.colorDivider,
          ),
        ),
      ],
    );
  }

  Widget _buildRowPlatform() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 121).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AssetImageLoader.loadAssetImage("google",
              width: 25, height: 25, fit: BoxFit.fill),
          AssetImageLoader.loadAssetImage("apple-logo",
              width: 25, height: 25, fit: BoxFit.fill),
          AssetImageLoader.loadAssetImage("facebook",
              width: 25, height: 25, fit: BoxFit.fill)
        ],
      ),
    );
  }

  /*
  check form is valid or not
  */
  void _onHandleLogin(AuthProvider authProvider, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await authProvider.login(_emailController.text, _passwordController.text);
      Navigator.pushNamed(context, '/home');
    } else {}
  }
}
