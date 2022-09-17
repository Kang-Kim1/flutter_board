import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_board/constants/routes.dart';
import 'package:flutter_board/utilities/auth_manager.dart';
import 'package:flutter_board/view/main_list.dart';
import 'package:flutter_board/view/sign_in.dart';
import 'package:flutter_board/view/sign_up.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthManager.listenUserChanges();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Twitter app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => SignIn()
        ),
        GetPage(
            name: routeSignInPage,
            page: () => SignIn()
        ),
        GetPage(
          name: routeSignUpPage,
          page: () => SignUp()
        ),
        GetPage(
            name: routeMainList,
            page: () => MainList()
        )
      ]
    );
  }
}
