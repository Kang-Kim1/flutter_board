
import 'package:flutter/material.dart';
import 'package:flutter_board/utilities/auth_manager.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.find();

  var emailAddress = '';
  var password = '';

  Future<void> login(BuildContext context) async {
    await AuthManager.login(context, emailAddress, password);
  }
}