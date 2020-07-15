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

  final CollectionReference feedCollection =
      Firestore.instance.collection('feed');

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
        message: doc.data['message'] ?? '',
        title: doc.data['title'] ?? '',
        id: doc.data['id'] ?? '',
        postedAt: doc.data['postedAt'] ?? '',
        lastUpdate: doc.data['lastUpdate'] ?? '',
        publisher: Map<String, String>.from(doc.data['publisher']) ?? '',
      );
    }).toList();
  }

  // get announcements stream
  Stream<List<Announcement>> get announcements {
    return feedCollection
        .orderBy("lastUpdate", descending: true)
        .snapshots()
        .map(_announcementListFromSnapshot);
  }

  // activities list from snapshot
  List<Activity> _activitiesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
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
      List<Activity> activities = [];
      docsIDs.forEach((id) async {
        var activity = await getActivityById(id);
        activities.add(activity);
      });
      return activities;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Activity> getActivityById(String docID) async {
    try {
      Activity activity;

      await Firestore.instance.document("activities/$docID").get().then((doc) {
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
      print(e);
      return null;
    }
  }

  static Future<User> getUserById(String docID) async {
    try {
      User user;

      await Firestore.instance.document("users/$docID").get().then((doc) {
        user = User(
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
      });

      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Speaker>> getSpeakers() async {
    try {
      List<Speaker> speakers = [];
      QuerySnapshot querySnapshot =
          await Firestore.instance.collection("speakers").getDocuments();
      for (int i = 0; i < querySnapshot.documents.length; i++) {
        var doc = querySnapshot.documents[i];
        Speaker speaker = Speaker(
          name: doc.data['name'] ?? '',
          id: doc.data['id'] ?? '',
          activities: List.from(doc.data['activities']) ?? '',
          bio: doc.data['bio'] ?? '',
          shortBio: doc.data['shortBio'] ?? '',
          imageURL: doc.data['imageUrl'] ?? '',
          social: Map<String, String>.from(doc.data['social']) ?? '',
        );

        speakers.add(speaker);
      }

      return speakers;
    } catch (e) {
      return null;
    }
  }

  static Future<List<String>> getUserActivitiesIds(String docID) async {
    try {
      List<String> ids = [];

      QuerySnapshot querySnapshot = await Firestore.instance
          .document("users/$docID")
          .collection("activities")
          .getDocuments();
      for (int i = 0; i < querySnapshot.documents.length; i++) {
        var doc = querySnapshot.documents[i];
        ids.add(doc.documentID);
      }

      return ids;
    } catch (e) {
      return null;
    }
  }
}
