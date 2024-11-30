import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minichatapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  AuthProvider(this.prefs, this._firestore, this._auth);

  User? get currentUser => _auth.currentUser;
  bool get isSignedIn => currentUser != null;

  Future<void> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Retrieve user ID after successful login
      String userId = _auth.currentUser?.uid ?? ''; // Get Id

      if (userId.isNotEmpty) {
        prefs.setString('userId', userId); // Store the actual user ID
      }
      navKey.currentState?.pushNamed('/home');
      Fluttertoast.showToast(msg: 'Login success');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Login fail');
    }
    notifyListeners();
  }

  Future<void> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      user?.updateProfile(displayName: name);
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'displayName': name,
        'status': '',
      });
      navKey.currentState?.pushNamed('/login');
      Fluttertoast.showToast(msg: 'Register success');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Register fail');
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }
}
