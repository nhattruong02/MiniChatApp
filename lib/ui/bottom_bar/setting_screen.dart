import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late AuthProvider authProvider;
  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitlePage(),
            _buildInfoUser(),
            _buildMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitlePage() {
    return Container(
      margin: const EdgeInsets.only(top: 28, left: 20).w,
      child: Text(
        "Setting",
        style: GoogleFonts.urbanist(
            fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoUser() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20).w,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 70.h,
              width: 70.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
              ),
              child: const Center(
                child: Icon(Icons.person),
              )),
          20.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authProvider.currentUser!.displayName.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              10.verticalSpace,
              Text(
                authProvider.currentUser!.email.toString(),
                style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              // Spacer(),
            ],
          ),
          const Spacer(),
          const Icon(
            CupertinoIcons.right_chevron,
            size: 20,
          )
        ],
      ),
    );
  }

  Widget _buildMenu() {
    return Column(
      children: [
        _buildItemMenu(icon: Icons.perm_identity, title: "Account"),
        _buildItemMenu(icon: Icons.chat_bubble_outline, title: "Chats"),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        _buildItemMenu(icon: Icons.light_mode, title: "Appereance"),
        _buildItemMenu(icon: Icons.notifications_none, title: "Notification"),
        _buildItemMenu(icon: Icons.privacy_tip_outlined, title: "Privacy"),
        _buildItemMenu(icon: Icons.folder_open, title: "Data Usage"),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        _buildItemMenu(icon: Icons.help_outline, title: "Help"),
        _buildItemMenu(
            icon: Icons.email_outlined, title: "Invite Your Friends"),
        _buildItemMenu(
          icon: Icons.logout,
          title: "Logout",
          onPressed: () async {
            await Provider.of<AuthProvider>(context, listen: false).logout();
            Navigator.pushReplacementNamed(context, '/login');
          },
        )
      ],
    );
  }

  Widget _buildItemMenu(
      {required IconData icon,
      required String title,
      VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20).w,
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              size: 20.w,
            ),
            20.horizontalSpace,
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.right_chevron,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
