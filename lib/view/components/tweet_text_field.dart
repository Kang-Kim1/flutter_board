import 'package:flutter/material.dart';
import 'package:flutter_board/constants/keys.dart';
import 'package:flutter_board/constants/strings.dart';
import 'package:flutter_board/controller/tweet_list_controller.dart';
import 'package:flutter_board/view/components/base_components.dart';
import 'package:flutter_board/view/themes/colors.dart';
import 'package:flutter_board/view/themes/font_styles.dart';
import 'package:get/get.dart';

class TweetTextField extends StatefulWidget {
  const TweetTextField({Key? key}) : super(key: key);

  @override
  State<TweetTextField> createState() => TweetTextFieldState();
}

class TweetTextFieldState extends State<TweetTextField> {
  final _controller = Get.find<TweetListController>();
  final _etController = TextEditingController();
  bool isVisible = true;

  @override
  void dispose() {
    super.dispose();
    _etController.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Visibility(
       key: kMainListVisibility,
       visible: isVisible,
       child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.blue,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(strShareYourStory,
                  style: textStyle40BoldWithColor(
                      textColor: colorThemeBlue)),
              TextFormField(
                key: kMainListTextField,
                autofocus: true,
                maxLength: 280,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: strEnterStories
                ),
                controller: _etController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: BaseComponent.bottomElevatedButton(
                      text: strLater,
                      textStyle: textStyle15White(),
                      callBack: () {
                        setState(() {
                          isVisible = false;
                        });
                      })),
                  BaseComponent.widthSpace(20),

                  Expanded(child: BaseComponent.bottomElevatedButton(
                    key: kMainListPostButton,
                    text: strPost,
                    onPrimary: colorWhite,
                    primary: colorThemeBlue,
                    borderColor: colorThemeBlue,
                    textStyle: textStyle15White(),
                    callBack: () {
                      _controller.post(_etController.text)
                        .then((_) => {
                          setState(() {
                            _etController.clear();
                            isVisible = false;
                          }),
                          BaseComponent.snackBarWithMsg(context: context, msg: strPosted)
                        })
                            .onError((error, stackTrace) => {
                          BaseComponent.snackBarWithMsg(context: context, msg: '$strErrorPosting ${error.toString()}')
                        });
                    })),
                ],
              )
            ],
          )
    ));
  }
}
