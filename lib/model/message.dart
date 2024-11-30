class Message {
  String? chatId;
  String? senderId;
  String? content;
  String? type;
  int? timestamp;
  bool? isRead;

  Message(
      {this.chatId,
      this.senderId,
      this.content,
      this.type,
      this.timestamp,
      this.isRead});

  Message.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    content = json['content'];
    isRead = json['isRead'];
    senderId = json['senderId'];
    timestamp = json['timestamp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatId'] = this.chatId;
    data['senderId'] = this.senderId;
    data['content'] = this.content;
    data['type'] = this.type;
    data['timestamp'] = this.timestamp;
    data['isRead'] = this.isRead;
    return data;
  }
}
