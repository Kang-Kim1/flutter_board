
import 'package:flutter/material.dart';
import 'package:flutter_board/utilities/auth_manager.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get to => Get.find();

  var emailAddress = '';
  var password = '';
  var passwordConfirm = '';
  var userName = '';

  Future<void> createUser(BuildContext context) async {
    await AuthManager.createUser(context, emailAddress, password, userName);
  }
}