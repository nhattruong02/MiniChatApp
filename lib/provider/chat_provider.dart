import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../model/chatroom.dart';

class ChatProvider with ChangeNotifier {
  final SharedPreferences prefs;
  ChatProvider(this.prefs);
  CollectionReference refChatRoom =
      FirebaseFirestore.instance.collection('chat_room');
  String? _idChatRoom;

  String? get idChatRoom => _idChatRoom;

  void setSelectedId(String idChatRoom) {
    _idChatRoom = idChatRoom;
    notifyListeners();
  }

  Stream<List<ChatRoom>> getChatRoom() {
    String? idUser = prefs.getString('userId');
    return refChatRoom
        .where('participants', arrayContains: idUser)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return ChatRoom.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<String> getNameUserByChatRoom(List<String> participants) async {
    String? currentUserId = prefs.getString('userId');
    final otherUserId = participants.firstWhere((uid) => uid != currentUserId);

    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(otherUserId)
        .get();
    return userSnapshot['displayName'] ?? 'Unknown User';
  }

  Future<void> createChatRoom(String idReceiver) async {
    String? idSender = prefs.getString('userId');

    // Query for an existing chat room with both participants
    final querySnapshot =
        await refChatRoom.where('participants', arrayContains: idSender).get();

    // Check if any room exists with both participants
    bool chatRoomExists = false;
    String? existingChatRoomId;
    for (var doc in querySnapshot.docs) {
      final participants = doc['participants'] as List;
      if (participants.contains(idReceiver)) {
        chatRoomExists = true;
        existingChatRoomId = doc.get('id');
        break;
      }
    }
    if (!chatRoomExists) {
      // Create a new ChatRoom object
      ChatRoom newChatRoom = ChatRoom(
        id: refChatRoom.doc().id,
        participants: [idSender!, idReceiver],
        lastMessage: LastMessage(
          content: '',
          timestamp: Timestamp.now(),
        ),
        unreadCount: 0,
      );
      try {
        await refChatRoom.add(newChatRoom.toJson());
        _idChatRoom = refChatRoom.doc().id;
        navKey.currentState?.pushNamed('/chat');
      } catch (e) {
        print('Error creating chat room: $e');
      }
    } else {
      _idChatRoom = existingChatRoomId!;
      navKey.currentState?.pushNamed('/chat');
    }
  }
}
