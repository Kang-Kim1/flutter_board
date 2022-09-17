import 'package:cloud_firestore/cloud_firestore.dart';

class Content {
  String? docId;
  String? contents;
  String? userEmail;
  String? userName;
  DateTime? timeUploaded;

  Content(
      {this.docId,
      this.contents,
      this.userEmail,
      this.userName,
      this.timeUploaded});

  Content.fromJson(Map<String, dynamic> json, this.docId) {
    contents = json['contents'];
    userEmail = json['userEmail'];
    userName = json['userName'];
    timeUploaded = (json['timeUploaded'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contents'] = contents;
    data['userEmail'] = userEmail;
    data['userName'] = userName;
    data['timeUploaded'] = timeUploaded;

    return data;
  }
}
