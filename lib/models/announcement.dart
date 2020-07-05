import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  String id;
  String text;
  Timestamp createdAt;

  Announcement({
    this.id,
    this.text,
    this.createdAt,
  });
}
