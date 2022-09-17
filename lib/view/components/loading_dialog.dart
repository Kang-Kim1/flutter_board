
import 'package:flutter/material.dart';
import 'package:flutter_board/view/components/base_components.dart';
import 'package:flutter_board/view/themes/font_styles.dart';

class LoadingDialog {
  bool _isDialogPopup = false;

  static final LoadingDialog _instance = LoadingDialog._internal();

  factory LoadingDialog(){
    return _instance;
  }

  LoadingDialog._internal() {
    _isDialogPopup = false;
  }

  void show(BuildContext context, String title) {
    if (_isDialogPopup == false) {
      _isDialogPopup = true;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: const BorderRadius.all(Radius.circular(14.0))
                  ),
                  width: 150,
                  height: 150,
                  child: Column(
                    children: [
                      BaseComponent.heightSpace(30),
                      const CircularProgressIndicator(),
                      Expanded(child: Container()),
                      Text(
                        title,
                        style: textStyle15White(),
                        textAlign: TextAlign.center,
                      ),
                      BaseComponent.heightSpace(30),
                    ],
                  ),
                ),
              ),
            );
          }
      );
    }
  }

  void close(BuildContext context) {
    if (_isDialogPopup) {
      _isDialogPopup = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}