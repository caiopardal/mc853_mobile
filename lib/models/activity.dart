import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String id;
  String name;
  String location;
  int maxCapacity;
  bool preRegistration;
  String description;
  String type;
  bool visible;
  List<String> speakers;
  List<String> confirmations;
  Timestamp lastUpdate;
  String startDate;
  String startTime;

  Activity({
    this.id,
    this.name,
    this.location,
    this.maxCapacity,
    this.preRegistration,
    this.lastUpdate,
    this.visible,
    this.startTime,
    this.startDate,
    this.type,
    this.description,
    this.speakers,
    this.confirmations,
  });
}
