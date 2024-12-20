import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minichatapp/ui/bottom_bar/add_user_screen.dart';
import 'package:minichatapp/ui/bottom_bar/home_screen.dart';
import 'package:minichatapp/ui/bottom_bar/setting_screen.dart';

import '../../constants/colors.dart';
import '../../utils/utilities.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const AddUserScreen(),
    const SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SizedBox(
          height: 85.h,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(18).r,
              topLeft: const Radius.circular(18).r,
            ),
            child: BottomNavigationBar(
                currentIndex: selectedIndex,
                backgroundColor: AppColors.colorBGBar,
                onTap: (value) {
                  setState(() {});
                  selectedIndex = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Utilities.loadAssetImage("home"), label: ""),
                  BottomNavigationBarItem(
                      icon: Utilities.loadAssetImage("add_user"), label: ""),
                  BottomNavigationBarItem(
                      icon: Utilities.loadAssetImage("setting"), label: ""),
                ]),
          ),
        ),
        body: pages[selectedIndex],
      ),
    );
  }
}
