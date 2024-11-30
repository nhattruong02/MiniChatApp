import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Thêm thư viện ScreenUtil cho kích thước động
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String textTitle;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.textTitle,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20).w,
            child: Text(
              textTitle,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          7.verticalSpace,
          TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20).w,
                  borderSide: BorderSide(
                      color: AppColors.colorBorderTextFormField, width: 2.0.w)),
              errorStyle: GoogleFonts.poppins(
                color: Colors.red,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
