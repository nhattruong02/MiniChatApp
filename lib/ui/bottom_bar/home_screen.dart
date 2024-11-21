import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichatapp/ui/tab_bar/tab_bar_call_screen.dart';
import 'package:minichatapp/ui/tab_bar/tab_bar_chat_screen.dart';
import 'package:minichatapp/ui/tab_bar/tab_bar_friend_screen.dart';
import 'package:minichatapp/utils/asset_image_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [_buildSearchBarAndScanIcon(), _buildTabBar()],
      ),
    );
  }

  Widget _buildSearchBarAndScanIcon() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 36, horizontal: 22).w,
      child: Row(
        children: [
          _buildSearchBar(),
          12.horizontalSpace,
          _buildScanIcon(),
        ],
      ),
    );
  }

  Widget _buildScanIcon() {
    return Container(
      width: 43.w,
      height: 39.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).w,
          color: const Color(0xFFF1F1F1)),
      child: AssetImageLoader.loadAssetImage("scan"),
    );
  }

  Widget _buildSearchBar() {
    return Expanded(
      child: SizedBox(
        height: 36.h,
        child: TextField(
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF1F1F1),
            hintText: "Search Chat",
            contentPadding: const EdgeInsets.symmetric(vertical: 4).w,
            hintStyle: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14).w,
                borderSide: BorderSide.none),
            prefixIcon: AssetImageLoader.loadAssetImage("search"),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                color: Colors.white,
                child: TabBar(
                  dividerHeight: 0,
                  indicatorColor: const Color(0xFFF1F1F1),
                  labelStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400),
                  tabs: const [
                    Tab(text: 'Chats'),
                    Tab(text: 'Friends'),
                    Tab(text: 'Calls'),
                  ],
                ),
              ),
              const Expanded(
                  child: TabBarView(children: [
                TabBarChatScreen(),
                TabBarFriendScreen(),
                TabBarCallScreen(),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
