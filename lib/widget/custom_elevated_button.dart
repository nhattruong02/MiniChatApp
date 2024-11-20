import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Thêm thư viện ScreenUtil cho kích thước động
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final BorderRadiusGeometry? borderRadius;
  final int? minimumSizeWith;
  final int? minimumSizeHeight;
  final FontWeight? fontWeight;

  CustomElevatedButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.borderRadius,
    this.minimumSizeWith,
    this.minimumSizeHeight,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(15).r,
        ),
        backgroundColor: backgroundColor ?? Colors.blue,
        minimumSize: Size(minimumSizeWith!.w, minimumSizeHeight!.h),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: fontSize ?? 20.sp,
          color: textColor ?? Colors.white,
          fontWeight: fontWeight,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
