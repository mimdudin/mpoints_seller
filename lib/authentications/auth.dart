import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:async';

import '../models/user.dart';

abstract class BaseAuth {
  Future<FirebaseUser> currentUser();
  Future<void> forgotPassword(String email);
  Future<void> signOut();
  Future<FirebaseUser> createUserWithEmailPassword(
      String email, String password);
  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password);
}

class Auth implements BaseAuth {
  DatabaseReference _userRef;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    print(user);
    return user != null ? user : null;
  }

  @override
  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }

  // Firebase with email address and password register
  Future<FirebaseUser> createUserWithEmailPassword(
    String email,
    String password,
  ) async {
    final FirebaseUser user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    // final FirebaseUser currentUser = await firebaseAuth.currentUser();
    // assert(user.uid == currentUser.uid);
    if (user != null)
      // await createFirstUser(
      //     user, firstName, lastName, email, phoneNumber, referralBy);
      await setUidDatabse(
        uid: user.uid,
        email: email,
      );
    else
      print("Failed to sign in with Google.");
    return user;
  }

  // Example code of how to sign in with email and password.
  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) async {
    final FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // final FirebaseUser currentUser = await firebaseAuth.currentUser();
    // assert(user.uid == currentUser.uid);
    if (user != null)
      print("Success login!");
    else
      print("failed to login");
    return user;
  }

  Future<void> setUidDatabse({String uid, String email}) async {
    final Map<String, dynamic> _userData = {
      'address': '',
      'email': email,
      'mailing_address': '',
      'name': '',
      'PIN': '',
      'partner_number': '',
      'phone_number': '',
      'points_rate': 0,
      'registered_name': '',
      'social_rate': 0,
      // 'statements': '',
    };

    _userRef = FirebaseDatabase.instance.reference().child("partners");
    await _userRef.child(uid).set(_userData);
  }

  Future<void> forgotPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      print(e.code);
    }
  }
}
