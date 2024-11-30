class UserChat {
  String? email;
  String? displayName;
  String? uid;
  bool? status;

  UserChat({this.email, this.displayName, this.uid});

  UserChat.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    displayName = json['displayName'];
    uid = json['uid'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['displayName'] = this.displayName;
    data['uid'] = this.uid;
    data['status'] = this.status;
    return data;
  }
}
