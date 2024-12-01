import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichatapp/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../main.dart';
import '../../utils/utilities.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
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
            child: Column(
              children: [
                _buildTextFormFieldName(),
                26.verticalSpace,
                _buildTextFormFieldEmail(),
                26.verticalSpace,
                _buildTextFormFieldPassWord(),
              ],
            ),
          ),
          50.verticalSpace,
          _buildButtonRegister(authProvider, context),
          68.verticalSpace,
        ],
      ),
    ));
  }

  Widget _buildIconBack() {
    return GestureDetector(
      onTap: _onHandleBackToLogin,
      child: Container(
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
              child: Text(AppStrings.textContentHelloRegister,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start),
            ),
          ],
        ),
        Flexible(
            child: Utilities.loadAssetImage("dayflow_sitting",
                width: 188, height: 229, fit: BoxFit.fill))
      ],
    );
  }

  Widget _buildTextFormFieldName() {
    return CustomTextFormField(
      textTitle: "Name",
      controller: _nameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name không được để trống';
        }
        return null;
      },
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
      obscureText: true,
    );
  }

  Widget _buildButtonRegister(AuthProvider authProvider, BuildContext context) {
    return CustomElevatedButton(
      onPressed: () => _onHandleRegister(authProvider, context),
      text: AppStrings.textButtonRegister,
      backgroundColor: AppColors.colorButton,
      borderRadius: BorderRadius.circular(15).r,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      minimumSizeHeight: 46,
      minimumSizeWith: 334,
      textColor: AppColors.textButton,
    );
  }

  void _onHandleBackToLogin() {
    navKey.currentState?.pop();
  }

  void _onHandleRegister(
      AuthProvider authProvider, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await authProvider.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
    } else {}
  }
}
