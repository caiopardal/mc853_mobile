import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  String id;
  String message;
  String title;
  Map<String, String> publisher;
  Timestamp postedAt;
  Timestamp lastUpdate;

  Announcement({
    this.id,
    this.message,
    this.title,
    this.publisher,
    this.lastUpdate,
    this.postedAt,
  });
}
