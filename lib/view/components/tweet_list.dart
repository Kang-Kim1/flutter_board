import 'package:flutter/material.dart';
import 'package:flutter_board/controller/tweet_list_controller.dart';
import 'package:flutter_board/view/components/tweet_card.dart';
import 'package:get/get.dart';

import '../../network/repository/twitter_repository.dart';

class TweetList extends StatelessWidget {
  TweetList({Key? key}) : super(key: key);
  final _controller = Get.put(TweetListController(twitterRepository: FireStoreTwitterRepository()));

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: _controller.twitList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              TweetCard(
                tweetItem: _controller.twitList[index]
              )
            ],
          );
        }
      );
    });

    //
    // return StreamBuilder<QuerySnapshot>(
    //   stream: controller.getAllTweet(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text(snapshot.error.toString());
    //     }
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Text(strLoading);
    //     }
    //     return ListView(
    //       shrinkWrap: true,
    //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //         TweetItem model =
    //             TweetItem.fromJson(document.data()! as Map<String, dynamic>, document.id);
    //         return Column(
    //           children:[
    //             TweetCard(
    //               tweetItem: model),
    //           ]);
    //       }).toList(),
    //     );
    //   },
    // );toList
  }
}
