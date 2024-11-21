import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichatapp/utils/colors.dart';

import '../../utils/asset_image_loader.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.white,
      child: Column(
          children: [_buildTopBar(), _buildListMessage(), _buildBottomBar()]),
    ));
  }

  Widget _buildTopBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomRight: const Radius.circular(18).r,
          bottomLeft: const Radius.circular(18).r),
      child: Container(
        height: 98.h,
        decoration: BoxDecoration(
          color: AppColors.colorBGBar,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 23).w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildIconBack(),
              _buildAvatarUser(),
              _buildColumNameAndStatus(),
              const Spacer(),
              _buildRowIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconBack() {
    return Container(
      padding: const EdgeInsets.only(left: 30).w,
      child: Icon(
        Icons.arrow_back,
        size: 25.sp,
      ),
    );
  }

  Widget _buildAvatarUser() {
    return Padding(
      padding: const EdgeInsets.only(left: 34, right: 13).w,
      child: Container(
          width: 50.w,
          height: 50.h,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: AssetImageLoader.loadAssetImage("splash")),
    );
  }

  Widget _buildColumNameAndStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Robert Fox",
          style: GoogleFonts.poppins(
              color: AppColors.colorTextNameChat,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2).w,
          child: Text(
            "Online",
            style: GoogleFonts.poppins(
                color: AppColors.colorTextChat,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  Widget _buildRowIcon() {
    return Container(
      padding: const EdgeInsets.only(right: 40).w,
      child: Row(
        children: [
          SizedBox(
              width: 25.w,
              height: 18.h,
              child: IconButton(
                  onPressed: () {}, icon: Icon(CupertinoIcons.video_camera))),
          23.horizontalSpace,
          SizedBox(
              width: 25.w,
              height: 25.h,
              child: IconButton(onPressed: () {}, icon: Icon(Icons.call))),
        ],
      ),
    );
  }

  Widget _buildListMessage() {
    return Expanded(child: Container());
  }

  Widget _buildBottomBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18).r,
          topRight: const Radius.circular(18).r),
      child: Container(
        height: 127.h,
        decoration: BoxDecoration(
          color: AppColors.colorBGBar,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4,

              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
