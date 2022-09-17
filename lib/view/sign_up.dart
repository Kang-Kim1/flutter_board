import 'package:flutter/material.dart';
import 'package:flutter_board/constants/keys.dart';
import 'package:flutter_board/constants/routes.dart';
import 'package:flutter_board/constants/strings.dart';
import 'package:flutter_board/controller/sign_up_controller.dart';
import 'package:flutter_board/view/components/base_components.dart';
import 'package:flutter_board/view/components/custom_text_field.dart';
import 'package:flutter_board/view/components/loading_dialog.dart';
import 'package:flutter_board/view/themes/colors.dart';
import 'package:flutter_board/view/themes/font_styles.dart';
import 'package:get/get.dart';

enum TextFieldType { email, password, passwordConfirm }

class SignUp extends StatelessWidget {
  SignUp({super.key = kSignUpPage});

  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _passwordConformFormKey = GlobalKey<FormState>();
  final _userNameFormKey = GlobalKey<FormState>();
  final _controller = Get.put(SignUpController());
  final _loadingDialog = LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(strSignUp.toUpperCase(),
            style: textStyle40BoldWithColor(textColor: colorThemeBlue)),
        BaseComponent.heightSpace(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextField(
            key: kSignUpEmailTextField,
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
            key: kSignUpPasswordTextField,
            formKey: _passwordFormKey,
            onChanged: (text) {
              _controller.password = text;
            },
            validator: (text) {
              if (text == null || text.isEmpty) {
                return strMustEnterSomething;
              } else if (text.length < 8) {
                return strPasswordTooShort;
              } else {
                return null;
              }
            },
            obscureText: true,
            hintText: strEnterPassword)),
        BaseComponent.heightSpace(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextField(
            key: kSignUpPasswordConfirmTextField,
            formKey: _passwordConformFormKey,
            onChanged: (text) {
              _controller.passwordConfirm = text;
            },
            validator: (text) {
              if (text != _controller.password) {
                return strPasswordNotMatch;
              } else {
                return null;
              }
            },
            obscureText: true,
            hintText: strEnterPassword)),
        BaseComponent.heightSpace(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomTextField(
              key: kSignUpUserNameTextField,
            formKey: _userNameFormKey,
            onChanged: (text) {
              _controller.userName = text;
            },
            validator: (text) {
              if (text == null || text.isEmpty) {
                return strMustEnterSomething;
              } else if (text.length < 3) {
                return strUserNameTooShort;
              } else {
                return null;
              }
            },
            hintText: strEnterUserName)),
        BaseComponent.heightSpace(30),
        BaseComponent.bottomElevatedButton(
          key: kSignInRegisterButton,
          text: strRegister,
          callBack: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            _loadingDialog.show(context, "$strRegistering...");
            final isEmailValid = _emailFormKey.currentState!.validate();
            final isPasswordValid = _passwordFormKey.currentState!.validate();
            final isPasswordConfirmValid =
                _passwordConformFormKey.currentState!.validate();
            final isUserNameValid = _userNameFormKey.currentState!.validate();
            if (isEmailValid && isPasswordValid && isPasswordConfirmValid && isUserNameValid) {
              await _controller.createUser(context)
                .then((_) {
                  _loadingDialog.close(context);
                  Get.toNamed(routeMainList);
                })
                .catchError((error, stackTrace) {
                  debugPrint(error.toString());
                });
            }
            // ignore: use_build_context_synchronously
            _loadingDialog.close(context);
          }),
      ],
    ));
  }
}
