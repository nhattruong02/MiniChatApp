import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichatapp/utils/colors.dart';
import 'package:minichatapp/utils/strings.dart';

import '../../main.dart';
import '../../utils/utilities.dart';
import '../../widgets/custom_elevated_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildTitleAndContent(),
          52.verticalSpace,
          _buildImageSplash(),
          80.verticalSpace,
          _buildButtonStart()
        ],
      ),
    ));
  }

  Widget _buildTitleAndContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 45, left: 53).r,
          child: Text(
            AppStrings.textTitle,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 36.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 23, top: 9).r,
          child: Text(AppStrings.textContentSplash,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.start),
        ),
      ],
    );
  }

  Widget _buildImageSplash() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.h),
      child: Utilities.loadAssetImage("splash",
          height: 350.h, width: 350.w, fit: BoxFit.fill),
    );
  }

  Widget _buildButtonStart() {
    return CustomElevatedButton(
      onPressed: () {
        navKey.currentState?.pushNamed('/login');
      },
      text: AppStrings.textButtonStart,
      backgroundColor: AppColors.colorButton,
      borderRadius: BorderRadius.circular(15).r,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      minimumSizeHeight: 46,
      minimumSizeWith: 295,
      textColor: AppColors.textButton,
    );
  }
}
