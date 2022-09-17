import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_board/constants/strings.dart';
import 'package:flutter_board/controller/sign_up_controller.dart';
import 'package:flutter_board/view/sign_up.dart';

import '../themes/colors.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField({
    Key? key,
    required this.formKey,
    required this.controller,
    this.radius = const BorderRadius.all(Radius.circular(10.0)),
    this.textColor = Colors.red,
    this.hintText = "",
    this.hintTextStyle = const TextStyle(fontSize: 13),
    this.fieldType = TextFieldType.email,
    this.isPassword = false,
    this.maxLength = 16,
    this.onChanged,
    this.validator
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final SignUpController controller;
  final BorderRadius radius;
  final Color textColor;
  final String hintText;
  final TextStyle hintTextStyle;
  final TextFieldType fieldType;
  final bool isPassword;
  final int maxLength;
  final FormFieldValidator? onChanged;
  final FormFieldValidator? validator;

  @override
  State<LoginTextField> createState() => _CustomTextField();
}

class _CustomTextField extends State<LoginTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
        key: widget.formKey,
        child: TextFormField(
          onChanged: (text) {
            if (widget.fieldType == TextFieldType.email) {
              widget.controller.emailAddress = text;
            } else if (widget.fieldType == TextFieldType.password) {
              widget.controller.password = text;
            } else {
              widget.controller.passwordConfirm = text;
            }
          },
          validator: (value) {
            if (widget.fieldType == TextFieldType.email) {
              String pattern =
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
              RegExp regex = RegExp(pattern);
              if (value == null || value.isEmpty) {
                return strMustEnterSomething;
              }
              if (!regex.hasMatch(value)) {
                return strEnterValidEmail;
              } else {
                return null;
              }
            } else if (widget.fieldType == TextFieldType.password) {
              if (value == null || value.length < 8) {
                return strPasswordTooShort;
              } else {
                return null;
              }
            } else {
              if (value != widget.controller.password) {
                return strPasswordNotMatch;
              } else {
                return null;
              }
            }
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.fieldType != TextFieldType.email ? 16 : 50),
          ],
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorLightBlue, width: 3),
                  borderRadius: widget.radius),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 3),
                  borderRadius: widget.radius),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 3),
                  borderRadius: widget.radius),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorGrey, width: 1),
              ),
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
              contentPadding: const EdgeInsets.all(10)),
          obscureText: widget.fieldType != TextFieldType.email,
        ));
  }
}
