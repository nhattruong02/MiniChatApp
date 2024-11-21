import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichatapp/utils/asset_image_loader.dart';
import 'package:minichatapp/utils/colors.dart';

class TabBarChatScreen extends StatefulWidget {
  const TabBarChatScreen({super.key});

  @override
  State<TabBarChatScreen> createState() => _TabBarChatScreenState();
}

class _TabBarChatScreenState extends State<TabBarChatScreen> {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Athalia Putri',
      'message': 'Last seen yesterda y',
      'time': '16.30'
    },
    {
      'name': 'Athalia Putri',
      'message': 'Last seen yesterda y',
      'time': '16.30'
    },
    {
      'name': 'Athalia Putri',
      'message': 'Last seen yesterda y',
      'time': '16.30'
    },
    {
      'name': 'Athalia Putri',
      'message': 'Last seen yesterda y',
      'time': '16.30'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 23).w,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32).w,
            child: lineChat(
                name: items[index]["name"],
                message: items[index]["message"],
                time: items[index]["time"]),
          );
        },
      ),
    );
  }

  Widget lineChat({
    required String name,
    required String message,
    required String time,
    IconData? icon,
    String? numberMessage,
  }) {
    return Container(
      height: 80.h,
      margin: const EdgeInsets.symmetric(horizontal: 22).w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14).r,
          border: Border.all(color: const Color(0xFF771F98), width: 2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9).w,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 13).w,
              child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: AssetImageLoader.loadAssetImage("splash")),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                      color: AppColors.colorTextNameChat,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
                6.verticalSpace,
                Row(
                  children: [
                    AssetImageLoader.loadAssetImage("home",
                        width: 15, height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 2).w,
                      child: Text(
                        message,
                        style: GoogleFonts.poppins(
                            color: AppColors.colorTextChat,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(right: 9).w,
              child: Column(
                children: [
                  Text(
                    time,
                    style: GoogleFonts.poppins(
                        color: AppColors.colorTextChat,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  7.verticalSpace,
                  Container(
                    width: 26.w,
                    height: 26.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF771F98)),
                    child: Center(
                      child: Text("1",
                          style: GoogleFonts.poppins(
                              color: AppColors.colorNumberMessage,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
