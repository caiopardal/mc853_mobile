import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/models/announcement.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  final CollectionReference speakersCollection =
      Firestore.instance.collection('speakers');

  final CollectionReference announcementsCollection =
      Firestore.instance.collection('announcements');

  final CollectionReference activitiesCollection =
      Firestore.instance.collection('activities');

  // speakers list from snapshot
  List<Speaker> _speakerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Speaker(
        name: doc.data['name'] ?? '',
        id: doc.data['id'] ?? '',
        activities: List.from(doc.data['activities']) ?? '',
        bio: doc.data['bio'] ?? '',
        shortBio: doc.data['shortBio'] ?? '',
        imageURL: doc.data['imageUrl'] ?? '',
        social: Map<String, String>.from(doc.data['social']) ?? '',
      );
    }).toList();
  }

  // get speakers stream
  Stream<List<Speaker>> get speakers {
    return speakersCollection.snapshots().map(_speakerListFromSnapshot);
  }

  // announcement list from snapshot
  List<Announcement> _announcementListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Announcement(
        text: doc.data['text'] ?? '',
        id: doc.data['id'] ?? '',
        createdAt: doc.data['createdAt'] ?? '',
      );
    }).toList();
  }

  // get announcements stream
  Stream<List<Announcement>> get announcements {
    return announcementsCollection
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(_announcementListFromSnapshot);
  }

  // activities list from snapshot
  List<Activity> _activitiesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      // print(doc.data);
      return Activity(
        name: doc.data['name'] ?? '',
        id: doc.data['id'] ?? '',
        local: doc.data['local'] ?? '',
        description: doc.data['description'] ?? '',
        speakers: List.from(doc.data['speakers']) ?? '',
        time: doc.data['time'] ?? '',
        mapImageName: doc.data['mapImageName'] ?? '',
      );
    }).toList();
  }

  // get activities stream
  Stream<List<Activity>> get activities {
    return activitiesCollection.snapshots().map(_activitiesListFromSnapshot);
  }

  // users list from snapshot
  List<User> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      // print(doc.data);
      return User(
        name: doc.data['name'] ?? '',
        uid: doc.data['uid'] ?? '',
        cpf: doc.data['cpf'] ?? '',
        email: doc.data['email'] ?? '',
        phone: doc.data['phone'] ?? '',
        createdAt: doc.data['createdAt'] ?? '',
        lastUpdate: doc.data['lastUpdate'] ?? '',
        isActive: doc.data['isActive'] ?? false,
        isAdmin: doc.data['isAdmin'] ?? false,
        emailVerified: doc.data['emailVerified'] ?? false,
      );
    }).toList();
  }

  // get users stream
  Stream<List<User>> get users {
    return usersCollection.snapshots().map(_usersListFromSnapshot);
  }

  static Future<bool> checkIfEmailIsAlreadyConfirmed(
      String docID, String email) async {
    bool exists = false;
    try {
      await Firestore.instance.document("activities/$docID").get().then((doc) {
        print(doc.data);
        if (doc.data['confirmations'] != null) {
          var confirmedList = List.from(doc.data['confirmations']);

          if (confirmedList.contains(email)) {
            exists = true;
          } else {
            exists = false;
          }
        }
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static Future<void> confirmAnEmailToActivity(
      String docID, String email) async {
    List emails = [];
    emails.add(email);
    try {
      await Firestore.instance
          .document("activities/$docID")
          .updateData({"confirmations": FieldValue.arrayUnion(emails)});
    } catch (e) {
      return false;
    }
  }

  static Future<List<Activity>> getActivitiesByIds(List<String> docsIDs) async {
    try {
      List<Activity> activities;
      print("DOCS: $docsIDs");
      docsIDs.forEach((id) async {
        var activity = await getActivityById(id);
        activities.add(activity);
      });
      return activities;
    } catch (e) {
      return null;
    }
  }

  static Future<Activity> getActivityById(String docID) async {
    try {
      Activity activity;
      print("docID: $docID");

      await Firestore.instance.document("activities/$docID").get().then((doc) {
        print(doc.data);
        activity = Activity(
          name: doc.data['name'] ?? '',
          id: doc.data['id'] ?? '',
          local: doc.data['local'] ?? '',
          description: doc.data['description'] ?? '',
          speakers: List.from(doc.data['speakers']) ?? '',
          time: doc.data['time'] ?? '',
          mapImageName: doc.data['mapImageName'] ?? '',
        );
      });

      return activity;
    } catch (e) {
      return null;
    }
  }
}
