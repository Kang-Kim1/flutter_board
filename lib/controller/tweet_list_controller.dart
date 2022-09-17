
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_board/model/board_content.dart';
import 'package:flutter_board/network/repository/twitter_repository.dart';
import 'package:get/get.dart';

class TweetListController extends GetxController {
  static TweetListController get to => Get.find();

  TweetListController({required this.twitterRepository});

  final BoardRepository twitterRepository;
  var currentUserName = '';
  var currentEmailAddress = '';
  var twitList = <Content>[].obs;

  @override
  void onReady() async {
    super.onReady();
    final currUser = FirebaseAuth.instance.currentUser;
    if (currUser != null) {
      currentUserName = currUser.displayName ?? '';
      currentEmailAddress = currUser.email ?? '';
    }
    getAllTweet();
  }

  void getAllTweet() async {
    twitterRepository.getAllTwits().listen((collectionSnapshot) {
      twitList.value = collectionSnapshot.docs.map((DocumentSnapshot docSnapshot) {
        return Content.fromJson(docSnapshot.data()! as Map<String, dynamic>, docSnapshot.id);
      }).toList();
    });

    // await twitterRepository.getAllTwits().listen((data) {
    //   data.docs.map((DocumentSnapshot document) {
    //     print('document ${document.data!}');
    //     TweetItem model =
    //         TweetItem.fromJson(document.data()! as Map<String, dynamic>, document.id);
    //     twitList.add(model);
    //   });
    // });
    // print(twitList);
    // StreamBuilder<QuerySnapshot>(
    //   stream: twitterRepository.getAllTwits(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
  }

  Future<void> post(String contents) async {
    Content tweetItem = Content(
        contents: contents,
        userEmail: currentEmailAddress,
        userName: currentUserName,
        timeUploaded: DateTime.now()
    );
    return twitterRepository.postTweet(entity: tweetItem.toJson());
  }

  Future<void> edit(String docId, String contents) async {
    return twitterRepository.editTweet(docId: docId, contents: contents);
  }


  Future<void> delete(String docId) async {
    return twitterRepository.deleteTweet(docId: docId);
  }
}