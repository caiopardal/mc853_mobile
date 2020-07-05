import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/models/announcement.dart';
import 'package:inscritus/models/speaker.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  static final CollectionReference eventsCollection =
      Firestore.instance.collection('events');

  final CollectionReference speakersCollection =
      eventsCollection.document('1j2gFffXiROT5NLe0G5O').collection('speakers');

  final CollectionReference announcementsCollection = eventsCollection
      .document('1j2gFffXiROT5NLe0G5O')
      .collection('announcements');

  final CollectionReference activitiesCollection = eventsCollection
      .document('1j2gFffXiROT5NLe0G5O')
      .collection('activities');

  // speakers list from snapshot
  List<Speaker> _speakerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Speaker(
        name: doc.data['name'] ?? '',
        id: doc.data['id'] ?? '',
        activity: doc.data['activity'] ?? '',
        description: doc.data['description'] ?? '',
        imageURL: doc.data['imageURL'] ?? '',
        facebookURL: doc.data['facebookURL'] ?? '',
        githubURL: doc.data['githubURL'] ?? '',
        linkedinURL: doc.data['linkedinURL'] ?? '',
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

  static Future<bool> checkIfEmailIsAlreadyConfirmed(
      String docID, String email) async {
    bool exists = false;
    try {
      await Firestore.instance
          .document("events/1j2gFffXiROT5NLe0G5O/activities/$docID")
          .get()
          .then((doc) {
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

  static Future<void> registerANewEmail(String docID, String email) async {
    List emails = [];
    emails.add(email);
    try {
      await Firestore.instance
          .document("events/1j2gFffXiROT5NLe0G5O/activities/$docID")
          .updateData({"confirmations": FieldValue.arrayUnion(emails)});
    } catch (e) {
      return false;
    }
  }
}
