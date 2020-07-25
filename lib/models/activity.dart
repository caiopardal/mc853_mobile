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
  String endDate;
  String endTime;
  String registrationDate;
  String registrationTime;

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
    this.endDate,
    this.endTime,
    this.registrationDate,
    this.registrationTime,
  });
}
