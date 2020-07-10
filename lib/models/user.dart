import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String phone;
  String cpf;
  String email;
  bool isActive;
  bool isAdmin;
  bool emailVerified;
  Timestamp createdAt;
  Timestamp lastUpdate;

  User({
    this.uid,
    this.name,
    this.phone,
    this.cpf,
    this.email,
    this.isActive,
    this.isAdmin,
    this.emailVerified,
    this.createdAt,
    this.lastUpdate,
  });
}
