import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserProvider with ChangeNotifier {
  SharedPreferences pref;
  UserProvider(this.pref);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _nameOtherUser;

  String? get nameOtherUser => _nameOtherUser;

  void setNameOtherUser(String nameOtherUser) {
    _nameOtherUser = nameOtherUser;
    notifyListeners();
  }

  Stream<List<UserChat>> getListFriendUser() {
    return _firestore
        .collection('users')
        .where('uid', isNotEqualTo: pref.getString('userId'))
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return UserChat.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
