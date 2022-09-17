import 'package:flutter/material.dart';
import 'package:flutter_board/constants/keys.dart';
import 'package:flutter_board/constants/strings.dart';
import 'package:flutter_board/controller/tweet_list_controller.dart';
import 'package:flutter_board/model/board_content.dart';
import 'package:flutter_board/utilities/date_formatter.dart';
import 'package:flutter_board/view/components/base_components.dart';
import 'package:flutter_board/view/themes/colors.dart';
import 'package:flutter_board/view/themes/font_styles.dart';
import 'package:get/get.dart';

class TweetCard extends StatefulWidget {
  const TweetCard({required this.tweetItem, Key? key})
      : super(key: key);
  final Content tweetItem;

  @override
  State<TweetCard> createState() => _TweetCardState();
}

class _TweetCardState extends State<TweetCard> {
  var _isEditEnabled = false;
  final TweetListController _controller = Get.find<TweetListController>();
  final _etController = TextEditingController();
  var _currentContents = '';

  @override
  void initState() {
    super.initState();
    _etController.text = widget.tweetItem.contents!;
  }

  @override
  void didUpdateWidget(covariant TweetCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isEditEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
     return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children:[
            BaseComponent.avatarIcon(userName: widget.tweetItem.userName ?? ''),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(widget.tweetItem.userName ?? '', style: textStyle17BlackBold()),
                      Expanded(child: Text(' @ ${DateFormatter.convertTimeStampToString(widget.tweetItem.timeUploaded!)}',
                        overflow: TextOverflow.ellipsis)),
                      if(_controller.currentEmailAddress == widget.tweetItem.userEmail)
                        InkWell(
                          key: kMainListEditButton,
                          child: Icon(Icons.edit,
                              color: colorThemeBlue,
                              size: 20),
                          onTap: () {
                            setState(() {
                              if(_isEditEnabled) {
                                _etController.text = widget.tweetItem.contents!;
                              }
                              _isEditEnabled = !_isEditEnabled;
                            });
                          },
                        ),
                      BaseComponent.widthSpace(10),
                      if(_controller.currentEmailAddress == widget.tweetItem.userEmail)
                        InkWell(
                          key: kMainListDeleteButton,
                          child: Icon(Icons.delete_forever,
                              color: colorRed,
                              size: 20),
                          onTap: () {
                            setState(() {
                              _isEditEnabled = false;
                            });
                            BaseComponent.showCustomDialog(
                                context: context,
                                contents: strConfirmDeletion,
                                rightBtnCallback: () {
                                  _controller.delete(widget.tweetItem.docId!)
                                    .then((_) => {
                                      BaseComponent.snackBarWithMsg(context: context, msg: strDeleted)
                                    })
                                    .onError((error, stackTrace) => {
                                      BaseComponent.snackBarWithMsg(context: context, msg: '$strErrorDeletion ${error.toString()}')
                                  });
                                  Navigator.pop(context);
                                }
                            );
                          },
                        )
                    ]),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child:
                          TextFormField(
                            key: UniqueKey(),
                            enabled: _isEditEnabled,
                            maxLength: 280,
                            keyboardType: TextInputType.multiline,
                            initialValue: widget.tweetItem.contents,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              _currentContents = text;
                            },
                            // controller: _etController,
                          ),
                      ),
                      if (_isEditEnabled)
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_currentContents.isEmpty) {
                                    BaseComponent.snackBarWithMsg(context: context, msg: strMustEnterSomething);
                                  } else {
                                    _controller.edit(widget.tweetItem.docId!, _currentContents)
                                      .then((_) => {
                                        setState(() {
                                          _isEditEnabled = false;
                                        }),
                                        BaseComponent.snackBarWithMsg(context: context, msg: strUpdated)
                                      })
                                      .onError((error, stackTrace) => {
                                        BaseComponent.snackBarWithMsg(context: context, msg: '$strErrorUpdate ${error.toString()}')
                                      });
                                  }
                                },
                                child: Text(strEdit.toUpperCase())
                              )
                          )
                        )
                    ]
                  )
                ]
              )
            ),
          ])
      );
  }
}
