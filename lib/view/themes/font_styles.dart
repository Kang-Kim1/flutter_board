
import 'package:flutter/material.dart';
import 'package:flutter_board/view/themes/colors.dart';

TextStyle textStyle15Black() {
  return const TextStyle(
    color: Colors.black,
    fontSize: 15
  );
}

TextStyle textStyle17BlackBold() {
  return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 17
  );
}

TextStyle textStyle15White() {
  return const TextStyle(
      color: Colors.white,
      fontSize: 15
  );
}

TextStyle textStyle20Black() {
  return const TextStyle(
      color: Colors.black,
      fontSize: 20
  );
}

TextStyle textStyle20SnackBar() {
  return TextStyle(
      color: colorBlueSnackBar,
      fontSize: 20
  );
}

// text style for Title
TextStyle textStyle40BoldWithColor({Color? textColor}) {
  return TextStyle(
      color: textColor ?? Colors.black,
      fontSize: 40,
      fontWeight: FontWeight.bold
  );
}