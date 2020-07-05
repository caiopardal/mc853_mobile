import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String id;
  String name;
  String local;
  String description;
  String mapImageName;
  List<String> speakers;
  List<String> confirmations;
  Timestamp time;

  Activity({
    this.id,
    this.name,
    this.local,
    this.mapImageName,
    this.description,
    this.speakers,
    this.time,
    this.confirmations,
  });
}
