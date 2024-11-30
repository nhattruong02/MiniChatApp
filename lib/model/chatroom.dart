import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  String? id;
  List<String>? participants;
  LastMessage? lastMessage;
  int? unreadCount;

  ChatRoom({this.id, this.participants, this.lastMessage, this.unreadCount});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    participants = (json['participants'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList();
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
    unreadCount = json['unreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['participants'] = this.participants;
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    data['unreadCount'] = this.unreadCount;
    return data;
  }
}

class LastMessage {
  String? content;
  Timestamp? timestamp;

  LastMessage({this.content, this.timestamp});

  LastMessage.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
