
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_board/constants/strings.dart';
import 'package:flutter_board/view/components/base_components.dart';

class AuthManager {
  static final AuthManager _instance = AuthManager._internal();

  factory AuthManager() => _instance;

  static bool _isListenerInitialized = false;

  AuthManager._internal() {
    debugPrint("AuthManager created");
  }

  static Future<void> createUser(BuildContext context, String email, String password, String userName) async {
    String errorMsg = '';

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      await userCredential.user?.updateDisplayName(userName);
      await userCredential.user?.reload();
      debugPrint("** User Created");
      debugPrint("email : ${userCredential.user?.email}");
      debugPrint("user name : ${FirebaseAuth.instance.currentUser?.displayName}");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMsg = strPasswordTooWeak;
      } else if (e.code == 'email-already-in-use') {
        errorMsg = strEmailAlreadyInUse;
      } else {
        errorMsg = e.toString();
      }
      BaseComponent.snackBarWithMsg(context: context, msg: errorMsg);
      throw Future.error(errorMsg);
    } catch (e) {
      errorMsg = e.toString();
      BaseComponent.snackBarWithMsg(context: context, msg: errorMsg);
      throw Future.error(errorMsg);
    }
  }

  static Future<void> login(BuildContext context, String email, String password) async {
    String errorMsg = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      debugPrint("** User Loggedin");
      debugPrint("email : ${userCredential.user?.email}");
      debugPrint("user : ${userCredential.user?.displayName}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMsg = strInvalidEmail;
      } else if (e.code == 'wrong-password') {
        errorMsg = strInvalidPassword;
      } else {
        errorMsg = e.toString();
      }
      BaseComponent.snackBarWithMsg(context: context, msg: errorMsg);
      throw Future.error(errorMsg);
    } catch (e) {
      errorMsg = e.toString();
      BaseComponent.snackBarWithMsg(context: context, msg: errorMsg);
      throw Future.error(errorMsg);
    }
  }

  static Future<void> logOut() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  static void listenUserChanges() async {
    if (!_isListenerInitialized) {
      FirebaseAuth.instance.userChanges()
          .listen((user) async {
        if (user == null) {
          debugPrint('User is currently signed out!');
        } else {
          if (user.displayName == null) {
            return;
          }
          debugPrint('User is signed in! ${user.displayName}');
        }
      });
      _isListenerInitialized = true;
    }
  }

  static bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}