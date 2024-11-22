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
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Athalia Putri',
      'id': '1',
    },
    {
      'title': 'Erlan Sadewa',
      'id': '1',
    },
    {
      'title': 'Erlan Sadewa',
      'id': '1',
    },
    {
      'title': 'Erlan Sadewa',
      'id': '2',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
          IconButton(
              onPressed: () {},
              icon: AssetImageLoader.loadAssetImage("video",
                  fit: BoxFit.fill, height: 18, width: 25)),
          7.horizontalSpace,
          IconButton(
              onPressed: () {},
              icon: AssetImageLoader.loadAssetImage("call",
                  fit: BoxFit.fill, height: 25, width: 25)),
        ],
      ),
    );
  }

  Widget _buildListMessage() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20).w,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            if (items[index]["id"] == "1") {
              return _buildLeftMessage(items[index]["title"]);
            } else {
              return _buildRightMessage(items[index]["title"]);
            }
          },
        ),
      ),
    );
  }

  Widget _buildHorizontalLineAndLabel(String textTime) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            indent: 42.0,
            endIndent: 10.0,
            thickness: 1,
          ),
        ),
        Text(
          textTime,
          style: GoogleFonts.poppins(
              color: AppColors.colorTextMessage,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
        ),
        const Expanded(
          child: Divider(
            indent: 10.0,
            endIndent: 42.0,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildLeftMessage(String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 17).w,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.colorButton, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                  color: AppColors.colorTextMessage,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            width: 58.w,
            height: 21.h,
            margin: const EdgeInsets.symmetric(vertical: 8).w,
            decoration: BoxDecoration(
                color: AppColors.colorBGTimeMessage,
                borderRadius: BorderRadius.circular(7)),
            padding: const EdgeInsets.all(1).w,
            child: Text(
              "16:46",
              style: GoogleFonts.poppins(
                  color: AppColors.colorTextTime,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRightMessage(String message) {
    return Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 17).w,
                decoration: BoxDecoration(
                  color: AppColors.colorButton,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                )),
            Container(
              width: 58.w,
              height: 21.h,
              margin: const EdgeInsets.symmetric(vertical: 8).w,
              decoration: BoxDecoration(
                  color: AppColors.colorBGTimeMessage,
                  borderRadius: BorderRadius.circular(7)),
              padding: const EdgeInsets.all(1).w,
              child: Center(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    "16:50",
                    style: GoogleFonts.poppins(
                        color: AppColors.colorTextTime,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  7.horizontalSpace,
                  AssetImageLoader.loadAssetImage("home")
                ]),
              ),
            )
          ],
        ));
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
        child: Row(children: [_buildTextField(), _buildRowIconBottom()]),
      ),
    );
  }

  Widget _buildTextField() {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 45).w,
        child: TextField(
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: "Type here...",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 4).w,
            hintStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 17.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Widget _buildRowIconBottom() {
    return Row(
      children: [
        AssetImageLoader.loadAssetImage("camera",
            width: 25, height: 25, fit: BoxFit.fill),
        20.horizontalSpace,
        AssetImageLoader.loadAssetImage("more",
            width: 25, height: 25, fit: BoxFit.fill),
        20.horizontalSpace,
        AssetImageLoader.loadAssetImage("voice",
            width: 25, height: 31, fit: BoxFit.fill),
        20.horizontalSpace,
      ],
    );
  }
}
