import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minichatapp/model/chatroom.dart';
import 'package:minichatapp/provider/user_provider.dart';
import 'package:minichatapp/utils/colors.dart';
import 'package:minichatapp/utils/utilities.dart';
import 'package:provider/provider.dart';

import '../../provider/chat_provider.dart';

class TabBarChatScreen extends StatefulWidget {
  const TabBarChatScreen({super.key});

  @override
  State<TabBarChatScreen> createState() => _TabBarChatScreenState();
}

class _TabBarChatScreenState extends State<TabBarChatScreen> {
  @override
  Widget build(BuildContext context) {
    final chatRoomProvider = Provider.of<ChatProvider>(context);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 23).w,
      child: StreamBuilder<List<ChatRoom>>(
          stream: chatRoomProvider.getChatRoom(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container();
            }
            final chatrooms = snapshot.data!;
            return ListView.builder(
              itemCount: chatrooms.length,
              itemBuilder: (BuildContext context, int index) {
                final chatroom = chatrooms[index];
                return Padding(
                    padding: const EdgeInsets.only(bottom: 32).w,
                    child: FutureBuilder<String>(
                        future: chatRoomProvider
                            .getNameUserByChatRoom(chatroom.participants!),
                        builder: (context, userNameSnapshot) {
                          if (userNameSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            const Center(child: CircularProgressIndicator());
                          }
                          if (userNameSnapshot.hasError) {
                            return Text('Error: ${userNameSnapshot.error}');
                          }
                          final otherUserName = userNameSnapshot.data ?? "";
                          return lineChatRoom(
                              idChatRoom: chatroom.id!,
                              nameUser: otherUserName,
                              lastMessage:
                                  chatroom.lastMessage!.content.toString(),
                              time: Utilities.formatTimestamp(
                                  chatroom.lastMessage!.timestamp),
                              unreadCount: chatroom.unreadCount!);
                        }));
              },
            );
          }),
    );
  }

  Widget lineChatRoom({
    required int unreadCount,
    required String idChatRoom,
    required String nameUser,
    required String lastMessage,
    required String time,
    IconData? icon,
    String? numberMessage,
  }) {
    return GestureDetector(
      onTap: () {
        Provider.of<ChatProvider>(context, listen: false)
            .setSelectedId(idChatRoom);
        Provider.of<UserProvider>(context, listen: false)
            .setNameOtherUser(nameUser);
        Navigator.pushNamed(context, '/chat');
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
                    nameUser,
                    style: GoogleFonts.poppins(
                        color: AppColors.colorTextNameChat,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  6.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(left: 2).w,
                    child: Text(
                      lastMessage,
                      style: GoogleFonts.poppins(
                          color: AppColors.colorTextChat,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400),
                    ),
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
                    unreadCount != 0
                        ? Container(
                            width: 26.w,
                            height: 26.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF771F98)),
                            child: Center(
                              child: Text(unreadCount.toString(),
                                  style: GoogleFonts.poppins(
                                      color: AppColors.colorNumberMessage,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ),
                          )
                        : Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
