import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichatapp/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../model/user.dart';
import '../../provider/chat_provider.dart';
import '../../utils/utilities.dart';

class TabBarFriendScreen extends StatefulWidget {
  const TabBarFriendScreen({super.key});

  @override
  State<TabBarFriendScreen> createState() => _TabBarFriendScreenState();
}

class _TabBarFriendScreenState extends State<TabBarFriendScreen> {
  late UserProvider friendProvider;
  @override
  Widget build(BuildContext context) {
    friendProvider = Provider.of<UserProvider>(context);
    final chatRoomProvider = Provider.of<ChatProvider>(context, listen: false);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 23).w,
      child: StreamBuilder<List<UserChat>>(
          stream: friendProvider.getListFriendUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container();
            }
            final friends = snapshot.data!;
            return ListView.builder(
              itemCount: friends.length,
              itemBuilder: (BuildContext context, int index) {
                final friend = friends[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 32).w,
                  child: lineFriend(
                      id: friend.uid!,
                      name: friend.displayName!,
                      status: friend.status!,
                      chatProvider: chatRoomProvider),
                );
              },
            );
          }),
    );
  }

  Widget lineFriend({
    required String name,
    required bool status,
    required String id,
    IconData? icon,
    String? numberMessage,
    ChatProvider? chatProvider,
  }) {
    return GestureDetector(
      onTap: () {
        friendProvider.setNameOtherUser(name);
        chatProvider!.createChatRoom(id);
      },
      child: Container(
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
                    child: Utilities.loadAssetImage("splash")),
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
                      Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: status ? Colors.green : Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2).w,
                        child: Text(
                          status ? "Online" : "Offline",
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
            ],
          ),
        ),
      ),
    );
  }
}
