import 'package:flutter/material.dart';
import 'package:flutter_board/view/themes/colors.dart';
import 'package:flutter_board/view/themes/font_styles.dart';

import '../../constants/strings.dart';

class BaseComponent {
  static Widget heightSpace(double height) {
    return SizedBox(width: double.infinity, height: height);
  }

  static Widget widthSpace(double width) {
    return SizedBox(width: width);
  }

  static Widget bottomElevatedButton({
    required String text, required VoidCallback callBack,
    Key? key, Color? primary, Color? onPrimary, Color? borderColor, TextStyle? textStyle}) {
    return ElevatedButton(
        key: key,
        onPressed: callBack,
        style: ElevatedButton.styleFrom(
            primary: primary ?? colorWhite,
            onPrimary: onPrimary ?? colorThemeBlue,
            padding: const EdgeInsets.all(10.0),
            textStyle: textStyle ?? textStyle20Black(),
            side: BorderSide(
                width: 3.0,
                color: borderColor ?? colorThemeBlue
            )
        ),
        child: Text(text)
    );
  }

  static Widget avatarIcon({required String userName, double? radius}) {
    return CircleAvatar(
      radius: radius ?? 30,
      backgroundColor: colorThemeBlue,
      child: CircleAvatar(
        radius: radius == null ? 25 : (radius - 5.0),
        backgroundColor: colorWhite,
        child: Text(userName.length < 3 ? ''
          : userName.substring(0, 2)))
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarWithMsg(
      {required BuildContext context, required String msg}) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: SizedBox(height: 50, child: Text(msg, style: textStyle20SnackBar()))));
  }

  static Future<bool?> showCustomDialog(
      {required BuildContext context, required String contents, String? leftBtnText, String? rightBtnText,
        VoidCallback? leftBtnCallback, required VoidCallback rightBtnCallback}) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(contents),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              if (leftBtnCallback == null) {
                Navigator.pop(context)
              } else {
                leftBtnCallback.call()
              }
            },
            child: Text(leftBtnText ?? strCancel),
          ),
          TextButton(
            onPressed: () => {
              rightBtnCallback.call()
            },
            child: Text(rightBtnText ?? strOk),
          ),
        ],
      ),
    );
  }
}
