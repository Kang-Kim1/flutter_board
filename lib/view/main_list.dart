import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_board/constants/keys.dart';
import 'package:flutter_board/constants/routes.dart';
import 'package:flutter_board/constants/strings.dart';
import 'package:flutter_board/utilities/auth_manager.dart';
import 'package:flutter_board/view/components/base_components.dart';
import 'package:flutter_board/view/components/tweet_list.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'components/tweet_text_field.dart';

class MainList extends StatelessWidget {
  MainList({super.key});

  final _key = GlobalKey<TweetTextFieldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope (
        onWillPop: () async {
          return (await BaseComponent.showCustomDialog(
            context: context,
            contents: strConfirmLogout,
            rightBtnCallback: () async {
              AuthManager.logOut();
              Get.offNamedUntil(routeSignInPage, (route) => false);
            })) ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
          centerTitle: true,
          actions: [
            Padding(padding: const EdgeInsets.all(10),
              child: InkWell(
                key: kMainListAddButton,
                child: const Icon(Icons.add_comment_outlined),
                onTap: () {
                  var currentState = _key.currentState;
                  if (currentState == null) return;
                  if (!currentState.isVisible) {
                    // ignore: invalid_use_of_protected_member
                    currentState.setState(() {
                      currentState.isVisible = true;
                    });
                  }
                },
              )),
          ],
          leading: InkWell(
            child: const Icon(Icons.logout),
            onTap: () {
              BaseComponent.showCustomDialog(
                context: context,
                contents: strConfirmLogout,
                rightBtnCallback: () async {
                  AuthManager.logOut();
                  Get.offNamedUntil(routeSignInPage, (route) => false);
                });
            },
        )),
        body: Column(
          children: [
            TweetTextField(key: _key),
             Expanded(
              child: TweetList(),
             ),
            const Divider()
          ],
        )
      ));
  }
}
