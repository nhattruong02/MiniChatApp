import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/message.dart';

class MessageProvider with ChangeNotifier {
  SharedPreferences pref;
  MessageProvider(this.pref);
  DatabaseReference ref = FirebaseDatabase.instance.ref("message");

  Stream<List<Message>> getListMessage(String? idChatRoom) {
    return ref.orderByChild('chatId').equalTo(idChatRoom).onValue.map((event) {
      List<Message> messages = [];
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          data.forEach((key, value) {
            if (value is Map<dynamic, dynamic>) {
              messages.add(Message.fromJson(Map<String, dynamic>.from(value)));
            }
          });
        }
      }
      messages.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
      return messages;
    });
  }

  Future<void> sendMessage(
      {required String content, required String idChatRoom}) async {
    try {
      String? senderId = pref.getString('userId');
      Message message = Message(
          chatId: idChatRoom,
          type: "text",
          content: content,
          isRead: false,
          senderId: senderId,
          timestamp: Timestamp.now().millisecondsSinceEpoch);
      await ref.push().set(message.toJson());

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chat_room')
          .where('id', isEqualTo: idChatRoom)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming you want to update the first matching document
        await querySnapshot.docs.first.reference.update({
          'lastMessage.content': content,
          'lastMessage.timestamp': Timestamp.now(),
        });
      }
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}
