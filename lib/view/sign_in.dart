import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_board/constants/keys.dart';
import 'package:flutter_board/constants/routes.dart';
import 'package:flutter_board/constants/strings.dart';
import 'package:flutter_board/controller/sign_in_controller.dart';
import 'package:flutter_board/view/components/base_components.dart';
import 'package:flutter_board/view/components/custom_text_field.dart';
import 'package:flutter_board/view/components/loading_dialog.dart';
import 'package:flutter_board/view/themes/colors.dart';
import 'package:flutter_board/view/themes/font_styles.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key = kSignInPage});

  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  final _controller = Get.put(SignInController());
  final _loadingDialog = LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
              child: Positioned(
                top: 60,
                left: 1,
                right: 1,
                child: SizedBox(height: 150,child: Image.asset('assets/images/logo.png', fit: BoxFit.fitHeight,))
              )
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(strSignIn.toUpperCase(),
                style: textStyle40BoldWithColor(textColor: colorThemeBlue)),
            BaseComponent.heightSpace(20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                    key: kSignInEmailTextField,
                    formKey: _emailFormKey,
                    maxLength: 40,
                    onChanged: (text) {
                      _controller.emailAddress = text;
                    },
                    validator: (text) {
                      String pattern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      RegExp regex = RegExp(pattern);
                      if (text == null || text.isEmpty) {
                        return strMustEnterSomething;
                      } else if (!regex.hasMatch(text)) {
                        return strEnterValidEmail;
                      } else {
                        return null;
                      }
                    },
                    hintText: strEnterEmail)),
            BaseComponent.heightSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomTextField(
                  key: kSignInPasswordTextField,
                  formKey: _passwordFormKey,
                  onChanged: (text) {
                    _controller.password = text;
                  },
                  validator: (text) {
                    if (text == null || text.length < 8) {
                      return strPasswordTooShort;
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  hintText: strEnterPassword)),
            BaseComponent.heightSpace(10),
            // Checkbox(value: T, onChanged: onChanged),
            BaseComponent.heightSpace(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BaseComponent.bottomElevatedButton(
                  text: strSignUp,
                  callBack: () {
                    Get.toNamed(routeSignUpPage);
                  }),
                BaseComponent.bottomElevatedButton(
                  key: kSignInLogInButton,
                  text: strLogin,
                  onPrimary: colorWhite,
                  primary: colorThemeBlue,
                  borderColor: colorThemeBlue,
                  callBack: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _loadingDialog.show(context, "$strLoggingIn...");
                    final isEmailValid = _emailFormKey.currentState!.validate();
                    final isPasswordValid =
                        _passwordFormKey.currentState!.validate();
                    if (isEmailValid && isPasswordValid) {
                      await _controller.login(context)
                          .then((_) {
                        _loadingDialog.close(context);
                        Get.toNamed(routeMainList);
                      })
                      .catchError((error, stackTrace) {
                        debugPrint(error.toString());
                      });
                      // ignore: use_build_context_synchronously
                      _loadingDialog.close(context);
                    }
                  })
              ],
            )
          ]
        )
      ]));
  }

}
